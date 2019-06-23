import numpy as np
from random import random as rand
import matplotlib.pyplot as plt
from matplotlib import animation #comente ou apague essa linha se ela der problemas (requer matplotlib 2.0.0 e adiante). Necessario apenas para a funcao animate_histo

N = 0
#T = []

T = np.array([[ 0.  ,  1.   ,  1.   ],
              [ 0.  ,  1.   ,  2.   ],
              [ 1.  ,  1.   ,  0.   ]])

TA = np.array([[ 0.  ,  0.   ,  1.   , 0.  ,  0.   ,  0.   , 0.  ],
               [ 1.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ],
               [ 0.  ,  1.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ],
               [ 0.  ,  0.   ,  0.2  , 0.4 ,  0.2  ,  0.2  , 0.  ],
               [ 0.  ,  0.   ,  0.2  , 0.2 ,  0.4  ,  0.2  , 0.  ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 1.  ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  1.   , 0.  ]
               ])

TB = np.array([[ 0.8 ,  0.2  ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   ],
               [ 0.5 ,  0.   ,  0.5  , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   ],
               [ 0.  ,  0.   ,  0.5  , 0.25,  0.   ,  0.   , 0.  ,  0.   ,  0.25 , 0.  ,  0.   ,  0.   ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  1.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.5  ,  0.5  , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   ],
               [ 0.  ,  0.   ,  0.   , 1.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.5  , 0.  ,  0.5  ,  0.   , 0.  ,  0.   ,  0.   ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.5 ,  0.   ,  0.   , 0.5 ,  0.   ,  0.   ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 1.  ,  0.   ,  0.   ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.5  , 0.  ,  0.5  ,  0.   ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  1.   ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 1.  ,  0.   ,  0.   ]
               ])

TC = np.array([[ 1.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ],
               [ 0.5 ,  1.   ,  0.5  , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ],
               [ 0.  ,  0.5  ,  1.   , 0.5 ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ],
               [ 0.  ,  0.   ,  0.5  , 1.  ,  0.5  ,  0.   , 0.  ,  0.   ,  0.   , 0.  ],
               [ 0.  ,  0.   ,  0.   , 0.5 ,  1.   ,  0.5  , 0.  ,  0.   ,  0.   , 0.  ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.5  ,  1.   , 0.5 ,  0.   ,  0.   , 0.  ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.5  , 1.  ,  0.5  ,  0.   , 0.  ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.5 ,  1.   ,  0.5  , 0.  ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.5  ,  1.   , 0.5 ],
               [ 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  0.   , 0.  ,  0.   ,  1.   , 1.  ]
               ])

#matriz de transicoes nao normalizada
v0 = np.array([ 1.  ,  0.   ,  0.   ])
#distribuicao inicial

def normalize():
    global N
    global T
    global v0
    N = len(T[0])
    T = np.array(T, dtype = float)
    for i in range(N):
        T[i] /= sum(T[i])
    v0 = np.array(v0, dtype = float)/sum(v0)
#arruma a matriz de transicao (nao checa se as entradas sao positivas)

def iterate(v):
    return np.dot(v, T)
#dado um vetor P_t, retorna P_(t+1)

def markov_step(i):
    p = rand()
    for j in range(N):
        p -= T[i][j]
        if p<= 0:
            return j
#simula um passo na cadeia de Markov (evolucao da variavel aleatoria no experimento)

def theoretical_evolution(v, steps):
    evolution = [v]
    for i in range(steps):
        evolution.append(iterate(evolution[-1]))
    return np.array(evolution).transpose()
#Calcula a evolucao teorica, multiplicando sucessivamente pela matriz de transicao
#usa 'v_0' como condicao inicial e faz 'steps' passos
#Se evolution eh o resultado, entao evolution[i] dah a evolucao no tempo de Pr(X(t) = i)

def realizations(v_0, steps, num_sims):
    evolution = []
    for i in range(num_sims):
        realization = []
        p = rand()
        for j in range(N):
            p -= v_0[j]
            if p <= 0:
                state = j
                break
        realization.append(state)
        for j in range(steps):
            state = markov_step(state)
            realization.append(state)
        evolution.append(realization)
    return evolution
#Realiza 'num_sims' simulacoes, com 'steps' passos cada uma, usando 'v_0' como condicao inicial

def processing_realizations(real_evo):
    real_evo  = np.array(real_evo).transpose()
    num_sims  = real_evo.shape[-1]
    count_evo = []
    for x in real_evo:
        index, count = np.unique(x, return_counts = True)
        aux          = [0]*N
        for i in range(len(index)):
            aux[index[i]] = count[i]
        count_evo.append(aux)
    count_evo = np.array(count_evo).transpose()/num_sims
    sigma_evo = np.sqrt((count_evo)*(1-count_evo)/num_sims)
#estimativa de frequencias e desvio padrao a partir da amostra, para a frequencia
    return (count_evo, sigma_evo)
