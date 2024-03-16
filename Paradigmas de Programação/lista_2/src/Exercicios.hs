module Exercicios where

import Data.Char (isAlphaNum)
import Data.List (sortBy)
import GHC.Base (VecElem(Int16ElemRep))

-- Função multiplicar, que recebe dois valores inteiros e retorna o produto do primeiro pelo segundo
-- multiplicar :: ???
multiplicar :: Int -> Int -> Int
multiplicar x y = x * y

-- Função cumprimentar, que recebe um nome e retorna "A linguagem preferida de nome é Haskell" (considere o operador de concatenação ++)
-- cumprimentar :: ???
cumprimentar :: String -> String
cumprimentar nome = "A linguagem preferida de " ++ nome ++ " é Haskell"

-- Função velocidade, que recebe uma distância em km e a quantidade de horas que ela levou para ser percorrida, ambos do tipo Float, e retorna a string "Isso equivale a {x} km por hora!"
-- velocidade :: ???
velocidade :: Float -> Float -> String
velocidade distancia tempo = "Isso equivale a " ++ show (distancia / tempo) ++ " kilômetros por hora!"

-- Função mult7 n que retorne True caso a entrada seja múltiplo de 7 e False caso contrário.
-- mult7 :: ???
mult7 :: Int -> Bool
mult7 x
    | mod x 7 == 0 = True
    | otherwise = False

-- Função somaEhMult7, que recebe um dois valores inteiros e retorna se a soma é múltipla de 7
-- somaEhMult7 :: ???
somaEhMult7 :: Int -> Int -> Bool
somaEhMult7 a b
    | mult7 (a + b) = True
    | otherwise = False

-- Faça uma função estaNoIntervalo a b c que recebe três inteiros e decida se a está contido no intervalo fechado entre o b e c. Assuma que b < c sempre.
-- estaNoIntervalo :: ???
estaNoIntervalo :: Int -> Int -> Int -> Bool
estaNoIntervalo a b c
    | a >= b && a <= c = True
    | otherwise = False

-- Faça uma função todosNoIntervalo :: [Int] -> Int -> Int -> Bool que determina se todos os números da primeira lista estão no intervalo descrito pelo segundo e terceiro argumento.
-- todosNoIntervalo :: ???
todosNoIntervalo :: [Int] -> Int -> Int -> Bool
todosNoIntervalo as b c
    | all (\x -> x >= b && x <= c) as = True
    | otherwise = False

-- Similarmente, faça uma função algumNoIntervalo :: [Int] -> Int -> Int -> Bool que determina se pelo menos um dos números da primeira lista está no intervalo descrito pelo segundo e terceiro argumento.
-- algumNoIntervalo :: ???
algumNoIntervalo :: [Int] -> Int -> Int -> Bool
algumNoIntervalo as b c
    | any (\x -> x >= b && x <= c) as = True
    | otherwise = False

-- Faça uma função ehPerfeito n que determine se um número é perfeito.
-- ehPerfeito :: ???
ehPerfeito :: Int -> Bool
ehPerfeito n
    | sum [x | x <- [1..n-1], mod n x == 0] == n = True
    | otherwise = False

-- Faça uma função procuraSeis que retorne todos os os números entre 0 e 999 cuja soma dos dígitos é 6.
-- somaDigitosSeis :: ???
somaDigitosSeis :: Int -> Bool
somaDigitosSeis x
    | sum (stringToIntegers (show x)) == 6 = True
    | otherwise = False
        where
            stringToIntegers :: String -> [Int]
            stringToIntegers s = [read [x] :: Int | x <- s]

-- procuraSeis :: ???
procuraSeis :: [Int]
procuraSeis = [x | x <- [0..999], somaDigitosSeis x]

comprimentoAoQuadrado :: [String] -> [Int]
comprimentoAoQuadrado = map (\x -> length x ^ 2)

findLast :: (a -> Bool) -> [a] -> a
findLast f xs = last (filter f xs)

gerarUsuarios :: Int -> String -> [String]
gerarUsuarios n prefixo = [prefixo ++ show x | x <- [1..n]]

descontoDaSorte :: [Int] -> [Int]
descontoDaSorte xs = [x - 10 | x <- xs, mod (x - 10) 7 /= 0]

limparUsernames :: [String] -> [String]
limparUsernames xs = [filter isAlphaNum x | x <- xs]

maisDaMetade :: (a -> Bool) -> [a] -> Bool
maisDaMetade f xs
    | sum y > div (length xs) 2 = True
    | otherwise = False
        where
            y = [1 | x <- xs, f x]

filterDesastrado :: (a -> Bool) -> [a] -> [a]
filterDesastrado f xs = _filterDesastrado [] f xs
    where
        _filterDesastrado :: [a] -> (a -> Bool) -> [a] -> [a]
        _filterDesastrado acc _ [] = acc
        _filterDesastrado acc f (x:xs)
            | f x = _filterDesastrado (acc ++ [x]) f xs
            | otherwise = _filterDesastrado (safeInit acc) f xs
                where
                    safeInit :: [a] -> [a]
                    safeInit [] = []
                    safeInit xs = init xs

palavraMaisLonga :: [String] -> String
palavraMaisLonga ps = head [x | (x, y) <- palavrasEcomprimentos, y == maxLength]
    where
        compareLength :: (String, Int) -> (String, Int) -> Ordering
        compareLength (_, a) (_, b) = compare a b
        comprimentos :: [Int]
        comprimentos = map length ps
        palavrasEcomprimentos :: [(String, Int)]
        palavrasEcomprimentos = zip ps comprimentos
        maxLength :: Int
        maxLength = maximum comprimentos

jogadorBlackJack :: [Int] -> Bool
jogadorBlackJack xs = f xs 0
    where
        f :: [Int] -> Int -> Bool
        f [] n
            | n <= 21 = True
            | otherwise = False
        f (x:xs) n
            | n >= 18 && n <= 21 = True
            | n >= 21 = False
            | n < 18 = f xs (n + x)
