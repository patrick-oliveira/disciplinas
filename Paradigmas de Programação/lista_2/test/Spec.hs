import           Exercicios
import           Test.Tasty
import           Test.Tasty.HUnit
import           Data.Char        (isUpper)

main :: IO ()
main = do
  defaultMain tests

tests :: TestTree
tests =
  (testGroup
     "Atividade 2"
     [ test01
     , test02
     , test03
     , test04
     , test05
     , test06
     , test07
     , test08
     , test09
     , test10
     , test11
     , test12
     , test13
     , test14
     , test15
     , test16
     , test17
     , test18
     , test19
     ])

test01 =
  testGroup
    "multiplicar"
    [ testCase "6 * 7" (assertEqual "" 42 (multiplicar 6 7))
    , testCase "3 * 4" (assertEqual "" 12 (multiplicar 3 4))
    , testCase "11 * 6" (assertEqual "" 66 (multiplicar 11 6))
    , testCase "15 * 7" (assertEqual "" 105 (multiplicar 15 7))
    ]

test02 =
  testGroup
    "cumprimentar"
    [ testCase
        "João"
        (assertEqual
           ""
           "A linguagem preferida de João é Haskell"
           (cumprimentar "João"))
    , testCase
        "Maria"
        (assertEqual
           ""
           "A linguagem preferida de Maria é Haskell"
           (cumprimentar "Maria"))
    , testCase
        "José"
        (assertEqual
           ""
           "A linguagem preferida de José é Haskell"
           (cumprimentar "José"))
    , testCase
        "todos"
        (assertEqual
           ""
           "A linguagem preferida de todos é Haskell"
           (cumprimentar "todos"))
    ]

test03 =
  testGroup
    "velocidade"
    [ testCase
        "50km/1h"
        (assertEqual
           ""
           "Isso equivale a 50.0 kilômetros por hora!"
           (velocidade 50 1))
    , testCase
        "50km/2h"
        (assertEqual
           ""
           "Isso equivale a 25.0 kilômetros por hora!"
           (velocidade 50 2))
    , testCase
        "50km/0.5h"
        (assertEqual
           ""
           "Isso equivale a 100.0 kilômetros por hora!"
           (velocidade 50 0.5))
    , testCase
        "123.4km/1.27h"
        (assertEqual
           ""
           "Isso equivale a 97.16536 kilômetros por hora!"
           (velocidade 123.4 1.27))
    ]

test04 =
  testGroup
    "mult7"
    [ testCase "7" (assertEqual "" True (mult7 7))
    , testCase "14" (assertEqual "" True (mult7 14))
    , testCase "18" (assertEqual "" False (mult7 18))
    , testCase "27" (assertEqual "" False (mult7 27))
    ]

test05 =
  testGroup
    "somaEhMult7"
    [ testCase "3 + 4" (assertEqual "" True (somaEhMult7 3 4))
    , testCase "10 + 4" (assertEqual "" True (somaEhMult7 10 4))
    , testCase "15 + 9" (assertEqual "" False (somaEhMult7 15 9))
    , testCase "42 + 12" (assertEqual "" False (somaEhMult7 42 12))
    ]

test06 =
  testGroup
    "estaNoIntervalo"
    [ testCase "5 ∈ [3, 7]" (assertEqual "" True (estaNoIntervalo 5 3 7))
    , testCase "8 ∈ [3, 7]" (assertEqual "" False (estaNoIntervalo 8 3 7))
    , testCase "2 ∈ [3, 7]" (assertEqual "" False (estaNoIntervalo 2 3 7))
    , testCase "7 ∈ [3, 7]" (assertEqual "" True (estaNoIntervalo 7 3 7))
    , testCase "3 ∈ [3, 7]" (assertEqual "" True (estaNoIntervalo 3 3 7))
    ]

test07 =
  testGroup
    "todosNoIntervalo"
    [ testCase "{} ∈ [3, 7]" (assertEqual "" True (todosNoIntervalo [] 3 7))
    , testCase
        "{1,2,3} ∈ [3, 7]"
        (assertEqual "" False (todosNoIntervalo [1, 2, 3] 3 7))
    , testCase
        "{2,3,4} ∈ [3, 7]"
        (assertEqual "" False (todosNoIntervalo [2, 3, 4] 3 7))
    , testCase
        "{3,4,5} ∈ [3, 7]"
        (assertEqual "" True (todosNoIntervalo [3, 4, 5] 3 7))
    , testCase
        "{4,5,6} ∈ [3, 7]"
        (assertEqual "" True (todosNoIntervalo [4, 5, 6] 3 7))
    , testCase
        "{5,6,7} ∈ [3, 7]"
        (assertEqual "" True (todosNoIntervalo [5, 6, 7] 3 7))
    , testCase
        "{6,7,8} ∈ [3, 7]"
        (assertEqual "" False (todosNoIntervalo [6, 7, 8] 3 7))
    ]

