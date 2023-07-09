from typing import Union

class Message:
    type: str
    key: Union[str, None]
    value: Union[object, None]
    timestamp: Union[str, None]
    
    def __init__(
        self,
        type: str,
        key: str = None,
        value: str = None,
        timestamp: str = None
    ):
        self.type = type
        self.key = key
        self.value = value
        self.timestamp = timestamp