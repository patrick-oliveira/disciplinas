from typing import Union, Tuple

class Message:
    request_type: str
    addr: Union[Tuple[str, int], None]
    key: Union[str, None]
    value: Union[object, None]
    timestamp: Union[str, None]
    
    def __init__(
        self,
        request_type: str,
        addr: Tuple[str, int] = None,
        key: str = None,
        value: str = None,
        timestamp: str = None
    ):
        self.request_type = request_type
        self.addr = addr
        self.key = key
        self.value = value
        self.timestamp = timestamp