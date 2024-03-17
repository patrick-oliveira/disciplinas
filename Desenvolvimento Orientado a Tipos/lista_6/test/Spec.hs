{-# LANGUAGE DataKinds #-}

module Main (main) where

import Atividade06

import Test.Tasty
import Test.Tasty.HUnit


main :: IO ()
main = do
  defaultMain tests

tests :: TestTree
tests = testGroup "Testes da Atividade 5" [sList, sMatriz, biTree]


sList :: TestTree
sList = testGroup "Sized List "
  [testGroup "Construção"
    [ testCase "[] - Manual" $
        sToList SEmpty @?= ([] :: [Int])
    , testCase "[1] - Manual" $
        sToList (SCons 1 SEmpty) @?= [1 :: Int]
    , testCase "[3, 4] - Manual" $
        sToList (SCons 3 $ SCons 4 SEmpty) @?= [3, 4 :: Int]
    , testCase "[]" $
        exsToList (sl []) @?= ([] :: [Int])
    , testCase "[1]" $
        exsToList (sl [1]) @?= [1 :: Int]
    , testCase "\"AB\"" $
        exsToList (sl "AB") @?= "AB"
    , testCase "[1..3]" $
        exsToList (sl [1..3]) @?= [1..3::Int]
    , testCase "Olá!" $
        exsToList (sl "Olá!") @?= "Olá!"
    , testCase "Hello" $
        exsToList (sl "Hello") @?= "Hello"
    ]
  , testGroup "Tamanho"
    [ testCase "[] - Manual" $
        sLength SEmpty @?= 0
    , testCase "[1] - Manual" $
        sLength (SCons (1 :: Int) SEmpty) @?= (1 :: Int)
    , testCase "[3, 4] - Manual" $
        sLength (SCons 3 $ SCons (4 :: Int) SEmpty) @?= (2 :: Int)
    , testCase "[]" $
        exsLength (sl []) @?= (0 :: Int)
    , testCase "[1]" $
        exsLength (sl [1:: Int]) @?= (1 :: Int)
    , testCase "\"AB\"" $
        exsLength (sl "AB") @?= 2
    , testCase "[1..3]" $
        exsLength (sl [1..3 :: Int]) @?= 3
    , testCase "Olá!" $
        exsLength (sl "Olá!") @?= 4
    , testCase "Hello" $
        exsLength (sl "Hello") @?= 5
    ]
  ]

sMatriz :: TestTree
sMatriz = testGroup "MatrizSimetrica"
  [testGroup "Construção"
     [ testCase "[[]] - Manual" $
         mToList MEmpty @?= ([] :: [[Int]])
     , testCase "[[1]] - Manual" $
         mToList (MCol (SCons 1 SEmpty) MEmpty) @?= [[1 :: Int]]
     , testCase "[[1, 2], [3]] - Manual" $
         mToList (MCol  (SCons 1 $ SCons 2 SEmpty) $ MCol (SCons 3 SEmpty) MEmpty) @?= [[1, 2], [3 :: Int]]
     , testCase "[]" $
         fmap exmToList (ms [[]]) @?= (Nothing :: Maybe [[Int]])
     , testCase "[[1]]" $
         fmap exmToList (ms [[1]]) @?= Just [[1 :: Int]]
     , testCase "[\"AB\",\"C\"]" $
         fmap exmToList (ms ["AB", "C"]) @?= Just ["AB", "C"]
     , testCase "[\"ABC\", \"DE\", \"F\"]" $
         fmap exmToList (ms ["ABC", "DE", "F"]) @?= Just ["ABC", "DE", "F"]
     , testCase "[\"ABCD\", \"EFG\", \"HI\", \"J\"]" $
         fmap exmToList (ms ["ABCD", "EFG", "HI", "J"]) @?= Just ["ABCD", "EFG", "HI", "J"]
     , testCase "[\"KLMNO\", \"ABCD\", \"EFG\", \"HI\", \"J\"]" $
         fmap exmToList (ms ["KLMNO", "ABCD", "EFG", "HI", "J"]) @?= Just ["KLMNO", "ABCD", "EFG", "HI", "J"]
     ]
   , testGroup "Tamanho"
     [ testCase "[]" $
         fmap exmDim (ms []) @?= Just 0
     , testCase "[[]]" $
         fmap exmDim (ms [[]]) @?= Nothing
     , testCase "[[1]]" $
         fmap exmDim (ms [[1::Int]]) @?= Just 1
     , testCase "[\"AB\",\"C\"]" $
         fmap exmDim (ms ["AB", "C"]) @?= Just 2
     , testCase "[\"ABC\", \"DE\", \"F\"]" $
         fmap exmDim (ms ["ABC", "DE", "F"]) @?= Just 3
     , testCase "[\"ABCD\", \"EFG\", \"HI\", \"J\"]" $
         fmap exmDim (ms ["ABCD", "EFG", "HI", "J"]) @?= Just 4
     , testCase "[\"KLMNO\", \"ABCD\", \"EFG\", \"HI\", \"J\"]" $
         fmap exmDim (ms ["KLMNO", "ABCD", "EFG", "HI", "J"]) @?= Just 5
     ]
  ]

biTreeSingle :: Ord a => a -> BiTree 0 a
biTreeSingle = BiTree0

biTree :: TestTree
biTree = testGroup "Binomial Tree"
  [testGroup "Construção"
    [ testCase "Singleton" $
        show (biTreeSingle "oba") @?= "BiTree0 \"oba\""
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
         getRank (biTreeSingle "oba") @?= 0
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
         getRoot (biTreeSingle "oba") @?= "oba"
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
  , testGroup "getSubTrees"
    [ testCase "Dois" $
        show (getSubTrees (BiTree (biTreeSingle (1 :: Int)) (biTreeSingle 2))) @?= "Just (BiTree0 1,BiTree0 2)"
    , testCase "2 com link" $
        show (getSubTrees (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2))) @?= "Just (BiTree0 1,BiTree0 2)"
    , testCase "2 com link invertido " $
        show (getSubTrees (linkTree (biTreeSingle (2 :: Int)) (biTreeSingle 1))) @?= "Just (BiTree0 1,BiTree0 2)"
    , testCase "4 com link" $
        show (getSubTrees
          (linkTree
            (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2))
            (linkTree (biTreeSingle (3 :: Int)) (biTreeSingle 4)))) @?= "Just (BiTree (BiTree0 1) (BiTree0 2),BiTree (BiTree0 3) (BiTree0 4))"
    , testCase "8" $
        show (getSubTrees
          (linkTree
            (linkTree
              (linkTree (biTreeSingle (3 :: Int)) (biTreeSingle 8))
              (linkTree (biTreeSingle (5 :: Int)) (biTreeSingle 4)))
            (linkTree
              (linkTree (biTreeSingle (7 :: Int)) (biTreeSingle 0))
              (linkTree (biTreeSingle (1 :: Int)) (biTreeSingle 2))))) @?= "Just (BiTree (BiTree (BiTree0 1) (BiTree0 2)) (BiTree (BiTree0 0) (BiTree0 7)),BiTree (BiTree (BiTree0 4) (BiTree0 5)) (BiTree (BiTree0 3) (BiTree0 8)))"
    ]
  ]
