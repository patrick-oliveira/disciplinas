from numpy.random import normal as norm
import random

class Ambiente():
    def __init__(tamanho):
        self.tamanho = tamanho
        self.estado = gerarAmbiente(tamanho)
        
    def gerarAmbiente(tamanho):
        ambiente = list()
        for k in range(tamanho):
            ambiente.append(self.listaAleatoria(tamanho))
            
        return ambiente
    
    def listaAleatoria(tamanho):
        lista = list()
        for k in range(tamanho):
            i = random.randrange(1, 3)
            lista.append(-i)
        
        return lista
        
    def sujar():
        for i in range(len(self.estado)):
            if self.estado[i]%2 == 0 and norm() >= 0:
                self.estado[i] = self.estado[i]*2
    
    def posicionarAgente():
        i = random.randrange(0, self.tamanho)
        j = random.randrange(0, self.tamanho)
        
        self.estado[i][j] = -1*self.estado[i][j]
        
    def sujo(xy):
        x, y = xy
        if self.estado[x][y]%2 == 0:
            return True
        return false
                
class Agente():
    def __init__():
        self.score = 0
        self.movimentos = {"cima":     (0, 1),
                           "baixo":    (0, -1),
                           "esquerda": (-1, 0),
                           "direita":  (1, 0)}