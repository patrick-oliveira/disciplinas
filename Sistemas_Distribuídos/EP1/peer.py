import socket
import os
import pickle

from threading import Thread
from typing import List, Tuple

class Peer:
    server_IP = '127.0.0.1'
    server_port = 1099
    
    class DownloadWorker(Thread):
        def __init__(
            self,  
            request_ip, 
            request_port, 
            file_name,
            folder
        ):
            super().__init__()
            
            self.request_ip = request_ip
            self.request_port = request_port
            self.file_name = file_name
            self.folder = folder
            
        def download(self):
            S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            S.connect((self.request_ip, self.request_port))
            
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
            
        def run(self):
            thread = Thread(target = self.download)
            thread.start()
            
    class RequestWorker(Thread):
        def __init__(
            self,
            peer_ip,
            peer_port,
            folder,
            files
        ):
            self.peer_ip = peer_ip
            self.peer_port = int(peer_port)
            
            self.folder = folder
            self.files = files
            
        def upload(self, conn, file_path: str):
            with open(file_path, "rb") as f:
                conn.sendall(f.read())
            
            conn.close()
            
        def listen(self):
            S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            S.bind((self.peer_ip, self.peer_port))
            S.listen(1)
            
            while True:
                c, addr = S.accept()
                    
                request = c.recv(1024).decode().split("&")
                request_type = request[0]
                request_body = request[1]
                
                if request_type == "DOWNLOAD":
                    if request_body in self.files:
                        Thread(
                            target = self.upload, 
                            args=(c, f"{self.folder}/{request_body}")
                        ).start()
                    else:
                        pass
                    
            
        def run(self):
            thread = Thread(target = self.listen)
            thread.start()
            
    def __init__(
        self,
        ip: str,
        port: int,
        folder: str 
    ):
        self.ip = ip
        self.port = port  
        self.folder = folder
        self.files = set(os.listdir(folder))
        
    def join(self):
        S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
        S.bind((self.ip, self.port))
        S.connect((self.server_IP, self.server_port))
        
        files = " ".join(self.files)
        S.send(("JOIN" + "&" + files).encode())
        while True:
            if S.recv(1024).decode() == "JOIN_OK":
                print("Sou peer {}:{} com arquivos {}".format(
                    self.ip, 
                    self.port,
                    files
                ))
                break
        
    def search(self,file_name: str):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as S:
            S.connect((self.server_IP, self.server_port))
            S.send(("SEARCH" + "&" + file_name).encode())

            known_peers = pickle.loads(S.recv(1024))
            print("peers com arquivo solicitado: {}".format(
                ' '.join(f"{ip}:{p}" for ip, p in known_peers)
            ))
        
        
    def download(
        self,
        ip: str,
        port: int,
        file_name: str
    ):
        self.DownloadWorker(
            request_ip = ip,
            request_port = port,
            file_name = file_name,
            folder = self.folder,
        ).run()
        
    def wait_for_requests(self):
        self.RequestWorker(
            peer_ip = self.ip,
            peer_port = self.port,
            folder = self.folder,
            files = self.files
        ).run()

        
if __name__ == "__main__":
    print(
        "1 - JOIN \n"\
        "2 - SEARCH \n"\
        "3 - DOWNLOAD \n"
    )
    peer = None
    
    while True:
        try:
            opt = input()
            opt = opt.split(" ")
            opt, params = opt[0], opt[1:]
            print(params)
            if opt == "1":
                ip, port, folder = tuple(params)
                peer = Peer(
                    ip = ip,
                    port = int(port),
                    folder = folder
                )
                peer.join()
                peer.wait_for_requests()
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