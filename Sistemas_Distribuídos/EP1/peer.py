import socket
import os
import pickle
import argparse
import logging
import sys

from pathlib import Path
from typing import Tuple, NewType
from threading import Thread, Event

Socket = NewType("Socket", socket.socket)


# Tamanho do buffer para transferência. Unidade em Bytes. 
UPLOAD_BUFFER_SIZE = 1000000 


# Inicialização da classe para log de mensagens.
# Atualmente o único handler direciona as mensagens para o terminal.
root = logging.getLogger()
root.setLevel(logging.INFO)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.INFO)
handler.setFormatter(logging.Formatter('%(message)s'))
root.addHandler(handler)

class Peer:
    class DownloadWorker(Thread):
        """
        Classe auxiliar para realização da requisição de download de arquivos de outros 
        peers em uma thread independente.
        """        
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
            """
            Método para solicitação de update no servidor após o download bem
            sucedido de um arquivo de outro peer.
            
            A solicitação é feita a partir de um socket com endereço temporário. Is-
            so é feito pelo fato de que o endereço fixo do presente peer está configu-
            rado para recebimento de requisições em uma thread independente.
            
            A requisição segue o padrão estabelecido de separar a flag do tipo e 
            argumentos do corpo da requisição por "/", submetendo tudo em uma única
            mensagem.
            
            A requisição aguarda indefinidamente pelo retorno do servidor com a con-
            firmação UPDATE_OK.
            """            
            S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            S.connect(self.server_addr)
            
            S.send(f"UPDATE/{self.self_addr[0]}/{self.self_addr[1]}/{self.file_name}".encode())  # noqa: E501
            
            while True:
                if S.recv(1024).decode == "UPDATE_OK":
                    break
            
        def run(self):
            """
            Método principal para solicitação de download de arquivo de um outro peer.
            
            A solicitação é feita a partir de um socket temporário, posto que o peer
            requisitado não precisa guardar ou verificar as informações de quem está
            solicitando.
            
            Se o endereço requisitado é igual ao endereço do peer requerente, ou caso
            seja um endereço inválido (erro de conexão), a função é encerrada.
            
            Após a solicitação de download com o nome do arquivo, verifica-se o primeiro
            pacote retornado pelo peer requisitado, que deve conter uma flag AVAILABLE
            ou UNAVAILABLE. No primeiro caso, é feito o download pelo recebimento de pa-
            cotes de tamanho determinado (UPLOAD_BUFFER_SIZE), salvando o arquivo na
            pasta atribuída ao peer requerente.
            
            Após o download, faz-se uma solicitação de update ao servidor, informando-o
            de que o peer requerente adquiriu um novo arquivo.
            """            
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
        """
        Classe auxiliar para recebimento e processamento de requisições de download 
        vindas de outros peers a partir de threads independentes.
        """        
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
            """
            Método para interrupção da execução da thread. Gera um evento
            que, ao ser verificado dentro do método principal da classe,
            encerra o loop de recebimento de requisições.
            """
            self.__stop_event.set()
            
        def upload(self, conn: Socket, file_path: str):
            """
            Método para submissão do arquivo solicitado para o peer requerente.
            
            De modo a possibilitar o envio de grandes arquivos sem carregá-lo na memó-
            ria, o envio é feito em blocos de tamanho determinado (UPLOAD_BUFFER_SIZE).
            
            Após concluída a transmissão, a conexão é encerrada.

            Args:
                conn (Socket): Conexão estabelecida com o peer requerente.
                file_path (str): Endereço do arquivo a ser transferido.
            """            
            size = os.path.getsize(file_path)
            with open(file_path, "rb") as f:
                while size > 0:
                    conn.sendall(f.read(UPLOAD_BUFFER_SIZE))
                    size -= UPLOAD_BUFFER_SIZE
                    
            conn.close()
             
        def run(self):
            """
            Método principal da classe e recebimento de requisições.
            
            O objetivo cria um socket que é vinculado ao endereço que
            identifica o peer e é configurado para receber conexões 
            de outros peers, portanto o endereço fica indisponível pa-
            ra outras funções, que são realizadas por sockets temporários.
            
            As conexões são estabelecidas dentro de um loop que é encerrado apenas 
            quando o método stop é executado.
            
            O formato das requisições segue o padrão de separação do seu tipo e
            dos argumetnos por "/" em uma única mensagem, deixando aberta a pos-
            sibilidade de ampliação para outros tipos de requisições.
            
            É verificado se o arquivo solicitado existe na pasta atribuída ao peer,
            retornando uma flag de confirmação para o requerente. A transferência é
            iniciada em uma nova thread caso o arquivo esteja disponível.
            """            
            S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            S.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
            S.bind(self.peer_addr)
            S.listen(5)
            
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
        """
        Método para definição dos atributos da classe contendo o endereço do peer,
        a sua pasta de arquivos e a lista de arquivos contidos na pasta no momento da
        atribuição.

        Args:
            addr (Tuple[str, int]): Endereço do peer (IP, porta).
            folder (str): Endereço da pasta de arquivos do peer.
        """        
        self.addr = addr
        self.folder = folder
        self.files = os.listdir(folder)
    
    def __set_server_addr(self, addr: Tuple[str, int]):
        """
        Método para definição dos atributos da classe contendo o endereço do servidor.

        Args:
            addr (Tuple[str, int]): Endereço do servidor (IP, porta)
        """        
        self.server_addr = addr
        
    def join(self, addr: Tuple[str, int], folder: str):
        """
        Método para execução de uma requisição JOIN.
        
        A função encerra a thread responsável por ouvir requisições de peers
        caso o worker esteja ativo a fim de liberar a porta para a requisição
        ao servidor. O endereço do peer é atualizado com as informações passadas 
        para a função.
        
        A requisição é enviada em uma única mensagem informando o tipo (JOIN) e a lista 
        de arquivos do peer, separados por "/". O peer aguarda indefinidamente pela con-
        firmação do servidor com a mensagem JOIN_OK.
        
        Após o join, uma nova thread com um worker é iniciada, ouvindo
        requisições no endereço determinado.

        Args:
            addr (Tuple[str, int]): Endereço (IP, porta) identificando o peer.
            folder (str): Endereço do diretório de arquivos do peer.
        """        
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
        """Método para execução da requisição SEARCH.
        
        A requisição é feita por um socket temporário. O socket próprio 
        do peer é utilizado para receber conexões e o servidor não guarda 
        ou verifica as informações de uma requisição SEARCH.
        
        A requisição é feita em uma única mensagem informando o tipo (SEARCH) e
        o nome do arquivo buscado, separados por "/". A resposta do servidor é
        uma lista (possivelmente vazia) serializada com endereços dos peers en-
        contrados.
        
        O nome do arquivo buscado é salvo no atributo "last_search". A informação
        é utilizada na requisição DOWNLOAD.

        Args:
            file_name (str): Nome do arquivo a ser buscado.
        """        
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as S:
            S.connect(self.server_addr)
            S.send(f"SEARCH/{file_name}".encode())

            response = S.recv(1024)
            known_peers = pickle.loads(response)
                
            logging.info("peers com arquivo solicitado: {}".format(
                ' '.join(f"{ip}:{p}" for ip, p in known_peers)
            ))
            
            self.last_search = file_name
        
    def download(self, addr: Tuple[str, int]):
        """
        Método de execução da requisição DOWNLOAD.
        
        A requisição é feita utilizando o nome do último arqivo buscado 
        no servidor. 
        
        É instanciada um novo worker que recebe as informações pertinentes 
        e executa a solicitação de download e o recebimento do arquivo em uma
        thread separada.

        Args:
            addr (Tuple[str, int]): Endereço do peer requisitado.
        """           
        if self.last_search is not None:
            self.DownloadWorker(
                request_addr = addr,
                file_name = self.last_search,
                folder = self.folder,
                self_addr = self.addr,
                server_addr = self.server_addr
            ).start()
        
    def __wait_for_requests(self):
        """
        Método auxiliar para a inicialização do worker responsável por responder 
        requisições de peers em uma thread independente.
        """        
        self.request_worker = self.RequestWorker(
            peer_addr = self.addr,
            folder = self.folder,
            files = self.files
        )
        self.request_worker.start()
        
    def __terminate_worker(self):
        """
        Método auxiliar para o encerramento do worker de recebimento de requisições.
        """        
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
    parser.add_argument(
        '--server_ip',
        '-si',
        action = 'store',
        type = str,
        dest = 'server_ip',
        default = '127.0.0.1',
    )
    parser.add_argument(
        '--server_port',
        '-sp',
        action = 'store',
        type = int,
        dest = 'server_port',
        default = 1099
    )
    
    args = parser.parse_args()
    
    # A classe é instanciada com as informações passadas por argumento do script,
    # e um primeiro JOIN é executado já durante a instanciação.
    peer = Peer(
        addr = (args.ip, args.port),
        folder = args.folder,
        server_addr = (args.server_ip, args.server_port)
    )
    
    # Rotina para interação com o usuário.
    # Cada solicitação feita deve seguir um padrão onde
    # o primeiro caracter é o identificador do tipo de requisição,
    # e os argumentos necessários e determinados nos requisitos do projeto
    # são passados na mesma linha, separados por espaço. Por exemplo:
    # JOIN:     1 127.0.0.2 1234 pasta/de/arquivos/do/peer
    # SEARCH:   2 arquivo_buscado.mp4
    # DOWNLOAD: 3 127.0.0.3 1234
    while True:
        print("Menu: 1 - JOIN; 2 - SEARCH; 3 - DOWNLOAD")
        
        try:
            opt = input()
            opt = opt.split(" ")
            opt, params = opt[0], opt[1:]
        except IndexError:
            continue
        
        if opt == "1":
            ip, port, folder = tuple(params)
            peer.join((ip, int(port)), folder)
        elif opt == "2":
            file_name = " ".join(params)
            peer.search(file_name)
        elif opt == "3":
            try:
                ip = params[0]
                port = params[1]
            except IndexError:
                continue
            
            peer.download((ip,int(port)))