test08 =
  testGroup
    "algumNoIntervalo"
    [ testCase "{} ∈ [3, 7]" (assertEqual "" False (algumNoIntervalo [] 3 7))
    , testCase
        "{1,2,3} ∈ [3, 7]"
        (assertEqual "" True (algumNoIntervalo [1, 2, 3] 3 7))
    , testCase
        "{2,3,4} ∈ [3, 7]"
        (assertEqual "" True (algumNoIntervalo [2, 3, 4] 3 7))
    , testCase
        "{3,4,5} ∈ [3, 7]"
        (assertEqual "" True (algumNoIntervalo [3, 4, 5] 3 7))
    , testCase
        "{4,5,6} ∈ [3, 7]"
        (assertEqual "" True (algumNoIntervalo [4, 5, 6] 3 7))
    , testCase
        "{5,6,7} ∈ [3, 7]"
        (assertEqual "" True (algumNoIntervalo [5, 6, 7] 3 7))
    , testCase
        "{6,7,8} ∈ [3, 7]"
        (assertEqual "" True (algumNoIntervalo [6, 7, 8] 3 7))
    , testCase
        "{9,10,11} ∈ [3, 7]"
        (assertEqual "" False (algumNoIntervalo [9, 10, 11] 3 7))
    , testCase
        "{0,1,2} ∈ [3, 7]"
        (assertEqual "" False (algumNoIntervalo [0, 1, 2] 3 7))
    ]

test09 =
  testGroup
    "ehPerfeito"
    [ testCase "6" (assertEqual "" True (ehPerfeito 6))
    , testCase "28" (assertEqual "" True (ehPerfeito 28))
    , testCase "496" (assertEqual "" True (ehPerfeito 496))
    , testCase "42" (assertEqual "" False (ehPerfeito 42))
    , testCase "37" (assertEqual "" False (ehPerfeito 37))
    , testCase "19" (assertEqual "" False (ehPerfeito 19))
    , testCase "22" (assertEqual "" False (ehPerfeito 22))
    ]

test10 =
  testGroup
    "procuraSeis"
    [ testCase "6" (assertBool "" (6 `elem` procuraSeis))
    , testCase "15" (assertBool "" (15 `elem` procuraSeis))
    , testCase "24" (assertBool "" (24 `elem` procuraSeis))
    , testCase "33" (assertBool "" (33 `elem` procuraSeis))
    , testCase "42" (assertBool "" (42 `elem` procuraSeis))
    , testCase "51" (assertBool "" (51 `elem` procuraSeis))
    , testCase "!77" (assertBool "" (not $ 77 `elem` procuraSeis))
    ]

test11 =
  testGroup
    "comprimentoAoQuadrado"
    [ testCase
        "ola mundo"
        (assertEqual "" [9, 25] (comprimentoAoQuadrado ["ola", "mundo"]))
    , testCase
        "ola mundo"
        (assertEqual
           ""
           [9, 25, 64, 81]
           (comprimentoAoQuadrado ["ola", "mundo", "testando", "booleano "]))
    , testCase
        "vazio ola mundo"
        (assertEqual "" [0, 9, 25] (comprimentoAoQuadrado ["", "ola", "mundo"]))
    , testCase "lista vazia" (assertEqual "" [] (comprimentoAoQuadrado []))
    ]

test12 =
  testGroup
    "findLast"
    [ testCase "impar de 1 a 10" (assertEqual "" 9 (findLast odd [1 .. 10]))
    , testCase "par de 1 a 10" (assertEqual "" 10 (findLast even [1 .. 10]))
    , testCase
        "par em uma lista com um unico elemento"
        (assertEqual "" 2 (findLast even [2]))
    , testCase
        "maiusculo de uma string"
        (assertEqual "" 'H' (findLast isUpper "Eu Gosto De Haskell"))
    ]

test13 =
  testGroup
    "gerarUsuarios"
    [ testCase
        "3 pessoa"
        (assertEqual
           ""
           ["pessoa1", "pessoa2", "pessoa3"]
           (gerarUsuarios 3 "pessoa"))
    , testCase
        "5 usuario"
        (assertEqual
           ""
           ["usuario1", "usuario2", "usuario3", "usuario4", "usuario5"]
           (gerarUsuarios 5 "usuario"))
    , testCase
        "sem prefixo"
        (assertEqual "" ["1", "2", "3", "4"] (gerarUsuarios 4 ""))
    , testCase "n=1" (assertEqual "" ["user1"] (gerarUsuarios 1 "user"))
    , testCase "n=0" (assertEqual "" [] (gerarUsuarios 0 "user"))
    ]

