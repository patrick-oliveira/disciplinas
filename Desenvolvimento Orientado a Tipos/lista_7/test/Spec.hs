{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main (main) where

import Atividade07 (validate)

import Test.Tasty
import Test.Tasty.HUnit


main :: IO ()
main = do
  defaultMain tests

tests :: TestTree
tests = testGroup "Testes da Atividade 7" [parentaiada]

aeq :: Bool -> Bool -> Assertion
aeq actual ex = assertEqual "" ex actual

tStr :: (String, Bool) -> TestTree
tStr (str, ex) = testCase str $  aeq (validate str) ex

t, f :: Bool
t = True
f = False

parentaiada :: TestTree
parentaiada = testGroup "Parentaiada"
      [testGroup "Simples" $
         map tStr [
            ("()"   , t)
          , ("("    , f)
          , (")"    , f)
          , (")("   , f)
          , ("(()"  , f)
          , ("(()))", f)
          , ("{}"   , t)
          , ("{"    , f)
          , ("}"    , f)
          , ("}{"   , f)
          , ("{{}"  , f)
          , ("{{}}}", f)
        ]
    , testGroup "Outros" $
         map tStr [
            ("(a)"   , f)
          , ("{("    , f)
          , ("{)"    , f)
          , (")("    , f)
          , ("(()"   , f)
          , ("(()))" , f)
         ]
    , testGroup "Outros" $
         map tStr [
            ("({(){}})"   , t)
          , ("({({}})"    , f)
          , ("({({}[])"   , f)
          , ("({({}[])})" , t)
          ]
    ]
