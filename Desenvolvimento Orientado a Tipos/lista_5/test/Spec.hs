{-# LANGUAGE DataKinds #-}
{-# OPTIONS_GHC -Wno-unticked-promoted-constructors #-}
{-# LANGUAGE TypeApplications #-}

module Main (main) where

import Atividade05

import Test.Tasty
import Test.Tasty.HUnit


main :: IO ()
main = do
  defaultMain tests

tests :: TestTree
tests = testGroup "Testes da Atividade 5" [nats, sList, sMatriz, biTree]

nats :: TestTree
nats = testGroup "Naturais de Peano"
  [
    testCase "0" $
      natToInt @Zero @?= 0
  , testCase "1 - Manual" $
      natToInt @(Suc Zero) @?= 1
  , testCase "2 - Manual" $
      natToInt @(Suc (Suc Zero)) @?= 2
  , testCase "N0" $
      natToInt @N0 @?= 0
  , testCase "N1" $
      natToInt @N1 @?= 1
  , testCase "N2" $
      natToInt @N2 @?= 2
  , testCase "N3" $
      natToInt @N3 @?= 3
  , testCase "N4" $
      natToInt @N4 @?= 4
  , testCase "N5" $
      natToInt @N5 @?= 5
  ]

sList :: TestTree
sList = testGroup "Sized List "
  [testGroup "Construção"
    [ testCase "[] - Manual" $
        sToList SEmpty @=? ([] :: [Int])
    , testCase "[1] - Manual" $
        sToList (SCons 1 SEmpty) @=? [1 :: Int]
    , testCase "[3, 4] - Manual" $
        sToList (SCons 3 $ SCons 4 SEmpty) @=? [3, 4 :: Int]
    , testCase "[]" $
        sToList (sl0 []) @=? ([] :: [Int])
    , testCase "[1]" $
        sToList (sl1 [1]) @=? [1 :: Int]
    , testCase "\"AB\"" $
        sToList (sl2 "AB") @=? "AB"
    , testCase "[1..3]" $
        sToList (sl3 [1..3]) @=? [1..3::Int]
    , testCase "Olá!" $
        sToList (sl4 "Olá!") @=? "Olá!"
    , testCase "Hello" $
        sToList (sl5 "Hello") @=? "Hello"
    ]
  , testGroup "Tamanho"
    [ testCase "[] - Manual" $
        sLength SEmpty @=? 0
    , testCase "[1] - Manual" $
        sLength (SCons (1 :: Int) SEmpty) @=? (1 :: Int)
    , testCase "[3, 4] - Manual" $
        sLength (SCons 3 $ SCons (4 :: Int) SEmpty) @=? (2 :: Int)
    , testCase "[]" $
        sLength (sl0 []) @=? (0 :: Int)
    , testCase "[1]" $
        sLength (sl1 [1:: Int]) @=? (1 :: Int)
    , testCase "\"AB\"" $
        sLength (sl2 "AB") @=? 2
    , testCase "[1..3]" $
        sLength (sl3 [1..3 :: Int]) @=? 3
    , testCase "Olá!" $
        sLength (sl4 "Olá!") @=? 4
    , testCase "Hello" $
        sLength (sl5 "Hello") @=? 5
    ]
  ]

sMatriz :: TestTree
sMatriz = testGroup "MatrizSimetrica"
  [testGroup "Construção"
     [ testCase "[[]] - Manual" $
         mToList MEmpty @=? ([] :: [[Int]])
     , testCase "[[1]] - Manual" $
         mToList (MCol (sl1 [1 :: Int]) MEmpty) @=? [[1 :: Int]]
     , testCase "[[1, 2], [3]] - Manual" $
         mToList (MCol (sl2 [1, 2 :: Int]) $ MCol (sl1 [3]) MEmpty) @=? [[1, 2], [3 :: Int]]
     , testCase "[]" $
         mToList (ms0 [[]]) @=? ([] :: [[Int]])
     , testCase "[[1]]" $
         mToList (ms1 [[1]]) @=? [[1 :: Int]]
     , testCase "[\"AB\",\"C\"]" $
         mToList (ms2 ["AB", "C"]) @=? ["AB", "C"]
     , testCase "[\"ABC\", \"DE\", \"F\"]" $
         mToList (ms3 ["ABC", "DE", "F"]) @=? ["ABC", "DE", "F"]
     , testCase "[\"ABCD\", \"EFG\", \"HI\", \"J\"]" $
         mToList (ms4 ["ABCD", "EFG", "HI", "J"]) @=? ["ABCD", "EFG", "HI", "J"]
     , testCase "[\"KLMNO\", \"ABCD\", \"EFG\", \"HI\", \"J\"]" $
         mToList (ms5 ["KLMNO", "ABCD", "EFG", "HI", "J"]) @=? ["KLMNO", "ABCD", "EFG", "HI", "J"]
     ]
   , testGroup "Tamanho"
     [ testCase "[]" $
         mDim (ms0 [[]]) @=? 0
     , testCase "[[1]]" $
         mDim (ms1 [[1::Int]]) @=? 1
     , testCase "[\"AB\",\"C\"]" $
         mDim (ms2 ["AB", "C"]) @=? 2
     , testCase "[\"ABC\", \"DE\", \"F\"]" $
         mDim (ms3 ["ABC", "DE", "F"]) @=? 3
     , testCase "[\"ABCD\", \"EFG\", \"HI\", \"J\"]" $
         mDim (ms4 ["ABCD", "EFG", "HI", "J"]) @=? 4
     , testCase "[\"KLMNO\", \"ABCD\", \"EFG\", \"HI\", \"J\"]" $
         mDim (ms5 ["KLMNO", "ABCD", "EFG", "HI", "J"]) @=? 5
     ]
  ]

biTreeSingle :: a -> BiTree Zero a
biTreeSingle = BiTree0

biTree :: TestTree
biTree = testGroup "Binomial Tree"
  [testGroup "Construção"
    [ testCase "Singleton" $
        show (biTreeSingle "oba") @=? "BiTree0 \"oba\""
    , testCase "Dois" $
        show (BiTree (biTreeSingle (1 :: Int)) (biTreeSingle 2)) @?= "BiTree (BiTree0 1) (BiTree0 2)"
    , testCase "2 com link" $
        show (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2)) @?= "BiTree (BiTree0 1) (BiTree0 2)"
    , testCase "2 com link invertido " $
        show (linkTree (biTreeSingle (2 :: Int)) (biTreeSingle 1)) @?= "BiTree (BiTree0 1) (BiTree0 2)"
    , testCase "4 com link" $
        show
          (linkTree
            (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2))
            (linkTree (biTreeSingle (3 :: Int)) (biTreeSingle 4))) @?=
          "BiTree (BiTree (BiTree0 1) (BiTree0 2)) (BiTree (BiTree0 3) (BiTree0 4))"
    , testCase "8" $
        show
          (linkTree
            (linkTree
              (linkTree (biTreeSingle (3 :: Int)) (biTreeSingle 8))
              (linkTree (biTreeSingle (5 :: Int)) (biTreeSingle 4)))
            (linkTree
              (linkTree (biTreeSingle (7 :: Int)) (biTreeSingle 0))
              (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2)))) @?=
          "BiTree (BiTree (BiTree (BiTree0 1) (BiTree0 2)) (BiTree (BiTree0 0) (BiTree0 7))) (BiTree (BiTree (BiTree0 4) (BiTree0 5)) (BiTree (BiTree0 3) (BiTree0 8)))"
    ]
  , testGroup "Ranks"
     [ testCase "0" $
         getRank (biTreeSingle "oba") @=? 0
     , testCase "1" $
         getRank (BiTree (biTreeSingle (1 :: Int)) (biTreeSingle 2)) @?= 1
     , testCase "1 com link" $
         getRank (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2)) @?= 1
     , testCase "1 com link invertido " $
         getRank (linkTree (biTreeSingle (2 :: Int)) (biTreeSingle 1)) @?= 1
     , testCase "2 com link" $
         getRank
           (linkTree
             (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2))
             (linkTree (biTreeSingle (3 :: Int)) (biTreeSingle 4))) @?= 2

     , testCase "3" $
        getRank
          (linkTree
            (linkTree
              (linkTree (biTreeSingle (3 :: Int)) (biTreeSingle 8))
              (linkTree (biTreeSingle (5 :: Int)) (biTreeSingle 4)))
            (linkTree
              (linkTree (biTreeSingle (7 :: Int)) (biTreeSingle 0))
              (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2)))) @?= 3
    ]
  , testGroup "Root"
     [ testCase "Singleton" $
         getRoot (biTreeSingle "oba") @=? "oba"
     , testCase "Dois" $
         getRoot (BiTree (biTreeSingle (1 :: Int)) (biTreeSingle 2)) @?= 2
     , testCase "2 com link" $
         getRoot (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2)) @?= 2
     , testCase "2 com link invertido " $
         getRoot (linkTree (biTreeSingle (2 :: Int)) (biTreeSingle 1)) @?= 2
     , testCase "4 com link" $
         getRoot
           (linkTree
             (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2))
             (linkTree (biTreeSingle (3 :: Int)) (biTreeSingle 4))) @?= 4
     , testCase "4 com link invertido" $
         getRoot
           (linkTree
             (linkTree (biTreeSingle (3 :: Int)) (biTreeSingle 4))
             (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2))) @?= 4
     , testCase "4 com - zona" $
         getRoot
           (linkTree
             (linkTree (biTreeSingle (4 :: Int)) (biTreeSingle 1))
             (linkTree (biTreeSingle (3 :: Int)) (biTreeSingle 2))) @?= 4
     , testCase "8" $
         getRoot
           (linkTree
             (linkTree
               (linkTree (biTreeSingle (3 :: Int)) (biTreeSingle 8))
               (linkTree (biTreeSingle (5 :: Int)) (biTreeSingle 4)))
             (linkTree
               (linkTree (biTreeSingle (7 :: Int)) (biTreeSingle 0))
               (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2)))) @?= 8
    ]
  ]
