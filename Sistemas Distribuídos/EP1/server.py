import os
import socket
import pickle
import json
import logging
import sys
import argparse

from typing import Tuple, List
from threading import Lock, Thread
from typing import NewType

Socket = NewType("Socket", socket.socket)
    
# Instanciação da trava compartilhada por threads para escrita no arquivo
# de registro
lock = Lock()

# Inicialização da classe para log de mensagens.
# Atualmente o único handler direciona as mensagens para o terminal.
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
        def __init__(self, conn: Socket, addr: Tuple[str, int]):
            super().__init__()
            self.conn = conn
            self.addr = addr
        
        def __register_files(self, addr: Tuple[str, int], file_list: List[str]):
            """
            Método para registro de nomes arquivos vinculados a peers. O registro é 
            persistido em um json "registry.json", uma estrutura que associa para cada
            nome de arquivo uma lista de endereços (IP, porta) dos peers que o possui.
            É garantido que não existe repetição quanto ao nome dos arquivos ou 
            endereços em cada lista. 

            Args:
                addr (Tuple[str, int]): Endereço do peer a ser registrado.
                file_list (List[str]): Lista de arquivos possuídos pelo peer especificado.
            """              # noqa: E501
            # A trava garante que a escrita sobre o registro é feita por uma thread de
            # cada vez
            with lock:
                with open("registry.json", "r") as f:
                    registry = json.load(f)
                
                # Para cada arquivo, cria uma nova lista de peers caso seja uma lista
                # nova, senão adiciona o endereço à lista de peers caso não seja du-
                # plicado.
                for filename in file_list:
                    if filename in registry.keys():
                        if list(addr) not in registry[filename]:
                            registry[filename].append(addr)
                    else:
                        registry[filename] = [addr]
                        
                with open("registry.json", "w") as f:
                    json.dump(registry, f)
                
        def __search_file(self,filename: str) -> List[Tuple[str, int]]:
            """
            Método de busca por um arquivo no registro. Retorna a lista de peers que
            possui o arquivo ou uma lista vazia.

            Args:
                filename (str): Nome do arquivo bucado.

            Returns:
                List[Tuple[str, int]]: Lista de endereços (IP, porta) de peers.
            """            
            with open("registry.json", "r") as f:
                registry = json.load(f)
            
            try:
                return registry[filename]
            except KeyError:
                return []
            
        def run(self):
            """
            Método principal para processamento de requisições dos peers.
            
            A função recebe uma requisição, decompõe a mensagem na flag de tipo de
            requisição e no seu corpo (parâmetros), todos separados por "/" como
            definido pela implementação do sistema. Chama o método adequado de acordo 
            com o tipo de requisição.
            """            
            request = self.conn.recv(1024).decode().split("/")
            request_type = request[0]
            request_body = request[1:]
            
            if request_type == "JOIN":
                self.__register_files(self.addr, request_body)
                logging.info(f"Peer {self.addr[0]}:{self.addr[1]} adicionado com arquivos {' '.join(request_body)}")  # noqa: E501
                self.conn.send("JOIN_OK".encode())
            elif request_type == "UPDATE":
                ip, port, filename = tuple(request_body)
                self.__register_files((ip, port), [filename])
                self.conn.send("UPDATE_OK".encode())
            elif request_type == "SEARCH":
                request_body = request_body.pop()
                known_peers = pickle.dumps(self.__search_file(request_body))
                logging.info(f"Peer {self.addr[0]}:{self.addr[1]} solicitou arquivo {request_body}")  # noqa: E501
                self.conn.sendall(known_peers)
            
            self.conn.close()
            
    
    def __init__(self, server_ip: str, port: int):        
        self.server_ip = server_ip
        self.port = port
    
        self.__initialize_registry()
    
    def __initialize_registry(self):
        """
        Método para inicialização do registro de informações de peers.
        
        O registro consiste em um arquivo json associando nomes de arquivos
        com listas dos peers (IP, porta) que os possui. A inicialização consiste
        em criar um arquivo vazio, caso este ainda não exista.
        """        
        if not os.path.exists("registry.json"):
            with open("registry.json", "w") as f:
                json.dump({}, f)
        
    def run(self):
        """
        Método principal de execução do servidor.
        
        Inicializa um socket e o vincula ao endereço definido para o servidor. Configura
        o socket para receber conexões e, para cada nova conexão aceita, inicia uma 
        thread separada com a classe auxiliar RequestWorker a fim de processar a requi-
        sição do peer.
        """        
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
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