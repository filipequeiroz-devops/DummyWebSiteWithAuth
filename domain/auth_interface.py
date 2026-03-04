from abc import ABC, abstractmethod

class AuthInterface(ABC):
    @abstractmethod
    def signup(self, email, password):
        pass