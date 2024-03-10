[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/LdJ1Csq2)
# Atividade 02

## Conteúdo

| Tópico                    | Material de Estudo                                                       | Playlist                                                                 |
| ------------------------- | ------------------------------------------------------------------------ | ------------------------------------------------------------------------ |
Cálculo Lambda|https://haskell.pesquisa.ufabc.edu.br/posts/haskell/02.lambda.html|https://www.youtube.com/playlist?list=PLYItvall0TqKPbnSblJ_fxNIFRgEoI-7_
Conceitos Básicos - Parte 1|https://haskell.pesquisa.ufabc.edu.br/posts/haskell/03.haskell.basico.1.html|https://www.youtube.com/playlist?list=PLYItvall0TqLlCPN9vbDIc8FAKhG-RfbM
Conceitos Básicos - Parte 2 | https://haskell.pesquisa.ufabc.edu.br/posts/haskell/04.haskell.basico.2.html | https://www.youtube.com/playlist?list=PLYItvall0TqLlCPN9vbDIc8FAKhG-RfbM
QuickCheck|https://haskell.pesquisa.ufabc.edu.br/posts/haskell/05.quickcheck.html|https://www.youtube.com/playlist?list=PLYItvall0TqJ25sVTLcMhxsE0Hci58mpQ
Funções de Alta Ordem|https://haskell.pesquisa.ufabc.edu.br/posts/haskell/06.higher.order.html|https://www.youtube.com/playlist?list=PLYItvall0TqLBLt6oXFVBaloU7-xZsV-v



## Exercícios (10 pontos)

Defina as assinaturas de tipo e implemente as funções abaixo:


1. ★☆☆ Função `multiplicar`, que recebe dois valores inteiros e retorna o produto do primeiro pelo segundo
2. ★☆☆ Função `cumprimentar`, que recebe um nome e retorna "A linguagem preferida de _nome_ é Haskell" (considere o operador de concatenação `++`)
3. ★☆☆ Função `velocidade`, que recebe uma distância em km e a quantidade de horas que ela levou para ser percorrida, ambos do tipo `Float`, e retorna a string "Isso equivale a {x} kilômetros por hora!"
4. ★☆☆ Função `mult7 n` que retorne `True` caso a entrada seja múltiplo de 7 e `False` caso contrário.
5. ★☆☆ Função `somaEhMult7`, que recebe um dois valores inteiros e retorna se a soma é múltipla de 7
6. ★★☆ Faça uma função `estaNoIntervalo a b c` que recebe três inteiros e decida se `a` está contido no intervalo fechado entre o `b` e `c`. Assuma que `b < c` sempre.
7. ★★☆ Faça uma função `todosNoIntervalo :: [Int] -> Int -> Int -> Bool` que determina se **todos** os números da primeira lista estão no intervalo descrito pelo segundo e terceiro argumento.
8. ★★☆ Similarmente, faça uma função `algumNoIntervalo :: [Int] -> Int -> Int -> Bool` que determina se **pelo menos um** dos números da primeira lista está no intervalo descrito pelo segundo e terceiro argumento.
9. ★★★ Faça uma função `ehPerfeito n` que determine se um número é perfeito. Dizemos que um número é perfeito quando a soma de todos os seus divisores naturais próprios (excluindo ele mesmo) é igual ao próprio número. Por exemplo, o número 28 é perfeito, pois: 28 = 1 + 2 + 4 + 7 + 14. (Def. Wikipedia)
10. ★★★ Faça uma função `procuraSeis` que retorne todos os os números entre 0 e 999 cuja soma dos dígitos é 6.
11. ★☆☆ Usando map, crie uma função `comprimentoAoQuadrado xs` que recebe uma lista de strings e, como o nome sugere, retorna os seus comprimentos ao quadrado. Exemplo:
    - `comprimentoAoQuadrado ["ola", "mundo"] == [9, 25]`
12. ★☆☆ Defina a função `findLast f xs` que retorne o último elemento de `xs` que satisfaz o predicado `f`. Assuma que a lista sempre conterá ao menos um elemento que satisfaz o predicado.
13. ★☆☆ Crie uma função `gerarUsuarios n prefixo` que recebe um `n` inteiro e um `prefixo` em string e tem o seguinte comportamento:
    - `gerarUsuarios 3 "pessoa" == ["pessoa1", "pessoa2", "pessoa3"]`
    - `gerarUsuarios 5 "usuario" == ["usuario1", "usuario2", "usuario3", "usuario4", "usuario5"]`
14. ★☆☆ O gerente de uma loja resolveu conceder um desconto de 10 reais em todos os produtos. Porém, como ele é muito supersticioso, caso o valor do produto com o desconto seja múltiplo de 7, esse produto deve ser descartado. Faça uma função `descontoDaSorte precos` que simule esse comportamento, considerando que a loja só vende produtos com preços inteiros.
    - `descontoDaSorte [17, 22, 35, 31] == [12, 25]`
15. ★★☆ Crie uma função `limparUsernames usernames` que recebe uma lista de strings `usernames` e limpa cada um dos nomes. Um username limpo, nesse caso, é aquele composto apenas por caracteres alfanuméricos (considere a função `isAlphaNum` do módulo `Data.Char`)
    - `limparUsernames ["joao_123", "Maria.456"] == ["joao123", "Maria456"]`
16. ★★☆ Crie uma função `maisDaMetade f xs` que retorne um booleano indicando se mais da metade dos valores da lista `xs` atende a um dado predicado `f`. Assuma que a lista nunca estará vazia. Por exemplo:
    - em uma lista de 3 elementos, ao menos 2 devem satisfazer o predicado;
    - em uma lista de 4 elementos, ao menos 3 devem safisfazer o predicado.
17. ★★★ Crie uma função `filterDesastrado f xs` que recebe um predicado `f` e uma lista `xs` e remove os elementos que não atendem ao predicado. No entanto, ao encontrar um elemento que deve ser removido, a função (por ser desastrada) também remove o último elemento que ela deixou passar, se existir. Exemplo:
    - `filterDesastrado (\x -> x < 10) [1, 5, 7, 10, 3, 4, 15, 9] = [1, 5, 3, 9]`
    - `filterDesastrado (\x -> x < 10) [1, 2, 3, 11, 12, 7] = [1, 7]`
18. ★★★ Crie uma função `palavraMaisLonga palavras` que receba uma lista de strings e retorne aquela que tem o maior comprimento. No caso de empate, a palavra que apareceu primeiro deve prevalecer. Assuma que a lista nunca estará vazia.
19. ★★★ Implemente uma função `jogadorBlackJack` que recebe uma lista de inteiros de 1 a 10, representando as cartas. Este jogador vai comprando cartas em ordem, até que a soma de sua mão seja `>= 18`. Retorne se o valor final da mão do jogador é válido, isto é, `<= 21`. Assuma que a lista fornecida nunca estará vazia.





> OBS: Enquanto você não tiver escrito as assinaturas de determinadas funções, os casos de teste não irão nem compilar. Logo, sugere-se que você comece pelas assinaturas, para só depois partir para a implementação.
