[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/pBgjqJdP)
# Semana Bônus
## Orientações

- Essa é uma lista bônus, valendo **30 pontos**!
- O objetivo dessa lista é **desenvolver um pequeno interpretador da linguagem Push**
- Toda a implementação deve ser feita na função `runProgram :: String -> String`, que deve receber um programa e executá-lo, mostrando como saída o estado final de cada pilha. Os formatos devem estar de acordo com os expostos neste readme.
- Há dois conjuntos de testes para ajudá-lo a guiar a implementação. Sua nota será parcialmente determinada pelo resultado de ambos.
- A forma de implementação e modelagem são totalmente livres! Você pode reutilizar pedaços de outras listas que fizemos antes, utilizar bibliotecas externas e extensões do Haskell como bem entender!

## Descrição

A linguagem Push é uma linguagem de programação baseada em pilhas. O intuito da linguagem não é ser utilizada por programadores, mas sim para ser simples de ser se evoluir um programa através de programação genética.

Um tutorial extenso pode ser encontrado em: [🎥https://www.youtube.com/watch?v=iG534vF3wL0](https://www.youtube.com/watch?v=iG534vF3wL0), além, claro, da descrição da linguagem em [http://faculty.hampshire.edu/lspector/push3-description.html#Overview](http://faculty.hampshire.edu/lspector/push3-description.html#Overview).

Em resumo, um programa em Push é baseado em pilhas: uma para cada tipo de dado suportado + um para as instruções do programa (chamado `EXEC`). Podemos descrever o algoritmo principal que o interpretador deve executar

```
To execute program P:
    Push P onto the EXEC stack
    LOOP until the EXEC stack is empty:
        If the first item on the EXEC stack is a single instruction 
            then pop it and execute it.
        Else if the first item on the EXEC stack is a literal 
            then pop it and push it onto the appropriate stack.
        Else (the first item must be a list) pop it and push all of the
            items that it contains back onto the EXEC stack individually,
            in reverse order (so that the item that was first in the list
            ends up on top).
```

Nesse subset da linguagem, vamos contemplar apenas 4 pilhas: **execução**, **ints**, **floats** e **bools**. 


Abaixo há uma lista dos comandos que devemos dar suporte. Cada comando consome os argumentos das pilhas e coloca seu resultado na pilha correspondente.

| Comando      | Explicação                               |
| ------------ | ---------------------------------------- |
| `FloatToInt` | Converte um float em um int, truncando-o |
| `IntToFloat` | Converte um int em um float              |
| `IntAdd`     | Soma dois inteiros                       |
| `IntSub`     | Subtrai dois inteiros                    |
| `IntMult`    | Multiplica dois inteiros                 |
| `IntDiv`     | Divide dois inteiros                     |
| `FloatAdd`   | Soma dois floats                         |
| `FloatSub`   | Subtrai dois floats                      |
| `FloatMult`  | Multiplica dois floats                   |
| `FloatDiv`   | Divide dois floats                       |
| `BoolAnd`    | Realiza a operação de E lógico           |
| `BoolOr`     | Realiza a operação de OU lógico          |

## Exemplos

Alguns exemplos para demonstrar a sintaxe e lógica que deve ser implementada:

### Literais
- Inteiro Literal: `4`, `8`, `16`, `0`
  - Não é preciso dar suporte ao `parse` de ints negativos, mas o seu programa precisa suportar a execução dos mesmos
- Float Literal: `0.0`, `4.0`, `3.14`, `42.18`
  - Não é preciso dar suporte ao `parse` de floats negativos, mas o seu programa precisa suportar a execução dos mesmos
  - Estes valores devem ser representados internamente como `Float`, e não como `Double`, para evitar erros de precisão
- Bool Literal: `True` ou `False`
  - Não é preciso suportar variações como `TRUE` ou `false`

### Listas

Listas, ou parênteses, são uma forma de agrupar várias instruções em uma única instrução.
Ao "executar" uma lista, o seu programa deve colocá-la na pilha de forma "invertida", ou seja, com o elemento que está mais à esquerda ficando no topo.
Exemplo

```
                      A
                      B
                      C
                      D
(A B C D E)           E
----------  ===>  ----------
   EXEC              EXEC   
```

- Listas podem estar infinitamente aninhadas, como `(A B C (D1 D2 D3 (D4A D4B) D5) E)`
- Toda lista sempre se inicia com `(` e termina com `)`. Os elementos internos da lista são sempre separados por apenas um espaço. Não há espaço antes ou após os parênteses.

### Operações

As operações serão sempre listadas no mesmo formato da tabela aqui apresentada. Não é necessário dar suporte à variações como `intadd` ou `int_add` ou `INTADD`.

Alguns comportamentos das operações não são padronizados entre todas as implementações de Push, então nessa seção deixamos explícito as convenções que iremos seguir.

#### Todas as operações seguem a ordem da pilha

Ou seja: `(7 10 IntSub)` deve ser equivalente a `10-7`. Veja:

```
(7 10 IntSub)
----------     -----
   EXEC         INT

    7
    10
  IntSub
----------     -----
   EXEC         INT
   
    10
  IntSub         7
----------     -----
   EXEC         INT

                 10  <- primeiro argumento
  IntSub         7   <- segundo argumento
----------     -----
   EXEC         INT

                 3  <- resultado
----------     -----
   EXEC         INT
```

#### Na falta de argumentos, descarta-se apenas a instrução

Ou seja, os argumentos não sofrem alteração se não são consumidos. Suponha `(1 IntSub)` 

```
  IntSub         1  <- primeiro argumento, mas não temos o segundo :(
----------     -----
   EXEC         INT

                 1  <- instrução descartada, argumento mantido
----------     -----
   EXEC         INT
```
