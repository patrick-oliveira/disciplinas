import sqlite3
import socket
import pickle

from typing import Tuple, List
from sqlite3 import IntegrityError

class Server:
    server_ip: str
    port: int
    s: socket.socket
    db_file: str
    
    def __init__(
        self,
        server_ip: str,
        port: int,
        db_file: str = "registry.db"
    ):
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server_ip = server_ip
        self.port = port
        
        self.db_file = db_file
        self.__initialize_registry()
        
    def __create_db_connection(self):
        conn = sqlite3.connect(self.db_file)
        return conn
    
    def __initialize_registry(self):
        conn = self.__create_db_connection()
        
        c = conn.cursor()
        c.execute(
            '''
            CREATE TABLE IF NOT EXISTS registry (
                file text NOT NULL,
                ip text NOT NULL,
                port integer NOT NULL,
                PRIMARY KEY (file, ip, port)
            )
            '''
        )
        
        conn.close()
        
    def __register_files(
        self,
        addr: Tuple[str, int],
        file_list: List[str]
    ):
        rows = [(f, addr[0], addr[1]) for f in file_list]
        
        conn = self.__create_db_connection()
        c = conn.cursor()
        try:
            c.executemany(
                """
                INSERT INTO registry(file, ip, port) VALUES (?, ?, ?)
                """,
                rows
            )
            conn.commit()
            
            return True
        except IntegrityError:
            return False
        finally:
            conn.close()
        
    def __search_file(
        self,
        file_name: str
    ):
        conn = self.__create_db_connection()
        c = conn.cursor()
        c.execute(
            '''
            SELECT ip, port FROM registry WHERE file=\'{}\'
            '''.format(file_name)
        )
        rows = c.fetchall()
        rows = list(set(rows))
        
        conn.close()
        return rows
        
    def run(self):
        self.s.bind((self.server_ip, self.port))
        self.s.listen(5)
        
        while True:
            c, addr = self.s.accept()
            
            request = c.recv(1024).decode().split("&")
            request_type = request[0]
            request_body = request[1]
            
            if request_type == "JOIN":
                print("Received join.")
                files = request_body.split(" ")
                if self.__register_files(addr, files):
                    print(f"Peer {addr[0]}:{addr[1]} adicionado com arquivos {request_body}")  # noqa: E501
                
                c.send("JOIN_OK".encode())
            elif request_type == "UPDATE":
                filename, ip, port = tuple(request_body)
                self.__register_files((ip, port), [filename])
                c.send("UPDATE_OK".encode())
            elif request_type == "SEARCH":
                print(f"Peer {addr[0]}:{addr[1]} solicitou arquivo {request_body}")
                
                known_peers = self.__search_file(request_body)
                known_peers = pickle.dumps(known_peers)
                c.sendall(known_peers)
            
            c.close()
            
            
            
if __name__ == "__main__":
    server = Server(
        server_ip = '127.0.0.1',
        port = 1099
    )
    server.run()