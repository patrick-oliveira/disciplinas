# Utility functions
empty = lambda x: len(x) == 0

def isGoal(st):
    return feasible(st) and len(st[0]) == 8

def feasible( st ):
    s, t = st
    if len(s) == 0: return True
    return (len(s) <= 8) and (not attack(s[0], s[1:])) and feasible((s[1:], t))

def attack(r, rs):
    return (r in rs) or (r in upperDiag(rs)) or (r in lowerDiag(rs))
def upperDiag(rs):
    return [x+y for x, y in zip(rs, range(1, 9))]
def lowerDiag(rs):
    return [x-y for x, y in zip(rs, range(1, 9))]

def move(x, st):
    return ([x] + st[0], [x] + st[1])

# Depth-first search
def dfs( st, n ):
    """
    A busca por profundidade verifica se um movimento é a solução antes
    de aumentar a busca por um próximo nodo. A função recebe um estado
    em que uma última rainha acabou de ser adicionada.
    """
    state, moves = st
    if isGoal(st): return [st], n
    if not feasible(st): return [emptySt], n
    
    new_sts = [] # guarda os movimentos válidos feitos
    for x in range(1, 9): # cada chamada recursiva de DFS tenta adicionar
        # uma rainha em uma coluna, tentando todas as 8 posições possíveis
        new_st, n = dfs( move(x, st), n+1 ) # retorna um novo estado e 
        if len(new_st) > 0 and new_st[0] != emptySt:
            new_sts.append(new_st[0]) # um movimento é salvo se ele é
            # válido ou é uma solução
    return new_sts, n

def main():
    """
    O algoritmo colocará as rainhas uma a uma até que as 8 estejam cor-
    retamente posicionadas. É uma busca em árvore, então ele adiciona
    a primeira rainha na primeira posição da primeira coluna, tenta adi-
    cionar a segunda rainha na segunda coluna, etc, aumentando a árvore
    conforme faz a busca.
    """
    initialState = ([], [])
    print( bfs([initialState]) )
    
    state, n = dfs(initialState, 0)
    print(state[0], n)
    
    
def __main__():
    main()