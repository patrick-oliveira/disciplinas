from typing import Union

class Message:
    request_type: str
    key: Union[str, None]
    value: Union[object, None]
    timestamp: Union[str, None]
    
    def __init__(
        self,
        request_type: str,
        key: str = None,
        value: str = None,
        timestamp: str = None
    ):
        self.request_type = request_type
        self.key = key
        self.value = value
        self.timestamp = timestamp