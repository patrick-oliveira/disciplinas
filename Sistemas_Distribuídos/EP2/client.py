import socket
import logging
import argparse
import sys

from message import Message
from random import sample, randint
from threading import Thread
from typing import (Tuple, 
                    NewType,
                    List)

Socket = NewType("Socket", socket.socket)
Address = NewType["Address", Tuple[str, int]]

root = logging.getLogger()
root.setLevel(logging.INFO)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.INFO)
handler.setFormatter(logging.Formatter('%(message)s'))
root.addHandler(handler)

class Client:
    class RequestWorker(Thread):
        def __init__(
            self,
            client_id: int,
            server_addr: Address,
            request_type: str,
            key: str,
            value: str = None
        ):
            self.client_id = client_id
            self.server_addr = server_addr
            self.request_type = request_type
            self.key = key
            self.value = value
        
        def __get_timestamp(self, key: str) -> str:
            pass
        
        def __update_timestamp(self, key: str, timestamp: str):
            pass
        
        def run(self):
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect(self.server_addr)
            if self.request_type == "PUT":
                package = Message(
                    type = "PUT",
                    key = self.key,
                    value = self.value
                )
                
                # send package
                
                while True:
                    response: Message = s.recv(1024)
                    if response.type == "PUT_OK":
                        self.__update_timestamp(self.key, response.timestamp)
                        break
                        
                
            elif self.request_type == "GET":
                package = Message(
                    type = "GET",
                    key = self.key,
                    timestamp = self.__get_timestamp(self.key)
                )
                
                # send package
                
                response: Message = s.recv(1024)
                
                # processa resposta
        
    def __init__(
        self,
        server_address: List[Address]
    ):
        self.client_id = randint(10000, 99999)
        self.server_address = server_address
        
    def put(self, key: str, value: str):
        server_addr = self.__select_server()
        self.RequestWorker(
            client_id = self.client_id,
            server_addr = server_addr,
            request_type = "PUT",
            key = key,
            value = value
        ).start()
    
    def get(self, key: str):
        server_addr = self.__select_server()
        self.RequestWorker(
            client_id = self.client_id,
            server_addr = server_addr,
            request_type = "GET",
            key = key
        ).start()

    def __select_server(self) -> Address:
        return sample(self.server_address, 1)
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--num_servers",
        "-ns",
        action = 'store',
        type = int,
        dest = 'num_servers',
        default = 3
    )
    args = parser.parse_args()
    
    server_address = []
    for _ in range(1, args.num_servers + 1):
        addr = input(f"Endereço do servidor {_}:")
        ip, porta = addr.split(" ")
        server_address.append((ip, int(porta)))
    
    client = Client(
        server_address = server_address
    )
    
    while True:
        print("Menu: 1 - PUT; 2 - GET")
        
        try:
            opt = input()
            opt = opt.split(" ")
            opt, params = opt[0], opt[1:]
        except IndexError:
            continue
        
        if opt == "1":
            key, value = tuple(params)
            client.put(key, value)
        elif opt == "2":
            key = params.pop()
            client.get(key)