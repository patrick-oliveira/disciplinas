{-# LANGUAGE TypeApplications #-}

module Main where

import Atividade02 hiding (main)

import Prelude hiding (Real)

import Data.Proxy

import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = do
  input <- lines <$> readFile "test/input.txt"
  defaultMain $ tests input

tests :: [String] -> TestTree
tests input = testGroup "Testes da Atividade 2" [loneTest input]

loneTest :: [String] -> TestTree
loneTest input = testGroup "sumarioConta"
                 [
                   testCase "Test 1" (
                     assertEqual "Test 1"
                       "(R$ 21564.89,US$ 934.72,£ 5145.99)\nTotal: US$ 11726.91\n"
                       (sumarioConta (processaLinhas
                                       (mkContaBancaria (Proxy @Real)  (Proxy @Dolar) (Proxy @Libra))
                                       input)))
                 , testCase "Test 2" (
                     assertEqual "Test 2"
                       "(US$ 934.72,R$ 21564.89,£ 5145.99)\nTotal: US$ 11726.91\n"
                       (sumarioConta (processaLinhas
                                       (mkContaBancaria (Proxy @Dolar)  (Proxy @Real) (Proxy @Libra))
                                       input)))
                 , testCase "Test 3" (
                     assertEqual "Test 3"
                       "(₹ 16450.22,£ 3648.85,€ 5882.65)\nTotal: US$ 11726.91\n"
                       (sumarioConta (processaLinhas
                                       (mkContaBancaria (Proxy @Rupia)  (Proxy @Libra) (Proxy @Euro))
                                       input)))
                 ]
