# O estado será representado por um par ([], []), podendo estar limpo
# ou sujo (1 ou 2), e o agente pode estar ou não em um quadrado (1 e -1)
# Em cada jogada um quadrado pode aleatoriamente ficar sujo. O agente deve
# limpar caso identifique o atual quadrado como sujo ou mover-se para o quadrado
# vizinho caso identifique o atual quadrado como limpo.
from numpy.random import normal as norm

def mover(S):
    return [-S[0], -S[1]]

def posicaoAgente(S):
    if S[0] > 0:
        return 0
    else:
        return 1

def verificaSujeira(S, i):
    if S[i]%2 == 0:
        return True
    return False
    
def limpar(S, i):
    S[i] = int(S[i]/2)
    return S

def sujar(S):
    dado = norm()
    if abs(dado) > 0.5:
        if dado <= 0:
            if abs(S[0]) == 1: S[0] = S[0]*2
        else:
            if abs(S[1]) == 1: S[1] = S[1]*2
    return S

def pontuar(S):
    pontos = 0
    for q in S:
        if abs(q) == 1:
            pontos += 1
    return pontos

def simular(S0):
    jogadas = 1000
    score = 0
    S = S0
    for k in range(jogadas):
        sujar(S)
    #     print("Antes do movimento: {}".format(S))
        if verificaSujeira(S, posicaoAgente(S)):
            limpar(S, posicaoAgente(S))
        else:
            S = mover(S)
        score += pontuar(S)
    #     print("Depois: {} ; Pontuação: {}\n".format(S, score))

    return score
    
def __main__():
    scores = list()
    # bot no primeiro quadrado
    # ambos os quadrados sujos
    scores.append(simular([2, -2]))
    # ambos os quadrados limpos
    scores.append(simular([1, -1]))
    # primeiro quadrado sujo e segundo limpo
    scores.append(simular([2, -1]))
    # primeiro limpo e segundo sujo
    scores.append(simular([1, -2]))
    
    # bot no segundo quadrado
    # ambos os quadrados sujos
    scores.append(simular([-2, 2]))
    # ambos os quadrados limpos
    scores.append(simular([-1, 1]))
    # primeiro quadrado sujo e segundo limpo
    scores.append(simular([-2, 1]))
    # primeiro limpo e segundo sujo
    scores.append(simular([-1, 2]))
    sum = 0
    for score in scores:
        print(score)
        sum = sum + score
        
    print(sum/len(scores))