#processa as simulacoes das cadeias, para um formato mais amigavel para o resto das funcoes.
#O argumento eh algo retornado por 'realizations'

colors = ["k", "b", "r", "g", "y", "c", "o"]
#as cores dos graficos

def make_comparison_graph(v_0, steps, num_sims):
    theory    = theoretical_evolution(v_0, steps)
    av, sigma = processing_realizations(realizations(v_0, steps, num_sims))
    t = np.array(range(steps + 1))
    for i in range(N):
        plt.plot(t, theory[i], "-" + colors[i%7], label = str(i))
        plt.errorbar(t, av[i], yerr = sigma[i], fmt = "-" + colors[i%7])
    plt.legend()


def graph_realizations(v_0, steps, num_sims):
    for x in realizations(v_0, steps, num_sims):
        plt.plot(x, "-k", alpha = 0.5)


def graph_theory(v_0, steps):
    theory    = theoretical_evolution(v_0, steps)
    t = np.array(range(steps + 1))
    for i in range(N):
        plt.plot(t, theory[i], "-" + colors[i%7], label = str(i))
    plt.legend()
#funcoes que fazem os graficos direto










# Funcoes que fazem as animacoes
def init_animation():
    global rects, fig, xlim, ylim, ax
    
    ax = fig.add_subplot(111, autoscale_on=False, xlim=xlim, ylim=ylim)
    for i in range(len(colors)):
        rects = ax.bar(range(N), [0]*N, width = 1, fill = False).get_children()
    return fig,


def update_animation(i):
    for j in range(N):
        rects[j].set_height(data[i//repeat][j])
    return fig,


def animate(anim_name, v_0, steps, interval = 50):
    global fig, xlim, ylim, data, repeat
    
    repeat = interval // 50
    if repeat == 0:
        repeat = 1
    xlim = (-0.5, N - 0.5)
    ylim = (0, 1.)
    data = theoretical_evolution(v_0, steps).transpose()
    plt.ioff()
    fig  = plt.figure(figsize = (8, 8), dpi = 300)
    anim = animation.FuncAnimation(fig, update_animation, init_func=init_animation, frames=steps*repeat, interval = interval, blit=True)    # Anima
    anim.save(anim_name, fps=20, extra_args=['-vcodec', 'libx264'])    # Salva
    plt.close(fig)
    plt.ion()

vA = np.array([ 0.  ,  0.   ,  0.25 , 0.25 ,  0.25 ,  0.25 , 0.  ])
vB1 = np.array([ 1.  ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ])
vB2 = np.array([ 0.  ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  1.   ])
vB3 = np.array([ 0.  ,  0.   ,  0.   ,  1.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ])
vB4 = np.array([ 0.  ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  1.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ])
vC  = np.array([ 0.  ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  0.   ,  1.   ])

#T = TA
#normalize()
#animate("animA.mp4", vA, 50, interval = 100)
#T = TB
#normalize()
#animate("animB1.mp4", vB1, 50, interval = 100)
#animate("animB2.mp4", vB2, 50, interval = 100)
#animate("animB3.mp4", vB3, 50, interval = 100)
#animate("animB4.mp4", vB4, 50, interval = 100)
#T = TC
#normalize()
#animate("animC.mp4", vC, 300, interval = 100)

#para gerar as animacoes feitas em aula descomente essa parte












normalize()

#Instrucoes:
#
#Rode o script no modo interativo para ter acesso aos comandos:
#
#python -i markov-run.py
#
#no terminal mesmo se estiver usando linux, windows ou mac
#
#Para especificar uma matriz de transicao nova, mude a definicao de T (antes de rodar o script, ou introduzindo o novo T atraves de um comando e rodando normalize() logo em seguida). As linhas nao precisam somar 1 ('normalize' arruma isso), apenas refletir as proporcoes entre as diferentes probabilidades de transicao partindo do estado correspondente a uma dada linha
#Se quiser mudar a condicao inicial, mude a definicao de v0 (se mudar T para ter mais do que 3 estados, lembre-se de mudar v0 para tambem ter o mesmo numero de estados)


#graph_theory(v_0, steps) plota a evolucao teorica, partindo de v_0 como condicao inicial e usando t = 0, 1, ..., steps

#make_comparison_graph(v_0, steps, num_sims) faz 'num_sims' simulacoes e plota a comparacao das probabilidades estimadas com a previsao teorica. Usa v_0 como condicao inicial e t = 0, ..., steps

#graph_realizations(v_0, steps, num_sims) faz as mesmas simulacoes que a anterior, mas plota t por X(t) pra todas elas, ou seja a evolucao dos estados no tempo.
#
#Pro grafico dessa aqui nao ficar incompreensivel, precisa escolher uma matriz de transicao e a ordem dos indices, de forma que os estados que "atraem a trajetoria" fiquem agrupados.
#
#A parte que faz o grafico fica pesada (leva 1~2 minutos) por volta de umas 5000 simulacoes












