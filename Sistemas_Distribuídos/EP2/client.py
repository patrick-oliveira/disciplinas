import socket
import logging
import argparse
import sys
import json
import os

from time import sleep
from message import Message
from random import sample, randint
from threading import Thread, Lock
from typing import (Tuple, 
                    NewType,
                    List,
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

class Client:
    class RequestWorker(Thread):
        """
        Classe auxiliar para a realização de requisições em threads independentes.
        """
        def __init__(
            self,
            client_id: int,
            server_addr: Address,
            request_type: str,
            key: str,
            value: str = None
        ):
            super().__init__()
            
            self.client_id = client_id
            self.server_addr = server_addr
            self.request_type = request_type
            self.key = key
            self.value = value
                    
        def run(self):
            """
            Método principal do worker. É executado logo ao iniciar a thread.
            
            Um socket temporário é inicializado para realizar a requisição. No caso 
            de uma requisição put, um esgundo socket atuando como servidor é inicializa-
            do em uma terceira thread, e após o envio da requisição PUT com o endereço 
            desse socket ouvinte, a função aguarda o término da execução da thread 
            que espera o PUT_OK.
            
            Ao receber o PUT_OK, a thread atualiza o dicionário de keys do cliente com 
            o timestamp que recebeu.
            
            A requisição GET envia a solicitação, aguarda uma resposta, e caso tenha 
            sido retornada uma resposta válida, atualiza o dicionário de keys.
            """
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            try:
                s.connect(self.server_addr)
            except ConnectionRefusedError:
                logging.info(f"Erro de conexão no endereço {self.server_addr}. Conexão negada.")  # noqa: E501
                return
            except Exception:
                logging.info(f"Erro de conexão no endereço {self.server_addr}.")
                return
            
            if self.request_type == "PUT":
                wait_thread, wait_addr = self.__wait_put_ok()
                
                s.send(
                    self.__serialize(Message(
                        request_type = "PUT",
                        addr = wait_addr,
                        key = self.key,
                        value = self.value
                    ))
                )
                
                s.close()
                
                wait_thread.join()
                

            elif self.request_type == "GET":
                key_data = self.__get_timestamp(self.key)
                if key_data is not None:
                    _, timestamp = tuple(key_data)
                else:
                    timestamp = 0
                    
                s.send(
                    self.__serialize(Message(
                        request_type = "GET",
                        key = self.key,
                        timestamp = timestamp
                    ))
                )
                
                response: Message = self.__get_request(s)
                
                if response.request_type != "ERROR":
                    self.__update_timestamp(self.key, response.value, response.timestamp)
                    
                    logging.info(
                        "GET key: {} value {} obtido do servidor {}:{}, meu timestamp {} e do servidor {}".format(  # noqa: E501
                            self.key,
                            response.value,
                            self.server_addr[0],
                            self.server_addr[1],
                            timestamp,
                            response.timestamp
                        )
                    )
                else:
                    print("GET ERROR", response.value, self.server_addr)
                    
                s.close()
            
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
        
        def __get_timestamp(self, key: str) -> Union[Tuple[str, float], None]:
            """
            Dada uma key, consulta o dicionário e recupera o valor salvo com o seu 
            - último - timestamp correspondente.

            Args:
                key (str): Chave a ser consultada.

            Returns:
                Union[Tuple[str, float], None]: Valor e timestamp associada à chave ou 
                None caso não exista informações.
            """
            with lock:
                table_path = f"{self.client_id}.json"
                with open(table_path, "r") as f:
                    table = json.load(f)
                
                if key in table.keys():
                    value, timestamp = tuple(table[key])
                    return value, timestamp
                else:
                    return None
                
        def __update_timestamp(self, key: str, value: str, timestamp: str):
            """
            Atualiza a tabela local do cliente com as informações de uma key.
            Essa atualização pode ser feita tanto após um PUT quanto com o GET.

            Args:
                key (str): Chave de identificação.
                value (str): Valor associado à chave.
                timestamp (str): Timestamp mais recente de atribuição da chave.
            """
            with lock:
                table_path = f"{self.client_id}.json"
                with open(table_path, "r") as f:
                    table = json.load(f)
                    
                table[key] = (value, timestamp)
                
                with open(table_path, "w") as f:
                    json.dump(table, f)
                
        def __wait_put_ok(self) -> Union[Thread, Tuple[str, int]]:
            """
            Função para espera da confirmação do PUT_OK enviada pelo servidor lider.
            
            É iniciada uma thread com um socket temporário que opera como servidor. O 
            endereço desse socket é salvo e enviado junto com a mensagem de PUT, sob 
            o pressuposto de que o servidor líder enviará uma resposta com PUT_OK para 
            o endereço especificado.

            Returns:
                Union[Thread, Tuple[str, int]]: Thread com o socket esperando o PUT_OK, 
                junto com o seu endereço
            """
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.listen(1)
            def wait_thread(s: Socket):
                conn, addr = s.accept()
                while True:
                        response: Message = self.__get_request(conn)
                        if response.request_type == "PUT_OK":
                            self.__update_timestamp(
                                self.key, 
                                response.value, 
                                response.timestamp
                            )
                            logging.info(
                                "PUT_OK key: {} value {} timestamp {} realizada no servidor {}:{}".format(  # noqa: E501
                                    self.key,
                                    self.value,
                                    response.timestamp,
                                    self.server_addr[0],
                                    self.server_addr[1]
                                )
                            )
                            conn.close()  
                            break    
            
            t1 = Thread(target = wait_thread, args = (s, ))
            t1.start()
            
            return t1, s.getsockname()
            
    def __init__(self, server_address: List[Address]):
        self.client_id = randint(10000, 99999)
        self.server_address = server_address
        
        self.__init_key_table()
        
    def put(self, key: str, value: str):
        """
        Método para realização de uma requisição put. O servidor que receberá 
        a requisição é escolhido aleatoriamente. A requisição é feita em uma thread 
        independente.

        Args:
            key (str): Chave identificadora.
            value (str): Valor vinculado à chave.
        """
        server_addr = self.__select_server()
        self.RequestWorker(
            client_id = self.client_id,
            server_addr = server_addr,
            request_type = "PUT",
            key = key,
            value = value
        ).start()
    
    def get(self, key: str):
        """
        Método para a realização de uma requisição get. O servidor que receberá 
        a requisição é escolhido aleatoriamente. A requisição é feita em uma thread 
        independente.

        Args:
            key (str): Chave identificadora.
        """
        server_addr = self.__select_server()
        self.RequestWorker(
            client_id = self.client_id,
            server_addr = server_addr,
            request_type = "GET",
            key = key
        ).start()

    def __select_server(self) -> Address:
        """
        Método auxiliar para a escolha aleatória de um servidor na lista 
        de servidores disponíveis.

        Returns:
            Address: Endereço (IP, port) do servidor escolhido.
        """
        return sample(self.server_address, 1).pop()
    
    def __init_key_table(self):
        """
        Inicialização da tabela atrelada ao cliente para persistências das innformações 
        das chaves consultadas e enviadas para os servidores. 
        
        No momento o id do cliente é aleatório, porém em um cenário onde o cliente é i-
        dentificado de forma determinada, um cache pode se fazer necessário.
        """
        table_path = f"{self.client_id}.json"
        
        if not os.path.exists(table_path):
            with open(table_path, "w") as f:
                json.dump({}, f)
    
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
        
            if opt == "0":
                server_address = []
                for _ in range(1, args.num_servers + 1):
                    addr = input(f"Endereço do servidor {_}: ")
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
                    
            elif opt == '99':
                key = params.pop()
                while True:
                    client.get(key)
                    sleep(0.5)
        except IndexError:
            continue
        except ValueError:
            continue