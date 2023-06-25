import socket
import os
import pickle
import argparse
import logging
import sys

from pathlib import Path
from typing import Tuple
from threading import Thread, Event

root = logging.getLogger()
root.setLevel(logging.INFO)

handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.INFO)
handler.setFormatter(logging.Formatter('%(message)s'))
root.addHandler(handler)

UPLOAD_BUFFER_SIZE = 1000000

class Peer:
    class DownloadWorker(Thread):
        def __init__(
            self,  
            request_addr: Tuple[str, int],
            file_name: str,
            folder: str,
            self_addr: Tuple[str, int],
            server_addr: Tuple[str, int]
        ):
            super().__init__()
            
            self.request_addr = request_addr
            self.self_addr = self_addr
            self.server_addr = server_addr
            self.file_name = file_name
            self.folder = folder
            
        def update(self):
            S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            S.connect(self.server_addr)
            
            S.send(f"UPDATE/{self.self_addr[0]} {self.self_addr[1]} {self.file_name}".encode())  # noqa: E501
            
            while True:
                if S.recv(1024).decode == "UPDATE_OK":
                    break
            
        def run(self):
            if self.request_addr == self.self_addr:
                return
            
            S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            
            try:
                S.connect(self.request_addr)
            except ConnectionRefusedError:
                return
            
            S.send(f'DOWNLOAD/{self.file_name}'.encode())
            if S.recv(1024).decode() == "AVAILABLE":
                with open(Path(self.folder) / self.file_name, "wb") as f:
                    while True:
                        data = S.recv(UPLOAD_BUFFER_SIZE)
                        
                        if not data:
                            break
                        else:
                            f.write(data)
                            
                logging.info(f"Arquivo {self.file_name} baixado com sucesso na pasta {self.folder}") # noqa: E501
            
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
            size = os.path.getsize(file_path)
            with open(file_path, "rb") as f:
                while size > 0:
                    conn.sendall(f.read(UPLOAD_BUFFER_SIZE))
                    size -= UPLOAD_BUFFER_SIZE
                    
            conn.close()
             
        def run(self):
            S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
            S.bind(self.peer_addr)
            S.listen(1)
            
            while True:
                if self.__stop_event.is_set():
                    break
                
                c, addr = S.accept()
                
                request = c.recv(1024).decode().split("/")
                request_type = request[0]
                request_body = request[1]
                
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
                
            
    def __init__(
        self,
        addr: Tuple[str, int],
        folder: str,
        server_addr: Tuple[str, int] = ('127.0.0.1', 1099)
    ):
        self.__set_peer_addr(addr, folder)
        self.__set_server_addr(server_addr)
        
        self.last_search = None
        self.request_worker = None
        
        self.join(addr, folder)
       
    def __set_peer_addr(self, addr: Tuple[str, int], folder: str):
        self.addr = addr
        self.folder = folder
        self.files = os.listdir(folder)
    
    def __set_server_addr(self, addr: Tuple[str, int]):
        self.server_addr = addr
        
    def join(
        self,
        addr: Tuple[str, int],
        folder: str,
    ):
        self.__terminate_worker()
        
        self.__set_peer_addr(addr, folder)
        
        S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
        S.bind(self.addr)
        
        S.connect(self.server_addr)
        files = "/".join(self.files)
        S.send(f"JOIN/{files}".encode())
        while True:
            if S.recv(1024).decode() == "JOIN_OK":
                logging.info("Sou peer {}:{} com arquivos {}".format(
                    self.addr[0], 
                    self.addr[1],
                    files
                ))
                break
            
        self.__wait_for_requests()
        
    def search(self,file_name: str):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as S:
            S.connect(self.server_addr)
            S.send(f"SEARCH/{file_name}".encode())

            response = S.recv(1024)
            known_peers = pickle.loads(response)
                
            print("peers com arquivo solicitado: {}".format(
                ' '.join(f"{ip}:{p}" for ip, p in known_peers)
            ))
            
            self.last_search = file_name
        
    def download(self, addr: Tuple[str, int]):        
        if self.last_search is not None:
            self.DownloadWorker(
                request_addr = addr,
                file_name = self.last_search,
                folder = self.folder,
                self_addr = self.addr,
                server_addr = self.server_addr
            ).start()
        
    def __wait_for_requests(self):
        self.request_worker = self.RequestWorker(
            peer_addr = self.addr,
            folder = self.folder,
            files = self.files
        )
        self.request_worker.start()
        
    def __terminate_worker(self):
        if self.request_worker is not None:
            self.request_worker.stop()

        
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--ip',
        '-i',
        action = 'store',
        type = str,
        dest = 'ip',
        required = True
    )
    parser.add_argument(
        '--port',
        '-p',
        action = 'store',
        type = int,
        dest = 'port',
        required = True
    )
    parser.add_argument(
        '--folder',
        '-f',
        action = 'store',
        type = str,
        dest = 'folder',
        required = True
    )
    
    args = parser.parse_args()
    
    peer = Peer(
        addr = (args.ip, args.port),
        folder = args.folder
    )
    
    while True:
        print("Menu: 1 - JOIN; 2 - SEARCH; 3 - DOWNLOAD")
        opt = input()
        opt = opt.split(" ")
        opt, params = opt[0], opt[1:]
        if opt == "1":
            ip, port, folder = tuple(params)
            peer.join((ip, int(port)), folder)
        elif opt == "2":
            file_name = " ".join(params)
            peer.search(file_name)
        elif opt == "3":
            ip = params[0]
            port = params[1]
            peer.download((ip,int(port)))