import os
import socket
import pickle
import json
import logging
import sys
import argparse

from typing import Tuple, List
from threading import Lock, Thread

lock = Lock()

root = logging.getLogger()
root.setLevel(logging.INFO)

handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.INFO)
handler.setFormatter(logging.Formatter('%(message)s'))
root.addHandler(handler)

class Server:
    server_ip: str
    port: int
    s: socket.socket
    db_file: str
    
    class RequestWorker(Thread):
        def __init__(self, conn, addr):
            self.conn = conn
            self.addr = addr
        
        def __register_files(
            self,
            addr: Tuple[str, int],
            file_list: List[str]
        ):
            with lock:
                with open("registry.json", "r") as f:
                    registry = json.load(f)
                
                for filename in file_list:
                    if filename in registry.keys():
                        if addr not in registry[filename]:
                            registry[filename].append(addr)
                    else:
                        registry[filename] = [addr]
                        
                with open("registry.json", "w") as f:
                    json.dump(registry, f)
                
        def __search_file(
            self,
            filename: str
        ):
            with open("registry.json", "r") as f:
                registry = json.load(f)
            
            if filename in registry.keys():
                return registry[filename]
            
            else:
                return []
            
        def run(self):
            request = self.c.recv(1024).decode().split("&")
            request_type = request[0]
            request_body = request[1]
            
            if request_type == "JOIN":
                files = request_body.split(" ")
                self.__register_files(self.addr, files)
                logging.info(f"Peer {self.addr[0]}:{self.addr[1]} adicionado com arquivos {request_body}")  # noqa: E501
                self.c.send("JOIN_OK".encode())
            elif request_type == "UPDATE":
                filename, ip, port = tuple(request_body)
                self.__register_files((ip, port), [filename])
                self.c.send("UPDATE_OK".encode())
            elif request_type == "SEARCH":
                logging.info(f"Peer {self.addr[0]}:{self.addr[1]} solicitou arquivo {request_body}")  # noqa: E501
                known_peers = pickle.dumps(self.__search_file(request_body))
                self.c.sendall(known_peers)
            
            self.c.close()
            
    
    def __init__(
        self,
        server_ip: str,
        port: int,
    ):
        self.server_ip = server_ip
        self.port = port
    
        self.__initialize_registry()
    
    def __initialize_registry(self):
        if not os.path.exists("registry.json"):
            with open("registry.json", "w") as f:
                json.dump({}, f)
        
    def run(self):
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.s.bind((self.server_ip, self.port))
        self.s.listen(5)
        
        while True:
            c, addr = self.s.accept()
            self.RequestWorker(c, addr).start()
            
            
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--ip',
        '-i',
        action = 'store',
        type = str,
        default = '127.0.0.1',
        dest = 'ip'
    )
    parser.add_argument(
        '--port',
        '-p',
        action = 'store',
        type = int,
        default = 1099,
        dest = 'port'
    )
    
    args = parser.parse_args()
    
    server = Server(
        server_ip = args.ip,
        port = args.port
    )
    server.run()