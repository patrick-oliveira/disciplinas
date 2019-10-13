from numpy.random import normal as norm

class Ambiente():
    def __init__():
        self.estado = [-1, -2, -2, 1, -1, -1, -2, -1, -1, -2]
        
    def sujar():
        for i in range(len(self.estado)):
            if self.estado[i]%2 == 0 and norm() >= 0:
                self.estado[i] = self.estado[i]*2
        
class Agente():
    def __init__(ambiente):
        self.score = 0
        self.posicao = self.posicaoAtual(ambiente)
        self.movimentos = {"direita" :  1,
                           "esquerda": -1}
#         self.decisoesAnteriores = list()
        
    def posicaoAtual(ambiente):
        for i in range(len(ambiente.estado)):
            if ambiente.estado[i] > 0:
                return i
            
    def verificaSujeira(ambiente):
        if ambiente.estado[self.posicao]%2 == 0:
            return True
        return False
    
    def limpar(ambiente):
        i = self.posicao
        ambiente.estado[i] = ambiente.estado[i]//2
#         self.decisoesAnteriores.append([i, 0])
        return ambiente
    
#     def limpar(ambiente):
#         i = self.posicao
#         if norm() >= 0:
#             ambiente.estado[i] = ambiente.estado[i]//2
        
#         return ambiente
        
    def mover(ambiente):
        if norm() >= 0:
            movimento = self.movimentos["direita"]
        else:
            movimento = self.movimentos["esquerda"]
            
        if self.validarMovimento(movimento):
            posAnterior = self.posicao
            self.posicao = self.posicao + movimento
            ambiente.estado[posAnterior] = ambiente.estado[posAnterior]*-1
            ambiente.estado[self.posicao] = ambiente.estado[self.posicao]*-1
#             self.decisoesAnteriores.append([posAnterior, movimento])
            
        return ambiente
            
    def validarMovimento(movimento):
        if self.posicao + movimento > 9 or self.posicao + movimento < 0:
            return False
        return True