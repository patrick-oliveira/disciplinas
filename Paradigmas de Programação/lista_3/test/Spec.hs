module Main where

import Atividade03

import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = do
  defaultMain tests
  
tests :: TestTree
tests = (testGroup "Testes da Atividade 3" [integersDePrimosTest, bissextos32Test, popTest, rangeTest, palindromeTest, maximoTest, minimoTest, mediaTest, xouTest, ehQuadradoPerfeitoTest, ehSaudavelTest, penultimoTest, isHeadTest, isSecondTest, isAtTest, mediaListaTest, isFirstEqualThirdTest, quadradoMaisProximoTest, ethiopianMultiplicationTest, isEvenTest, isOddTest, naturaisTest, ppTest, natdescTest])

integersDePrimosTest = testGroup "integersDePrimos" 
            [testCase "test1" (assertEqual "Test 1" [113, 2] (integersDePrimos [12,113,2] )),
             testCase "test2" (assertEqual "Test 2" [] (integersDePrimos [1] )),
             testCase "test3" (assertEqual "Test 3" [2, 13, 17, 8191] (integersDePrimos [2,13,17,8191] )),
             testCase "test4" (assertEqual "Test 4" [2, 13, 2, 8191] (integersDePrimos [2,13,2,8191] )),
             testCase "test5" (assertEqual "Test 5" [] (integersDePrimos [] ))
             ]
             
bissextos32Test = testGroup "bissextos32" [testCase "test1" (assertEqual "Test 1" ["2016","1984","1952","1920","1888","1856","1824","1792","1760","1728","1696","1664","1632","1600"] (bissextos32))]


          
palindromeTest = testGroup "palindrome"
            [testCase "test1" (assertEqual "Test 1" False (palindrome "Ann")),
            testCase "test2" (assertEqual "Test 2" True (palindrome "Ana"))
            ]


popTest = testGroup "pop"
            [testCase "test1" (assertEqual "Test 1" [0,1,3] (pop [0,1,2,3] 2)),
            testCase "test2" (assertEqual "Test 2" [90,40] (pop [1,90,40] 0))
            ]


rangeTest = testGroup "range"
            [testCase "test1" (assertEqual "Test 1" [0] (range [0,1,2,3] 0 1)),
            testCase "test2" (assertEqual "Test 2" [90,40] (range [1,90,40, 90, 91] 1 3))
            ]


naturaisTest = testGroup "naturais"
          [
            testCase "test1" (assertEqual "Test 1" [0,1,2] (naturais 3) ),
            testCase "test1" (assertEqual "Test 2" [0] (naturais 1) )
          ]


ppTest = testGroup "pares positivos"
          [
            testCase "test1" (assertEqual "Test 1" [2, 4, 6] (pp 3) ),
            testCase "test2" (assertEqual "Test 2" [2] (pp 1) )
          ]

natdescTest = testGroup "naturais decrescente"
          [
            testCase "test1" (assertEqual "Test 1" [2,1, 0] (natdesc 3) ),
            testCase "test2" (assertEqual "Test 2" [0] (natdesc 1) )
          ]


isHeadTest = testGroup "isHead"
          [
            testCase "test 1" (assertEqual "Test 1" False (isHead 2 [0])),
            testCase "test 2" (assertEqual "Test 2" True (isHead 0 [0]) )      
          ]


isSecondTest = testGroup "isSecond"
          [
            testCase "test 1" (assertEqual "Test 1" False (isSecond 2 [0, 1]) ),
            testCase "test 2" (assertEqual "Test 2" True (isSecond 0 [1, 0]) )       
          ]


isAtTest = testGroup "isAt"
          [
            testCase "test 1" (assertEqual "Test 1" False (isAt 0 2 [0, 1])),
            testCase "test 2" (assertEqual "Test 2" True (isAt 1 0 [1, 0])  )      
          ]


mediaListaTest = testGroup "mediaLista"
          [
            testCase "test 1" (assertEqual "Test 1" 0.5 (mediaLista [0, 1])),
            testCase "test 2" (assertEqual "Test 2" 1 (mediaLista [1, 1])   )     
          ]

isFirstEqualThirdTest = testGroup "isFirstEqualThird"
          [
            testCase "test 1" (assertEqual "Test 1" False (isFirstEqualThird [0, 0, 1])),
            testCase "test 2" (assertEqual "Test 2" True (isFirstEqualThird  [1, 1, 1]) )       
          ]


ethiopianMultiplicationTest = testGroup "ethiopianMultiplication"
          [
            testCase "test 1" (assertEqual "Test 1" 9 (ethiopianMultiplication 3 3)),
            testCase "test 2" (assertEqual "Test 2" 0 (ethiopianMultiplication  0 3)  )      
          ]


isEvenTest = testGroup "isEven"
          [
            testCase "test 1" (assertEqual "Test 1" False (isEven 3)),
            testCase "test 2" (assertEqual "Test 2" True (isEven  2) )       
          ]

isOddTest = testGroup "isOdd"
          [
            testCase "test 1" (assertEqual "Test 1" True (isOdd 3)),
            testCase "test 2" (assertEqual "Test 2" False (isOdd  2) )       
          ]


maximoTest = testGroup "maximo"
          [
            testCase "test 1" (assertEqual "Test 1" 3 (maximo 3 2)),
            testCase "test 2" (assertEqual "Test 2" 3 (maximo  0 3) )       
          ]

minimoTest = testGroup "minimo"
          [
            testCase "test 1" (assertEqual "Test 1" 2 (minimo 3 2)),
            testCase "test 2" (assertEqual "Test 2" 0 (minimo 0 3)     )   
          ]


mediaTest = testGroup "media"
          [
            testCase "test 1" (assertEqual "Test 1" 2.5 (media 3 2)),
            testCase "test 2" (assertEqual "Test 2" 1 (media  2 0)  )      
          ]


xouTest = testGroup "xou"
          [
            testCase "test 1" (assertEqual "Test 1" True (xou False True)),
            testCase "test 2" (assertEqual "Test 2" False (xou False False) )       
          ]

ehQuadradoPerfeitoTest = testGroup "ehQuadradoPerfeito"
          [
            testCase "test 1" (assertEqual "Test 1" True (ehQuadradoPerfeito 1)),
            testCase "test 2" (assertEqual "Test 2" False (ehQuadradoPerfeito 2) )       
          ]

ehSaudavelTest = testGroup "ehSaudavel"
          [
            testCase "test 1" (assertEqual "Test 1" False (ehSaudavel 30 True False)),
            testCase "test 2" (assertEqual "Test 2" False (ehSaudavel 29 True False)),
            testCase "test 3" (assertEqual "Test 3" True (ehSaudavel 29 False True)  )      
          ]


penultimoTest = testGroup "penultimo"
          [
            testCase "test 1" (assertEqual "Test 1" 0 (penultimo [0,1])),
            testCase "test 2" (assertEqual "Test 2" 4 (penultimo [1,2,3,4,5])  )      
          ]

quadradoMaisProximoTest = testGroup "quadradoMaisProximo"
          [
            testCase "test 1" (assertEqual "Test 1" 1 (quadradoMaisProximo 1)),
            testCase "test 2" (assertEqual "Test 2" 4 (quadradoMaisProximo 2) )       
          ]
