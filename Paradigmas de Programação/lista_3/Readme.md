[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/KhBwAW_N)
# Exercícios

1. Faça uma função `integersDePrimos xs` que receba uma lista de inteiros e retorna uma lista de inteiros com os números primos contidos na lista original (dica: na lista da semana passada havia uma questão para desenvolver uma função que informava se um número é primo ou não).

1. Faça uma função `bissextos32` que retorna uma lista com os anos bissextos entre 1584 e 2016 que são múltiplos de 32 (dica: na lista da semana passada havia uma questão para encontrar os anos bissextos), em que cada elemento dessa nova lista é uma string. A lista deve estar em ordem decrescente.

1. Desenvolva uma função `pop`, que recebe uma lista e um `Integer` _n_. Ela retorna a lista sem o n-ésimo elemento (indexado em 0). 

1. Desenvolva uma função `range`, que recebe uma lista e dois `Integers`, _i_, _j_. Ela retorna a sublista com os elementos do índice _i_ (inclusivo) a _j_ (exclusivo), similar à função `range` da linguagem Python.

1. Desevolva uma função `palindrome` que recebe uma palavra (`String`) e retorne `True` caso ela seja palíndrome, ou `False` caso contrário. Não utilize a função `reverse`.


1. Faça funções `Int -> [Int]` que recebam um valor `n` de entrada e retornem uma lista com os `n` primeiros números:
    - **Naturais**: `naturais 3 == [0, 1, 2]`
    - **Pares positivos**: `pp 3 == [2, 4, 6]`
    - **Naturais, mas em ordem decrescente**: `natdesc 3 == [2, 1, 0]`
    
1. Defina as assinaturas de tipo e implemente as funções abaixo:
    - Função `maximo` e `minimo`, que retornam o maior e menor valor, respectivamente
    - Função `media`, que retorna o valor médio entre dois valores numéricos
    - Função `xou`, que realiza a operação "ou exclusivo" em dois booleanos
    - Função `ehQuadradoPerfeito :: Int -> Bool` que determina se um número é quadrado perfeito (considere a função `fromIntegral`)
    - Função `ehSaudavel :: Int -> Bool -> Bool -> Bool` que receba idade (Int), se come pizzas (Bool), se faz exercícios de manhã (Bool) e retorne um Bool de acordo com a árvore abaixo 
    ![](https://miro.medium.com/max/820/0*LHzDR-s89Ggfqn7p.png)
    - `penultimo as` que retorna o penultimo elemento da lista `as`
    
1. Defina as assinaturas de tipo e implemente as funções abaixo. Essas funções devem ser **totais**:
    - `isHead a as` que retorna se o elemento `a` é o primeiro da lista `as`
    - `isSecond a as` que retorna se o elemento `a` é o segundo da lista `as`
    - `isAt n a as` que retorna se o elemento `a` está na `n`-ésima posição da lista `as`
    - `mediaLista as` que retorna o valor médio da lista `as`
    - `isFirstEqualThird as` que retorna se o primeiro elemento é igual ao terceiro da lista. Exemplo `isFirstEqualThird [1,2,1,40] == True`

1. Defina a função `quadradoMaisProximo n` que recebe um inteiro `n` e retorna `q`, `q >= n`, tal que `q` seja o quadrado perfeito mais próximo (utilize a função `ehQuadradoPerfeito` escrita por você!)

1. Implemente uma função `ethiopianMultiplication x y` que faz a multiplicação etíope entre dois números. A multiplicação Etíope de dois números m, n é dado pela seguinte regra:

  - Se m for par, o resultado é a aplicação da multiplicação em m/2, n * 2.
  - Se m for ímpar, o resultado a aplicação da multiplicação em m/2, n * 2 somados a n.
  - Se m for igual a 1, retorne n.
   Exemplo:

|m	| n	| r |
|---|---|---|
|14	|12	|0  |
|7	|24	|24 |
|3	|48	|72 |
|1	|96	|168|

1. Defina uma função `isEven x` recursiva que possui um caso base e utilize uma suposta função `isOdd` para retornar `True` caso `x` seja par e `False` caso contrário. De forma similar, defina a função `isOdd x` que retorne `True` caso `x` seja ímpar e `False` caso contrário. Utilize o conceito de co-recursão, ou seja, uma função chama a outra recursivamente.



# Orientações

As definições das funções solicitadas acima estão no arquivo `Atividade03.hs`, localizado na pasta `src`. Este é o **único** arquivo que você precisa editar. Você deve implementar as funções acima **sem alterar seus nomes ou tipos** já definidos no arquivo. Você pode criar funções auxiliares da forma que achar melhor. 

Os casos de teste estão no arquivo `Spec.hs`, dentro da pasta `test`. **Não modifique o arquivo Spec.hs**. Após implementar suas funções no arquivo `Atividade03.hs`, basta digitar 
`stack test`
e acompanhar em quais casos de teste seu código passou.

Você pode criar funções auxiliares da forma que achar melhor, mas as funções chamadas no arquivo `Spec.hs` devem, obviamente, constar no arquivo `Atividade03.hs` (caso contrário dará erro nos testes).
