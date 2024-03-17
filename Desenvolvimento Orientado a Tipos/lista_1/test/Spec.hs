module Main where

import Atividade01

import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = do
  defaultMain tests


arvore1 = Nó (Nó (Folha "10") "1" (Folha "teste")) "0" (Folha "prefeito")
arvore2 = Nó (Nó (Folha "10") "1" (Folha "67")) "0" (Folha "4")
arvore3 = Nó (Folha "teste") "0" (Folha "")
arvore4 = Nó (Folha "teste") "!" (Folha "")
arvore5 = Nó (Nó (Folha "11") "2" (Folha "teste")) "10" (Nó ((Nó (Folha "20") "13" (Folha "100"))) "18" (Folha "teste"))
folha = Folha "11"


tests :: TestTree
tests = (testGroup "Testes da Atividade 1" [arvorePossuiTest, convertString2MIntTest, frutasDaArvoreTest, evalTest, safeEvalTest, functorEvalTest, cestasTest, showCestaTest, produtosCarosTest, atualizaCatalogoTest, somarCarrinhoTest])



arvorePossuiTest = testGroup "arvorePossui"
            [testCase "Test 1" (assertEqual "Test 1" False (arvorePossui arvore1 "42")),
            testCase "Test 2" (assertEqual "Test 2" True (arvorePossui arvore1 "teste")),
            testCase "Test 3" (assertEqual "Test 3" False (arvorePossui folha "teste"))
            ]


convertString2MIntTest = testGroup "convertString2MInt"
            [testCase "Test 1" (assertEqual "Test 1" (Nó (Nó (Folha (Just 10)) (Just 1) (Folha Nothing)) (Just 0) (Folha Nothing)) (convertString2MInt arvore1)),
             testCase "Test 2" (assertEqual "Test 2" (Nó (Nó (Folha (Just 10)) (Just 1) (Folha (Just 67))) (Just 0) (Folha (Just 4))) (convertString2MInt arvore2))
            ]

frutasDaArvoreTest = testGroup "frutasDaArvore"
            [testCase "Test 1" (assertEqual "Test 1"  (Just 11) (frutasDaArvore arvore1)),
             testCase "Test 2" (assertEqual "Test 2" (Just 0) (frutasDaArvore arvore4))
            ]


evalTest = testGroup "eval"
            [testCase "Test 1" (assertEqual "Test 1" 5 (eval (Soma (Constante 2) (Constante 3)))),
             testCase "Test 2" (assertEqual "Test 2" (-4) (eval (Mul (Sub (Constante 2) (Constante 3)) (Constante 4)))),
             testCase "Test 3" (assertEqual "Test 3" 10 (eval (Soma (Mul (Constante 2) (Constante 3)) (Constante 4))))
            ]

safeEvalTest = testGroup "safeEval"
            [testCase "Test 1" (assertEqual "Test 1" (Just 3) (safeEval (Div (Constante 9) (Constante 3)))),
             testCase "Test 2" (assertEqual "Test 2" Nothing (safeEval (Div (Constante 9) (Constante 0))))
            ]

functorEvalTest = testGroup "functorEval"
            [testCase "Test 1" (assertEqual "Test 1" (Div (Constante 10) (Constante 4)) (fmap ((+)1) (Div (Constante 9) (Constante 3))  )),
             testCase "Test 2" (assertEqual "Test 2" (Div (Constante 9) (Constante 3)) (fmap id (Div (Constante 9) (Constante 3))  ))
            ]

cestasTest = testGroup "Cesta"
            [testCase "test1" (assertEqual "Test 1" (Cesta ["notebook"] 1000) (Cesta ["notebook"] 1000 <> Cesta [] 0)),
            testCase "test2" (assertEqual "Test 2" (Cesta ["notebook","Abacaxi"] 1150.0) (Cesta ["notebook"] 1000 <> Cesta ["Abacaxi"] 150))
            ]


showCestaTest = testGroup "show"
            [testCase "test1" (assertEqual "Test 1" "Alface,Ovo,Repolho" (show (Cesta ["Alface","Ovo","Repolho"] 15.1))),
            testCase "test2" (assertEqual "Test 2" "" (show (Cesta [] 15.1))),
            testCase "test3" (assertEqual "Test 3" "Foo" (show (Cesta ["Foo"] 15.1)))
            ]

produtosCarosTest = testGroup "produtosCaros"
            [testCase "test1" (assertEqual "Test 1" (Cesta ["Alface","Ovo"] 13.1) (produtosCaros [ (Cesta ["Alface"] 2.1), (Cesta ["Ovo"] 11), (Cesta ["Repolho"] (-2.1)) ] 2)),
            testCase "test2" (assertEqual "Test 2" (Cesta ["Cenoura"] 12.1) (produtosCaros [ (Cesta ["Cenoura"] 12.1), (Cesta ["Carne"] (-88.39)) ] 5.0)),
            testCase "test3" (assertEqual "Test 3" (Cesta [] 0.0) (produtosCaros [ (Cesta ["Cenoura"] 12.1), (Cesta ["Carne"] 88.39) ] 100.0))
            ]


atualizaCatalogoTest = testGroup "atualizaCatalogo"
            [testCase "test1" (assertEqual "Test 1" [(Cesta ["Alface"] 2.1), (Cesta ["Ovo"] 11), (Cesta ["Repolho"] 2.1)] (atualizaCatalogo [ (Cesta ["Alface"] 2.1), (Cesta ["Ovo"] 11), (Cesta ["Repolho"] (-2.1)) ] )),
            testCase "test2" (assertEqual "Test 2" [(Cesta ["Cenoura"] 12.1), (Cesta ["Carne"] 88.39)] (atualizaCatalogo [ (Cesta ["Cenoura"] 12.1), (Cesta ["Carne"] 88.39) ] )),
            testCase "test3" (assertEqual "Test 3" [(Cesta ["Cenoura"] 0)] (atualizaCatalogo [ (Cesta ["Cenoura"] 0) ] ))
            ]

somarCarrinhoTest = testGroup "somarCarrinho"
            [testCase "test1" (assertEqual "Test 1" 11 (somarCarrinho [ (Cesta ["Alface"] 2), (Cesta ["Ovo"] 11), (Cesta ["Repolho"] (-2)) ] )),
            testCase "test2" (assertEqual "Test 2" (-6) (somarCarrinho [ (Cesta ["Cenoura"] 4), (Cesta ["Carne"] (-10)) ] )),
            testCase "test3" (assertEqual "Test 3" 105.49 (somarCarrinho [ (Cesta ["Cenoura"] 12.1), (Cesta ["Vinagre"] 5), (Cesta ["Leite"] 0), (Cesta ["Carne"] 88.39) ] ))
            ]
