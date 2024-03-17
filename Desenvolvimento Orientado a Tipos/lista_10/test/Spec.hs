module Main (main) where

import Test.Tasty

main :: IO ()
main = do
  defaultMain tests

tests :: TestTree
tests = testGroup "Testes da Atividade 10" []
