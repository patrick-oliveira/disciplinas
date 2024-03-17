{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main (main) where

import Atividade09

import Test.Tasty
import qualified Test.Tasty.QuickCheck as Q
import qualified Data.List as L

main :: IO ()
main = do
  defaultMain tests

tests :: TestTree
tests = testGroup "Testes da Atividade 9" [testHeap1]

testHeap1 :: TestTree
testHeap1 =
  localOption (Q.QuickCheckTests   1000) $
  localOption (Q.QuickCheckMaxSize 1000)
  (testGroup "Heaps" [
      Q.testProperty "Length DummyHeap" (\(x :: [Int]) ->
                 length (toList (fromList x :: DummyHeap Int)) == length x)
    , Q.testProperty "Length LeftistHeap" (\(x :: [Int]) ->
                 length (toList (fromList x :: LeftistHeap Int)) == length x)
    , Q.testProperty "Length SafeLeftistHeap" (\(x :: [Int]) ->
                 length (toList (fromList x :: SafeLeftistHeap Int)) == length x)

    , Q.testProperty "Sort DummyHeap" (\(x :: [Int]) ->
                 toList (fromList x :: DummyHeap Int) == reverse (L.sort x))
    , Q.testProperty "Sort LeftistHeap" (\(x :: [Int]) ->
                 toList (fromList x :: LeftistHeap Int) == reverse (L.sort x))
    , Q.testProperty "Sort SafeLeftistHeap" (\(x :: [Int]) ->
                 toList (fromList x :: SafeLeftistHeap Int) == reverse (L.sort x))

    , Q.testProperty "DummyHeap vs LeftistHeap vs SafeLeftistHeap"
      (\(x :: [Int]) ->
                 let 
                     one   = toList (fromList x :: DummyHeap Int)
                     two   = toList (fromList x :: LeftistHeap Int)
                     three = toList (fromList x :: SafeLeftistHeap Int) in
                       one == two &&
                       two == three)
    ])
