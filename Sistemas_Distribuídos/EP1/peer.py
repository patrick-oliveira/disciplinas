import socket
import os
import pickle

from threading import Thread, Event


class Peer:
    server_IP = '127.0.0.1'
    server_port = 1099
    
    class DownloadWorker(Thread):
        def __init__(
            self,  
            request_addr,
            peer_addr,
            server_addr,
            file_name,
            folder,
        ):
            super().__init__()
            
            self.request_addr = request_addr
            self.peer_addr = peer_addr
            self.server_addr = server_addr
            self.file_name = file_name
            self.folder = folder
            
        def update(self):
            S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            S.connect(self.server_addr)
            
            S.send((
                "UPDATE"+\
                "&"+\
                f"{self.file_name} {self.peer_addr[0]} {self.peer_addr[1]}"
            ).encode())
            
            while True:
                if S.recv(1024).decode == "UPDATE_OK":
                    break
            
        def run(self):
            S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            S.connect(self.request_addr)
            
            S.send(('DOWNLOAD' + '&' + self.file_name).encode())
            
            with open(f"{self.folder}/{self.file_name}", "wb") as f:
                while True:
                    data = S.recv(1024).decode()
                    
                    if not data:
                        break
                    else:
                        f.write(data)
            print(f"Arquivo {self.file_name} baixado com sucesso na pasta "\
                  f"{self.folder}")
            
            self.update()
            
    class RequestWorker(Thread):
        def __init__(
            self,
            peer_addr,
            folder,
            files
        ):
            super().__init__()
            self.__stop_event = Event()
            self.peer_addr = peer_addr
            
            self.folder = folder
            self.files = files
            
        def stop(self):
            self.__stop_event.set()
            
        def upload(self, conn, file_path: str):
            print(f"uploading {file_path}")
            with open(file_path, "rb") as f:
                conn.sendall(f.read())
            
            conn.close()
             
        def run(self):
            S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
            S.bind(self.peer_addr)
            S.listen(1)
            
            print("Request worker is listening.")
            while True:
                if self.__stop_event.is_set():
                    break
                
                c, addr = S.accept()
                    
                request = c.recv(1024).decode().split("&")
                request_type = request[0]
                request_body = request[1]
                
                print("Recebeu conexão de ", addr)
                
                if request_type == "DOWNLOAD":
                    if request_body in self.files:
                        c.send("AVAILABLE".encode())
                        Thread(
                            target = self.upload, 
                            args=(c, f"{self.folder}/{request_body}")
                        ).start()
                    else:
                        c.send("UNAVAILABLE".encode())
                        c.close()
                        
            print("Finishing")
                
            
    def __init__(
        self,
        ip: str,
        port: int,
        folder: str 
    ):
        self.__set_addr(ip, port, folder)
        
        self.files = os.listdir(folder)
        self.last_search = None
        self.request_worker = None
        
        self.join(ip, port, folder)
       
    def __set_addr(self, ip: str, port: int, folder: str):
        self.addr = (ip, port)
        self.folder = folder
        
    def join(
        self,
        ip,
        port,
        folder,
    ):
        self.__terminate_worker()
        
        self.__set_addr(ip, port, folder)
        
        S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
        S.bind(self.addr)
        
        S.connect((self.server_IP, self.server_port))
        files = " ".join(self.files)
        S.send(("JOIN" + "&" + files).encode())
        while True:
            if S.recv(1024).decode() == "JOIN_OK":
                print("Sou peer {}:{} com arquivos {}".format(
                    self.addr[0], 
                    self.addr[1],
                    files
                ))
                break
            
        self.__wait_for_requests()
        
    def search(self,file_name: str):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as S:
            S.connect((self.server_IP, self.server_port))
            S.send(("SEARCH" + "&" + file_name).encode())

            known_peers = pickle.loads(S.recv(1024))
            print("peers com arquivo solicitado: {}".format(
                ' '.join(f"{ip}:{p}" for ip, p in known_peers)
            ))
            
            self.last_search = file_name
        
    def download(
        self,
        ip: str,
        port: int
    ):
        if self.last_search is not None:
            self.DownloadWorker(
                request_ip = ip,
                request_port = port,
                file_name = self.last_search,
                folder = self.folder,
                peer_ip = self.ip,
                peer_port = self.port,
                server_ip = self.server_IP,
                server_port = self.server_port
            ).start()
        
    def __wait_for_requests(self):
        self.request_worker = self.RequestWorker(
            peer_addr = self.addr,
            folder = self.folder,
            files = self.files
        )
        self.request_worker.start()
        
    def __terminate_worker(self):
        if self.__terminate_worker is not None:
            self.request_worker.stop()

        
if __name__ == "__main__":
    ip, port, folder = tuple(input().split(" "))
    
    peer = Peer(
        ip = ip,
        port = int(port),
        folder = folder
    )
    
    print(
        "1 - JOIN \n"\
        "2 - SEARCH \n"\
        "3 - DOWNLOAD \n"
    )
    
    while True:
        try:
            opt = input()
            opt = opt.split(" ")
            opt, params = opt[0], opt[1:]
            if opt == "1":
                ip, port, folder = tuple(params)
                peer.join(ip, int(port), folder)
            elif opt == "2":
                file_name = params[0]
                peer.search(file_name)
            elif opt == "3":
                ip, port, file_name = tuple(params)
                peer.download(
                    ip,
                    int(port),
                    file_name
                )
        except Exception as e:
            raise e