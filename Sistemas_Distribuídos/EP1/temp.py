import socket
if __name__ == "__main__":
    S = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    S.connect(("127.0.0.3", 1235))
    
    S.send("DOWNLOAD&peer.py".encode())
    if S.recv(1024).decode() == "UNAVAILABLE":
        print("UNAVAIALBLE")
    else:
        with open("received.py", "wb") as f:
            while True:
                data = S.recv(1024)
                if not data:
                    break
                else:
                    f.write(data)