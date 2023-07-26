import socket
import logging
import sys
import argparse
import os
import json

from time import time, sleep
from message import Message
from threading import (Lock,
                       Thread)
from typing import (NewType,
                    Tuple,
                    Union)

Socket = NewType("Socket", socket.socket)
Address = NewType("Address", Tuple[str, int])

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

# A lista de servidores fica acessível para que o líder saiba para quem mandar um 
# replicate. 
SERVER_ADDRESS = [
    ("127.0.0.1", 10097),
    ("127.0.0.1", 10098),
    ("127.0.0.1", 10099)
]

class Server:
    class RequestWorker(Thread):
        '''
        Classe auxiliar para recebimento de requisições de peers em threads independentes.
        '''  # noqa: E501
        def __init__(
            self, 
            self_addr: Address,
            leader_addr: Address,
            client_conn: Socket, 
            client_addr: Address, 
            is_leader: bool = False
        ):
            super().__init__()
            self.self_addr = self_addr
            self.leader_addr = leader_addr
            self.client_conn = client_conn
            self.client_addr = client_addr
            self.is_leader = is_leader
            
        def run(self):
            """
            Método principal do Worker. É executado assim que a thread é iniciada.
            
            Em uma requisição PUT, se o servidor é o líder, ele fará a atualização 
            da chave em seu dicionário, enviará as requisições REPLICATE, e abrirá 
            um novo socket a fim de enfiar o PUT_OK para o cliente, enviando para 
            o endereço apontado na mensagem enviada na requisição PUT. Se o servidor 
            não é o líder, apenas encaminha a mensagem recebida para o líder.
            
            Em uma requisição REPLICATE, o servidor atualiza o seu dicionário e retorna 
            uma mensagem com REPLICATE_OK.
            
            Em uma requisição GET, o servidor pode retornar uma mensagem contendo as 
            informações solicitadas, ou uma mensagem ERROR. O segundo caso se dará se 
            o servidor não possui informações da chave requisitada, ou se o timestamp 
            do servidor é mais velho que o timestamp informado pelo cliente, e neste 
            contexto é enviado uma mensagem para que o cliente tente novamente.
            
            """
            request = self.__get_request(self.client_conn)
            
            if request.request_type == "PUT":
                if self.is_leader:
                    timestamp = self.__put_key(request.key, request.value)
                    
                    logging.info("Cliente {}:{} PUT key:{} value:{}".format(
                        self.client_addr[0],
                        self.client_addr[1],
                        request.key,
                        request.value
                    ))
                    
                    for addr in [x for x in SERVER_ADDRESS if x != self.self_addr]:
                        sleep(self.__simulate_delay())
                        self.__replicate(
                            request.key, 
                            request.value, 
                            timestamp, 
                            addr
                        )
                        
                    S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                    S.connect(tuple(request.addr))

                    S.send(
                        self.__serialize(Message(
                            request_type = "PUT_OK",
                            key = request.key,
                            value = request.value,
                            timestamp = timestamp
                        ))
                    )
                    
                    logging.info(
                        "Enviando PUT_OK ao Cliente {}:{} da key:{} ts:{}".format(
                            self.client_addr[0],
                            self.client_addr[1],
                            request.key,
                            timestamp
                        )
                    )
                    
                    S.close()
                    
                else:
                    S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                    S.connect(self.leader_addr)
                    S.sendall(self.__serialize(request))
                    
                    logging.info("Encaminhando PUT key:{} value:{}".format(
                        request.key,
                        request.value
                    ))
                    
                    S.close()
                    
            elif request.request_type == "REPLICATION":
                timestamp = self.__put_key(
                    key = request.key,
                    value = request.value,
                    timestamp = request.timestamp
                )
                
                self.client_conn.sendall(
                    self.__serialize(Message(
                        request_type = "REPLICATION_OK"
                    ))
                )
                
                logging.info("REPLCIATION key:{} value:{} ts:{}".format(
                    request.key,
                    request.value,
                    request.timestamp
                ))
            elif request.request_type == "GET":
                response = self.__get_key(request.key, request.timestamp)
                
                if response is None:
                    package = Message(
                        request_type = "ERROR",
                        key = request.key,
                        value = "EMPTY"
                    )
                    value = None
                    timestamp = None
                elif response[0] == "TRY_OTHER_SERVER_OR_LATER":
                    package = Message(
                        request_type = "ERROR",
                        key = request.key,
                        value = response[0]
                    )
                    value = response[0]
                    timestamp = response[1]
                else:
                    package = Message(
                        request_type = "GET_OK",
                        key = request.key,
                        value = response[0],
                        timestamp = response[1]
                    )
                    value = response[0]
                    timestamp = response[1]
                
                self.client_conn.sendall(self.__serialize(package))
                
                logging.info("Cliente {}:{} GET key:{} ts:{}. ""Meu ts é {}, portanto devolvendo {}.".format(  # noqa: E501
                    self.client_addr[0],
                    self.client_addr[1],
                    request.key,
                    request.timestamp,
                    timestamp,
                    value
                ))
                
            self.client_conn.close()
        
        def __serialize(self, m: Message) -> bytes:
            """
            Representa um objeto Message como um json e o serializa.

            Args:
                m (Message): Mensagem a ser enviada.

            Returns:
                bytes: Cadeia de bits da mensagem para transmissão.
            """
            m = m.__dict__
            m = json.dumps(m)
            m = m.encode()
            return m
                    
        def __deserialize(self, r: bytes) -> Message:
            """
            Desserializa uma cadeia de bits em um json e insere as informações 
            em um tipo Message.

            Args:
                r (bytes): Cadeia de bits recebida.

            Returns:
                Message: Informação representada como um objeto Message.
            """
            r = r.decode()
            r = json.loads(r)
            r = Message(**r)
            return r
            
        def __get_request(self, conn: socket) -> Message:
            """
            Recupera e decodifica a mensagem serializada enviada pela conexão e
            instancia um tipo Mensagem com as informações.

            Returns:
                Message: Mensagem decodificada.
            """
            request = conn.recv(1024)
            message = self.__deserialize(request)
            return message
        
        def __put_key(self, key: str, value: str, timestamp: str = None) -> float:
            """Insere no dicionário de keys uma chave e seu valor (potencialmente 
            distinto do valor existente na tabela). O valor do timestamp pode ser 
            passado por parâmetro, o que ocorre em uma requisição REPLICATE, caso 
            contrário é calculado um novo timestamp no momento de definição da chave 
            no dicionário.
            
            Apenas uma thread por vez pode manipular o arquivo dicionário

            Args:
                key (str): Chave identificadora.
                value (str): Valor vinculado à chave.
                timestamp (str, optional): Timestamp informado na requisição REPLICATE.
                Defaults to None.

            Returns:
                float: Timestamp que foi atribuído à key.
            """
            with lock:
                table_path = f"{str(self.self_addr).replace('.', '_')}.json"
                with open(table_path, "r") as f:
                    table = json.load(f)
                
                if timestamp is None:
                    timestamp = time()
                
                table[key] = (value, timestamp)
                
                with open(table_path, "w") as f:
                    json.dump(table, f)
                    
            return timestamp
        
        def __get_key(
            self, 
            key: str, 
            timestamp: Union[float, None]
        ) -> Union[None, Tuple[str, float]]:
            """
            Método para recuperar as informação de uma chave no dicionário do 
            servidor.
            
            Um timestamp pode ser informado pelo cliente que fez a solicitação. Porém,
            caso o cliente não tenha informações em cache sobre essa chave, será 
            enviado um None.
            
            A função retorna um par (valor, timestamp) somente se o o cliente não 
            possui essa chave (timestamp informado é None), ou se possui uma versão 
            mais antiga do valor dessa chave em relação ao servidor requisitado. 
            
            Se o servidor não possui essa chave, retorna vazio, e o cliente receberá 
            uma mensagem de erro. Se a chave do servidor é mais antiga que a do 
            cliente, é enviada uma mensagem para que o cliente tente novamente.
            
            Apenas uma thread pode acessar o arquivo por vez, portanto o valor recupera-
            do será sempre antes ou depois de uma requisição PUT.

            Args:
                key (str): Chave identificadora.
                timestamp (Union[float, None]): Timestamp informado pelo cliente. Pode 
                ser None caso o cliente não tenha a chave.

            Returns:
                Union[None, Tuple[str, float]]: Informações da chave solicitada. 
                Pode ser None caso o servidor não tenha chave. O valor enviado será 
                um aviso "TRY_OTHER_SERVER_OR_LATER" se a chave do servidor é antiga.
            """
            with lock:
                table_path = f"{str(self.self_addr).replace('.', '_')}.json"
                with open(table_path, "r") as f:
                    table = json.load(f)
                    
                if key not in table.keys():
                    response = None
                else:
                    value, saved_timestamp = table[key]
                    
                    if timestamp is not None:
                        if saved_timestamp >= timestamp:
                            response = (value, saved_timestamp)
                        else:
                            response = ("TRY_OTHER_SERVER_OR_LATER", saved_timestamp)
                    else:
                        response = (value, saved_timestamp)
                        
            return response
            
        def __replicate(
            self, 
            key: str, 
            value: str, 
            timestamp: str, 
            addr: Address
        ) -> bool:
            """
            Envia uma solicitação de replicação de um PUT para um endereço informado.
            
            Aguarda a chegada da confirmação REPLICATE_OK.

            Args:
                key (str): Chave identificadora.
                value (str): Valor atribuído à chave.
                timestamp (str): Timestamp de alteração da chave no servidor líder.
                addr (Address): Endereço do servidor que deve realizar a replicação.

            Returns:
                bool: Booleano informando se a replicação foi bem sucedida.
            """
            S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            S.connect(addr)
            S.send(
                self.__serialize(Message(
                    request_type = "REPLICATION",
                    key = key,
                    value = value,
                    timestamp = timestamp
                ))
            )
            
            while True:
                response: Message = self.__get_request(S)
                if response.request_type == "REPLICATION_OK":
                    break
            
            S.close()
            
            return True
        
        def __simulate_delay(self) -> int:
            """
            Função auxiliar que simula a latência para uma solicitação de REPLICATE.

            Returns:
                int: Tempo em segundos de espera antes do envio do REPLICATE.
            """
            return 5
            
    def __init__(
        self, 
        addr: Address, 
        leader_addr: Address
    ):
        self.addr = addr
        self.leader_addr = leader_addr
        
        self.is_leader = self.addr == self.leader_addr
        
        self.__init_hash_table()
        
    def __init_hash_table(self):
        """
        Método para inicialização do dicionário de chaves vinculado ao servidor.
        """
        server_identifier = str(self.addr).replace(".", "_")
        table_path = f"{server_identifier}.json"
        
        if not os.path.exists(table_path):
            with open(table_path, "w") as f:
                json.dump({}, f)
        
    def run(self):
        """
        Método principal de execução do servidor.
        
        Inicializa um socket e o vincula ao endereço definido para o servidor. Configura
        o socket para receber conexões e, para cada nova conexão aceita, inicia uma 
        thread separada com a classe auxiliar RequestWorker a fim de processar requisi-
        ções de clientes e outros servidores.
        """     
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
        self.socket.bind(self.addr)
        self.socket.listen(5)
        
        while True:
            conn, addr = self.socket.accept()
            self.RequestWorker(
                self.addr,
                self.leader_addr,
                conn, 
                addr, 
                self.is_leader
            ).start()
    
    
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
    args = parser.parse_args()
    
    server = Server(
        addr = (args.ip, args.port),
        leader_addr = (args.leader_ip, args.leader_port), 
    )
    server.run()