import socket
import logging
import argparse
import sys
import json

from message import Message
from random import sample, randint
from threading import Thread, Lock
from typing import (Tuple, 
                    NewType,
                    List,
                    Union)

lock = Lock()

Socket = NewType("Socket", socket.socket)
Address = NewType["Address", Tuple[str, int]]

root = logging.getLogger()
root.setLevel(logging.INFO)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.INFO)
handler.setFormatter(logging.Formatter('%(message)s'))
root.addHandler(handler)

KEYS = {}

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
        
        def __get_timestamp(self, key: str) -> Union[str, None]:
            with lock:
                global KEYS
                
                if key in KEYS.keys():
                    timestamp = KEYS[key]
                else:
                    timestamp = None
                
            return timestamp
                
        
        def __update_timestamp(self, key: str, timestamp: str):
            with lock:
                global KEYS
                KEYS[key] = timestamp
        
        def run(self):
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect(self.server_addr)
            if self.request_type == "PUT":
                package = Message(
                    type = "PUT",
                    key = self.key,
                    value = self.value
                )
                package = json.dumps(package.__dict__)
                
                s.send(package.encode())
                
                while True:
                    response: Message = json.loads(s.recv(1024).decode())
                    if response.request_type == "PUT_OK":
                        self.__update_timestamp(self.key, response.timestamp)
                        logging.info(
                            "PUT_OK key: {} value {} timestamp {} realizada no servidor {}:{}".format(  # noqa: E501
                                self.key,
                                self.value,
                                response.timestamp,
                                self.server_addr[0],
                                self.server_addr[1]
                            )
                        )
            elif self.request_type == "GET":
                package = Message(
                    type = "GET",
                    key = self.key,
                    timestamp = self.__get_timestamp(self.key)
                )
                package = json.dumps(package.__dict__)
                s.send(package.encode())
                
                response: Message = json.loads(s.recv(1024).decode())
                
                if response.request_type != "ERROR":
                    logging.info(
                        "GET key: {} value {} obtido do servidor {}:{}, meu timestamp {} e do servidor {}".format(  # noqa: E501
                            self.key,
                            response.value,
                            self.server_addr[0],
                            self.server_addr[1],
                            self.__get_timestamp(key),
                            response.timestamp
                        )
                    )
        
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
    
    client = None
    
    while True:
        print("Menu: 0 - INIT; 1 - PUT; 2 - GET")
        
        try:
            opt = input()
            opt = opt.split(" ")
            opt, params = opt[0], opt[1:]
        except IndexError:
            continue
        
        if opt == "0":
            server_address = []
            for _ in range(1, args.num_servers + 1):
                addr = input(f"Endereço do servidor {_}:")
                ip, porta = addr.split(" ")
                server_address.append((ip, int(porta)))
            
            client = Client(server_address = server_address)
        elif opt == "1":
            if client is not None:
                key, value = tuple(params)
                client.put(key, value)
        elif opt == "2":
            if client is not None:
                key = params.pop()
                client.get(key)