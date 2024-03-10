# Conteúdo
- Paradigmas de Programação
- Conceitos básicos do Haskell + Ambiente de programação

# Exercícios

1. Faça uma função `mult3 n` que retorne `True` caso a entrada seja múltiplo de 3 e `False` caso contrário.
2. Faça uma função `mult8 n` que retorne `True` caso a entrada seja múltiplo de 8 e `False` caso contrário.
3. Faça uma função `mult83 x` que retorne `True` caso a entrada seja múltiplo de 3 e 8 e `False` caso contrário.
4. Faça uma função `ehPrimo n` determina se um número é primo.
5. Faça uma função `bissextos` que retorne todos os anos bissextos até 2020, começando pelo ano 1584. Os anos bissextos são aqueles não múltiplos de 100 e múltiplos de 4, ou múltiplos de 400.
6. Faça uma função `lastNBissextos n` que encontre os N últimos anos bissextos (até 2020).
7. Faça uma função `stringToIntegers s` que recebe uma string s contendo somente números (_e.g._ "01234") e devolva uma lista com os dı́gitos em formato Integer.
8. Faça uma funcao `ex8 x` que retorna `True` caso a entrada seja maior que -1 E (menor que 300 OU múltiplo de 6), e `False` caso contrário.
0. Sem utilizar qualquer ajuda, determine o Tipo das seguintes expressões. Depois, utilize o _ghci_ para confirmar suas respostas.
    - `1.2`
    - `[1, 2]`
    - `(1, 2)`
    - `"1, 2"`
    - `'🤔'`
10. Defina as assinaturas de tipo e implemente as funções abaixo:
    - Função `subtrair`, que recebe dois valores inteiros (`Int`) e retorna a diferença do primeiro pelo segundo
    - Função `dobro`, que recebe um valor inteiro (`Int`) e retorna o seu dobro
    - Função `quad`, que recebe um valor inteiro  (`Int`) e retorna seu quadrado
    - Função `cumprimentar`, que recebe um nome e retorna "Olá *nome*" (considere o operador de concatenação `++`)
    - Função `aniversario`, que recebe um ano de nascimento e retorna a string "Você fará {x} anos em 2023!"


# Orientações

As definições das funções solicitadas acima estão no arquivo `Atividade01.hs`, localizado na pasta `src`. Este é o **único** arquivo que você precisa editar. Você deve implementar as funções acima **sem alterar seus nomes ou tipos** já definidos no arquivo. Você pode criar funções auxiliares da forma que achar melhor.

Os casos de teste estão no arquivo `Spec.hs`, dentro da pasta `test`. **Não modifique o arquivo Spec.hs**. Após implementar suas funções no arquivo `Atividade01.hs`, basta digitar
`stack test`
e acompanhar em quais casos de teste seu código passou.

Você pode criar funções auxiliares da forma que achar melhor, mas as funções chamadas no arquivo `Spec.hs` devem, obviamente, constar no arquivo `Atividade01.hs` (caso contrário dará erro nos testes).
