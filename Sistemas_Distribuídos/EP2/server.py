import socket
import logging
import sys
import argparse

from message import Message
from threading import (Lock,
                       Thread)
from typing import (NewType,
                    Tuple)

Socket = NewType("Socket", socket.socket)
Address = NewType("Address", Tuple[str, int])

lock = Lock()

root = logging.getLogger()
root.setLevel(logging.INFO)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.INFO)
handler.setFormatter(logging.Formatter('%(message)s'))
root.addHandler(handler)

class Server:
    class RequestWorker(Thread):
        '''
        Classe auxiliar para recebimento de requisições de peers em threads independentes.
        '''  # noqa: E501
        def __init__(self, conn: Socket, addr: Address, is_leader: bool = False):
            super().__init__()
            self.conn = conn
            self.addr = addr
            self.is_leader = is_leader
            
        def __get_request(self) -> Message:
            pass
            
        def run(self):
            request = self.__get_request()
            
            if request.type == "PUT":
                pass
                if self.is_leader:
                    logging.info("Cliente {}:{} PUT key:{} value:{}".format(
                        self.addr[0],
                        self.addr[1],
                        request.key,
                        request.value
                    ))
                else:
                    logging.info("Encaminhando PUT key:{} value:{}".format(
                        request.key,
                        request.value
                    ))
            elif request.type == "REPLICATION":
                logging.info("REPLCIATION key:{} value:{} ts:{}".format(
                    request.key,
                    request.value,
                    request.timestamp
                ))
            elif request.type == "REPLICATION_OK":
                logging.info("Enviando PUT_OK ao Cliente {}:{} da key:{} ts:{}".format(
                    self.addr[0],
                    self.addr[1],
                    request.key,
                    request.timestamp
                ))
            elif request.type == "GET":
                logging.info("Cliente {}:{} GET key:{} ts:{}. ""Meu ts é {}, portanto devolvendo {}.".format(  # noqa: E501
                    self.addr[0],
                    self.addr[1],
                    request.key,
                    request.timestamp,
                    "EDITAR",
                    "EDITAR"
                ))
            
    def __init__(
        self, 
        addr: Address, 
        leader_addr: Address, 
        is_leader: bool = False
    ):
        self.addr = addr
        self.leader_addr = leader_addr
        
        self.is_leader = is_leader
        
    def run(self):
        """
        Método principal de execução do servidor.
        
        Inicializa um socket e o vincula ao endereço definido para o servidor. Configura
        o socket para receber conexões e, para cada nova conexão aceita, inicia uma 
        thread separada com a classe auxiliar RequestWorker a fim de processar a requi-
        sição do peer.
        """     
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.setsockopt(socket.SQL_SOCKET, socket.SO_REUSEADDR, 1)
        self.socket.setsockopt(socket.SQL_SOCKET, socket.SO_REUSEPORT, 1)
        self.socket.bind(self.addr)
        self.socket.listen(5)
        
        while True:
            conn, addr = self.s.accept()
            self.RequestWorker(conn, addr, self.is_leader).start()
    
    
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
        dest = 'port'
    )
    parser.add_argument(
        '--leader_ip',
        '-lip',
        action = 'store',
        type = str,
        default = '127.0.0.1',
        dest = 'leader_ip'
    )
    parser.add_argument(
        '--leader_port',
        '-lp',
        action = 'store',
        type = int,
        dest = 'leader_port'
    )
    parser.add_argument(
        '--is_leader',
        '-il',
        action = 'store_true',
        dest = 'is_leader'
    )
    
    args = parser.parse_args()
    
    server = Server(
        addr = (args.ip, args.port),
        leader_addr = (args.leader_ip, args.leader_port),
        is_leader = args.is_leader
    )
    server.run()