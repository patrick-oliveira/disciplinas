module Atividade03
    ( integersDePrimos,
    bissextos32,
    pop,
    range,
    palindrome,
    maximo,
    minimo,
    media,
    xou,
    ehQuadradoPerfeito,
    ehSaudavel,
    penultimo,
    isHead,
    isSecond,
    isAt,
    mediaLista,
    isFirstEqualThird,
    quadradoMaisProximo,
    ethiopianMultiplication,
    isEven,
    isOdd,
    naturais,
    pp,
    natdesc
    ) where


integersdePrimos :: [Int] -> [Int]
integersdePrimos xs = [x | x <- xs, ehPrimo x]
    where
        ehPrimo :: Int -> Bool
        ehPrimo n
            | n == 1 = False
            | n == 2 = True
            | or [mod n x == 0 | x <- [2..n-1]] = False
            | otherwise = True

bissextos32 :: [String]
bissextos32 = [show x | x <- bissextos, mod x 32 == 0]
    where
        bissextos = [x | x <- [1584..2020], mod x 400 == 0 || (mod x 4 == 0 && mod x 100 /= 0)]
    
pop :: [a] -> Integer -> [a]
pop xs n = _pop xs (fromIntegral n) [] 0
    where
        _pop :: [a] -> Int -> [a] -> Int -> [a]
        _pop [] _ ys _ = ys
        _pop (x:xs) n ys i
            | i == n = ys ++ xs
            | otherwise = _pop xs n (ys ++ [x]) (i+1)

range :: [a] -> Int -> Int -> [Int]
range xs i j
    | i > j = []
    | otherwise = take j $ drop i xs

palindrome :: String -> Bool
palindrome s = undefined

