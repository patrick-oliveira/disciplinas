module Atividade01
    ( mult3,
    mult8,
    mult83,
    ehPrimo,
    bissextos,
    lastNBissextos,
    stringToIntegers,
    ex8,
    subtrair,
    dobro,
    quad,
    aniversario,
    cumprimentar
    ) where

{-Exercício 01: Faça uma função {mult3 n} que retorne True caso a entrada seja múltiplo de 3 e False caso contrário.-}
mult3 :: (Eq x, Num x, Integral x) => x -> Bool


{-Exercício 02: Faça uma função {mult8 n} que retorne True caso a entrada seja múltiplo de 8 e False caso contrário.-}
mult8 :: (Eq x, Num x, Integral x) => x -> Bool


{-Exercício 03: Faça uma função {mult83 x} que retorne True caso a entrada seja múltiplo de 3 e 8 e False caso contrário.-}
mult83 :: (Eq x, Num x, Integral x) => x -> Bool


{-Exercício 04: Faça uma função {ehPrimo n} que determina se um número é primo..-}
ehPrimo :: Integral a => a -> Bool


{-Exercício 05: Faça uma função {bissextos} que retorne todos os anos bissextos até 2020, começando pelo ano 1584.-}
bissextos :: [Integer]


{-Exercício 06: Faça uma função {lastNBissextos n} que encontre os N últimos anos bissextos.-}
lastNBissextos :: Int -> [Integer]


{-Exercício 7: Faça uma função {stringToIntegers s} que recebe uma string s contendo somente números (e.g. ``01234") e devolva uma lista com os dígitos em formato Integer.-}
stringToIntegers :: String -> [Integer]


{-Exercício 08: Faça uma funcao {ex8 x}  retorne True caso a entrada seja maior que -1 E (menor que 300 OU múltiplo de 6), e False caso contrário.-}
ex8 :: (Eq x, Num x, Integral x) => x -> Bool


{-Exercício 10:-}
subtrair a b =

dobro a =

quad a =

cumprimentar nome =

aniversario ano =