test14 =
  testGroup
    "descontoDaSorte "
    [ testCase
        "17 22 45 31"
        (assertEqual "" [12, 25] (descontoDaSorte [17, 22, 35, 31]))
    , testCase
        "14 21 35"
        (assertEqual "" [4, 11, 25] (descontoDaSorte [14, 21, 35]))
    , testCase "24 31 45" (assertEqual "" [] (descontoDaSorte [24, 31, 45]))
    , testCase "lista vazia" (assertEqual "" [] (descontoDaSorte []))
    ]

test15 =
  testGroup
    "limparUsernames "
    [ testCase
        "joao_123, Maria.456"
        (assertEqual
           ""
           ["joao123", "Maria456"]
           (limparUsernames ["joao_123", "Maria.456"]))
    , testCase "lista vazia" (assertEqual "" [] (limparUsernames []))
    , testCase
        "strings vazias"
        (assertEqual "" ["", ""] (limparUsernames ["", ""]))
    , testCase
        "nomes invalidos"
        (assertEqual "" ["", ""] (limparUsernames ["_.!", "<>~"]))
    ]

test16 =
  testGroup
    "maisDaMetade"
    [ testCase
        "3/5 pares"
        (assertEqual "" True (maisDaMetade even [1, 2, 3, 4, 6]))
    , testCase
        "2/5 pares"
        (assertEqual "" False (maisDaMetade even [1, 2, 3, 4]))
    , testCase
        "2/4 impares"
        (assertEqual "" False (maisDaMetade odd [1, 2, 3, 4]))
    , testCase
        "3/4 impares"
        (assertEqual "" True (maisDaMetade odd [1, 2, 3, 5]))
    , testCase
        "3/4 impares"
        (assertEqual "" True (maisDaMetade odd [1, 2, 3, 5]))
    , testCase
        "lista com 1 elemento"
        (assertEqual "" True (maisDaMetade odd [1]))
    , testCase
        "lista com 1 elemento"
        (assertEqual "" False (maisDaMetade even [1]))
    , testCase "strings" (assertEqual "" True (maisDaMetade isUpper "AaBbC"))
    ]

test17 =
  testGroup
    "filterDesastrado "
    [ testCase
        "1, 5, 7, 10, 3, 4, 15, 9"
        (assertEqual
           ""
           [1, 5, 3, 9]
           (filterDesastrado (\x -> x < 10) [1, 5, 7, 10, 3, 4, 15, 9]))
    , testCase
        "1, 2, 3, 11, 12, 7"
        (assertEqual
           ""
           [1, 7]
           (filterDesastrado (\x -> x < 10) [1, 2, 3, 11, 12, 7]))
    , testCase "10" (assertEqual "" [] (filterDesastrado (\x -> x < 10) [10]))
    , testCase
        "1, 5, 7, 10, 3, 4, 15, 9"
        (assertEqual "" "DLTRO" (filterDesastrado isUpper "TESte DO FiLTRO"))
    , testCase "vazia" (assertEqual "" [] (filterDesastrado isUpper []))
    ]

test18 =
  testGroup
    "palavraMaisLonga"
    [ testCase
        "ola mundo"
        (assertEqual "" "mundo" (palavraMaisLonga ["ola", "mundo"]))
    , testCase
        "ola alo"
        (assertEqual "" "ola" (palavraMaisLonga ["ola", "alo"]))
    , testCase
        "enunciado"
        (assertEqual
           ""
           "comprimento"
           (palavraMaisLonga $
            words
              "Crie uma função que receba uma lista de strings e retorne aquela que tem o maior comprimento"))
    ]

test19 =
  testGroup
    "jogadorBlackJack"
    [ testCase "18" (assertEqual "" True (jogadorBlackJack [10, 8]))
    , testCase "20" (assertEqual "" True (jogadorBlackJack [10, 10]))
    , testCase "20" (assertEqual "" True (jogadorBlackJack [10, 10, 3]))
    , testCase "22" (assertEqual "" False (jogadorBlackJack [10, 7, 5]))
    , testCase "21" (assertEqual "" True (jogadorBlackJack [10, 7, 4]))
    , testCase "27" (assertEqual "" False (jogadorBlackJack [10, 7, 10]))
    ]