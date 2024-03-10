import           Definitions
import           Exercicios
import           Interpreter
import           Eval
import           Test.Tasty
import           Test.Tasty.HUnit

main :: IO ()
main = do
  defaultMain tests

tests :: TestTree
tests =
  (testGroup
     "Semana 5"
     [test01, test02, test03, test04, test05, test06, test07, test08, test09, test10, test11, test12, test13, test14, test15])

test01 =
  testGroup
    "Ex01"
    [ testCase
        "Pontuacao 5 <> Pontuacao 5"
        (assertEqual "" (Pontuacao 10) (Pontuacao 5 <> Pontuacao 5))
    , testCase
        "Pontuacao 5 <> Cola"
        (assertEqual "" (Cola) (Pontuacao 5 <> Cola))
    , testCase
        "Cola        <> Pontuacao 5"
        (assertEqual "" (Cola) (Cola <> Pontuacao 5))
    , testCase
        "Soma de 10 Resultados sem Cola"
        (assertEqual
           ""
           (Pontuacao (sum [1 .. 10]))
           (mconcat $ Pontuacao <$> [1 .. 10]))
    , testCase
        "Soma de 10 Resultados com uma Cola"
        (assertEqual
           ""
           (Cola)
           (mconcat $
            (Pontuacao <$> [1 .. 5]) ++ Cola : (Pontuacao <$> [1 .. 5])))
    ]

test02 = testGroup "Ex02" [test02a, test02b, test02c, test02d, test02e]

test02a =
  testGroup
    "a) Show"
    [ testCase "{}" $ assertEqual "" "{}" (show $ Set ([] :: [Int]))
    , testCase "{0}" $ assertEqual "" "{0}" (show $ Set ([0]))
    , testCase "{1,2}" $ assertEqual "" "{1,2}" (show $ Set ([1, 2]))
    , testCase "{1..10}" $
      assertEqual "" "{1,2,3,4,5,6,7,8,9,10}" (show $ Set ([1 .. 10]))
    , testCase "{\"pao\",\"queijo\"}" $
      assertEqual "" "{\"pao\",\"queijo\"}" (show $ Set (["pao", "queijo"]))
    ]

test02b =
  testGroup
    "b) fromList"
    [ testCase "{}" $ assertEqual "" "{}" (show $ fromList ([] :: [Int]))
    , testCase "{0}" $ assertEqual "" "{0}" (show $ fromList ([0]))
    , testCase "{1,2}" $ assertEqual "" "{1,2}" (show $ fromList ([1, 2]))
    , testCase "[1,1,1,1,1] => {1}" $
      assertEqual "" "{1}" (show $ fromList ([1, 1, 1, 1, 1]))
    , testCase "[5,4,3,2,1] => {1,2,3,4,5}" $
      assertEqual "" "{1,2,3,4,5}" (show $ fromList ([5, 4, 3, 2, 1]))
    , testCase "[9,1,42,62,5,4,1,1,1,3,78] => {1,3,4,5,9,42,62,78}" $
      assertEqual
        ""
        "{1,3,4,5,9,42,62,78}"
        (show $ fromList ([9, 1, 42, 62, 5, 4, 1, 1, 1, 3, 78]))
    , testCase "{1..10}" $
      assertEqual "" "{1,2,3,4,5,6,7,8,9,10}" (show $ fromList ([1 .. 10]))
    , testCase "{\"pao\",\"queijo\"}" $
      assertEqual
        ""
        "{\"pao\",\"queijo\"}"
        (show $ fromList (["pao", "queijo"]))
    , testCase "[pao, pao, pao, pao] => {\"pao\"}" $
      assertEqual
        ""
        "{\"pao\"}"
        (show $ fromList (["pao", "pao", "pao", "pao"]))
    , testCase "[queijo, pao] => {\"pao\",\"queijo\"}" $
      assertEqual
        ""
        "{\"pao\",\"queijo\"}"
        (show $ fromList (["queijo", "pao"]))
    ]

test02c =
  testGroup
    "c) member"
    [ testCase "0 `member` {0}" $
      assertEqual "" True (0 `member` (fromList [0]))
    , testCase "1 `member` {0}" $
      assertEqual "" False (1 `member` (fromList [0]))
    , testCase "9 `member` {1..10}" $
      assertEqual "" True (9 `member` (fromList [1 .. 10]))
    , testCase "42 `member` {1..10}" $
      assertEqual "" False (42 `member` (fromList [1 .. 10]))
    , testCase "queijo `member` {pao,queijo}" $
      assertEqual "" True ("queijo" `member` (fromList ["pao", "queijo"]))
    , testCase "queijo `member` {pao,queijo}" $
      assertEqual "" True ("queijo" `member` (fromList ["queijo", "pao"]))
    , testCase "carne `member` {pao,queijo}" $
      assertEqual "" False ("carne" `member` (fromList ["queijo", "pao"]))
    ]

test02d =
  testGroup
    "d) insert"
    [ testCase "0 `insert` {}    => {0}" $
      assertEqual "" "{0}" (show $ 0 `insert` (fromList []))
    , testCase "0 `insert` {0}   => {0}" $
      assertEqual "" "{0}" (show $ 0 `insert` (fromList [0]))
    , testCase "0 `insert` {1,3} => {0,1,3}" $
      assertEqual "" "{0,1,3}" (show $ 0 `insert` (fromList [1, 3]))
    , testCase "2 `insert` {1,3} => {1,2,3}" $
      assertEqual "" "{1,2,3}" (show $ 2 `insert` (fromList [1, 3]))
    , testCase "3 `insert` {1,3} => {1,3}" $
      assertEqual "" "{1,3}" (show $ 3 `insert` (fromList [1, 3]))
    , testCase "4 `insert` {1,3} => {1,3,4}" $
      assertEqual "" "{1,3,4}" (show $ 4 `insert` (fromList [1, 3]))
    ]

test02e =
  testGroup
    "e) delete"
    [ testCase "0 `delete` {}    => {}" $
      assertEqual "" "{}" (show $ 0 `delete` (fromList []))
    , testCase "0 `delete` {0}   => {}" $
      assertEqual "" "{}" (show $ 0 `delete` (fromList [0]))
    , testCase "0 `delete` {1,3} => {1,3}" $
      assertEqual "" "{1,3}" (show $ 0 `delete` (fromList [1, 3]))
    , testCase "1 `delete` {1,3} => {3}" $
      assertEqual "" "{3}" (show $ 1 `delete` (fromList [1, 3]))
    , testCase "2 `delete` {1,3} => {1,3}" $
      assertEqual "" "{1,3}" (show $ 2 `delete` (fromList [1, 3]))
    , testCase "3 `delete` {1,3} => {1}" $
      assertEqual "" "{1}" (show $ 3 `delete` (fromList [1, 3]))
    ]

test03 =
  testGroup
    "Ex03"
    [ testCase "{} <> {} => {}" $
      assertEqual "" (emptySet) ((emptySet) <> (emptySet))
    , testCase "{0} <> {} => {0}" $
      assertEqual "" (Set [0]) ((Set [0]) <> (emptySet))
    , testCase "{} <> {0} => {0}" $
      assertEqual "" (Set [0]) (emptySet <> (Set [0]))
    , testCase "{1,2} <> {3,4} => {1,2,3,4}" $
      assertEqual "" (Set [1, 2, 3, 4]) ((Set [1, 2]) <> (Set [3, 4]))
    , testCase "{1,3} <> {2,4} => {1,2,3,4}" $
      assertEqual "" (Set [1, 2, 3, 4]) ((Set [1, 3]) <> (Set [2, 4]))
    , testCase "{1,3,42,77} <> {2,4,5,6,7,66}" $
      assertEqual
        ""
        (Set [1, 2, 3, 4, 5, 6, 7, 42, 66, 77])
        ((Set [1, 3, 42, 77]) <> (Set [2, 4, 5, 6, 7, 66]))
    , testCase "mempty <> mempty => mempty" $
      assertEqual "" (mempty_) ((mempty_) <> (mempty_))
    , testCase "{1,2,3} <> mempty => {1,2,3}" $
      assertEqual "" (Set [1, 2, 3]) ((Set [1, 2, 3]) <> (mempty_))
    , testCase "mempty <> {1,2,3} => {1,2,3}" $
      assertEqual "" (Set [1, 2, 3]) (mempty_ <> (Set [1, 2, 3]))
    , testCase "mconcat [] => mempty" $ assertEqual "" (mempty_) (mconcat [])
    , testCase "mconcat [{1,2,3}, {2,3,4}, {4,5,6}, {18,19}, {1,4,9,22}]" $
      assertEqual
        ""
        (Set [1, 2, 3, 4, 5, 6, 9, 18, 19, 22])
        (mconcat
           [ Set [1, 2, 3]
           , Set [2, 3, 4]
           , Set [4, 5, 6]
           , Set [18, 19]
           , Set [1, 4, 9, 22]
           ])
    ]
  where
    emptySet = Set ([] :: [Int])
    mempty_ = mempty :: Set Int

test04 =
  testGroup "Ex04" $
  concat
    [ mkCommutativeTest Tradicional Tradicional Tradicional
    , mkCommutativeTest Tradicional Vegetariano Tradicional
    , mkCommutativeTest Tradicional Vegano Tradicional
    , mkCommutativeTest Vegetariano Vegetariano Vegetariano
    , mkCommutativeTest Vegetariano Vegano Vegetariano
    , mkCommutativeTest Vegano Vegano Vegano
    , [ testCase ("mconcat") $
        assertEqual "" Tradicional $ mconcat [Vegano, Vegetariano, Tradicional]
      ]
    ]
  where
    mkCommutativeTest a b r =
      [ testCase (show a ++ " <> " ++ show b) $ assertEqual "" r $ a <> b
      , testCase (show b ++ " <> " ++ show a) $ assertEqual "" r $ b <> a
      ]

test05 =
  testGroup
    "Ex05"
    [ testCase ("pao <> carne = hamburguer") $ pao <> carne @?= hamburguer
    , testCase ("carne <> pao = hamburguer") $ carne <> pao @?= hamburguer
    , testCase ("pao <> carne <> queijo = xBurger") $
      pao <> carne <> queijo @?= xBurger
    , testCase ("pao <> (carne <> queijo) = xBurger") $
      pao <> (carne <> queijo) @?= xBurger
    , testCase ("carneDeSoja <> pao <> maioneseVegana = xVegan") $
      carneDeSoja <> pao <> maioneseVegana @?= xVegan
    , testCase ("xBurger <> carne = xBurgerDuplo") $
      xBurger <> carne @?= xBurgerDuplo
    , testCase
        ("mconcat [pao, carneDeSoja, maioneseVegana, cheddar] = xVegetCheddar") $
      mconcat [pao, carneDeSoja, maioneseVegana, cheddar] @?= xVegetCheddar
    , testCase ("xVegan <> cheddar = xVegetCheddar") $
      xVegan <> cheddar @?= xVegetCheddar
    ]
  where
    mkIngredient name price diet = Lanche (Set [name]) price diet
    pao = mkIngredient "pao" 200 Vegano --pao, 2 reais, vegano...
    carne = mkIngredient "carne" 700 Tradicional --carne, 7 reais, tradicional...
    carneDeSoja = mkIngredient "carneDeSoja" 900 Vegano
    queijo = mkIngredient "queijo" 600 Vegetariano
    cheddar = mkIngredient "cheddar" 600 Vegetariano
    maionese = mkIngredient "maionese" 600 Vegetariano
    maioneseVegana = mkIngredient "maioneseVegana" 600 Vegano
    hamburguer = Lanche (Set ["carne", "pao"]) 900 Tradicional
    xBurger = Lanche (Set ["carne", "pao", "queijo"]) 1500 Tradicional
    xVegan = Lanche (Set ["carneDeSoja", "maioneseVegana", "pao"]) 1700 Vegano
    xBurgerDuplo = Lanche (Set ["carne", "pao", "queijo"]) 2200 Tradicional
    xVegetCheddar =
      Lanche
        (Set ["carneDeSoja", "cheddar", "maioneseVegana", "pao"])
        2300
        Vegetariano

test06 =
  testGroup
    "Ex06"
    [ testCase "head [1] == 1" $
      assertEqual "" 1 $ runInt $ Apply head_ $ apply2 cons one nil
    , testCase "tail [1] == []" $
      assertEqual "" (run nil) $ run $ Apply tail_ $ apply2 cons one nil
    , testCase "head [1,2] == 1" $
      assertEqual "" 1 $
      runInt $ Apply head_ $ apply2 cons one (apply2 cons two nil)
    , testCase "head $ tail [1,2] == 2" $
      assertEqual "" 2 $
      runInt $ Apply head_ $ Apply tail_ $ apply2 cons one (apply2 cons two nil)
    ]

test07 =
  testGroup
    "Ex07"
    [ testCase "listOfIntToChurch [1,2]" $
      assertEqual "" (run $ apply2 cons one (apply2 cons two nil)) $
      run $ listOfIntToChurch [1, 2]
    , testCase "head [4,5,6] == 1" $
      assertEqual "" 4 $ runInt $ Apply head_ $ listOfIntToChurch [4, 5, 6]
    , testCase "head [42..52] == 42" $
      assertEqual "" 42 $ runInt $ Apply head_ $ listOfIntToChurch [42 .. 52]
    , testCase "head $ tail [42..52] == 43" $
      assertEqual "" 43 $
      runInt $ Apply head_ $ Apply tail_ $ listOfIntToChurch [42 .. 52]
    , testCase "[1,2] == [1,2]" $
      assertEqual "" [1, 2] $
      runListOfInt $ (apply2 cons one (apply2 cons two nil))
    , testCase "[42..52] == [42..52]" $
      assertEqual "" [42 .. 52] $ runListOfInt $ listOfIntToChurch [42 .. 52]
    , testCase "tail [42..52] == [43..52]" $
      assertEqual "" [43 .. 52] $
      runListOfInt $ Apply tail_ $ listOfIntToChurch [42 .. 52]
    ]

test08 =
  testGroup
    "Ex08"
    [ testCase "[1,2] !! 0" $
      assertEqual
        ""
        1
        (runInt $ apply3 yComb at (apply2 cons one (apply2 cons two nil)) (zero))
    , testCase "[1,2] !! 1" $
      assertEqual
        ""
        2
        (runInt $ apply3 yComb at (apply2 cons one (apply2 cons two nil)) (one))
    , testCase "[35..45] !! 7 == 42" $
      assertEqual "" 42 $
      runInt $ apply3 yComb at (listOfIntToChurch [35 .. 45]) (intToChurch 7)
    ]

test09 =
  testGroup
    "Ex09 - Bônus"
    [ testCase "filter isZero [0,1]" $
      assertEqual
        ""
        [0]
        (runListOfInt $
         apply3 yComb filter_ isZero (apply2 cons zero (apply2 cons one nil)))
    , testCase "filter (>3) [4..10]" $
      assertEqual
        ""
        [4 .. 10]
        (runListOfInt $
         apply3
           yComb
           filter_
           (Apply churchLess (intToChurch 3)) -- x > 3
           (listOfIntToChurch [1 .. 10]))
    ]


test10 =
  testGroup
    "Ex10"
    [ testGroup
        "Simple usage of fmap"
        [ testCase "fmap (== '1') (charP '1')) \"1\"" $
          (runParser (fmap (== '1') (charP '1')) "1") @?= Just ("", True)
        , testCase "fmap (== '0') (charP '1')) \"1\"" $
          (runParser (fmap (== '0') (charP '1')) "1") @?= Just ("", False)
        , testCase "fmap (== '1') (charP '1')) \"100\"" $
          (runParser (fmap (== '1') (charP '1')) "100") @?= Just ("00", True)
        , testCase "fmap (== '0') (charP '1')) \"100\"" $
          (runParser (fmap (== '0') (charP '1')) "100") @?= Just ("00", False)
        , testCase "fmap (== '0') (charP '1')) \"200\"" $
          (runParser (fmap (== '0') (charP '1')) "200") @?= Nothing
        , testCase "fmap (== '2') (charP '1')) \"200\"" $
          (runParser (fmap (== '2') (charP '1')) "200") @?= Nothing
        ]
    , testGroup
        "IntExpr, which uses fmap"
        [ testGroup
            "addP"
            [ testCase "+" $ (runParser addP "+") @?= Just ("", Add)
            , testCase "+5" $ (runParser addP "+5") @?= Just ("5", Add)
            , testCase "*" $ (runParser addP "*") @?= Nothing
            , testCase "-" $ (runParser addP "-") @?= Nothing
            ]
        , testGroup
            "subP"
            [ testCase "-" $ (runParser subP "-") @?= Just ("", Sub)
            , testCase "-5" $ (runParser subP "-5") @?= Just ("5", Sub)
            , testCase "+" $ (runParser subP "+") @?= Nothing
            , testCase "*" $ (runParser subP "*") @?= Nothing
            ]
        , testGroup
            "multP"
            [ testCase "*" $ (runParser multP "*") @?= Just ("", Mult)
            , testCase "*5" $ (runParser multP "*5") @?= Just ("5", Mult)
            , testCase "+" $ (runParser multP "+") @?= Nothing
            , testCase "-" $ (runParser multP "-") @?= Nothing
            ]
        ]
    ]

test11 =
  testGroup
    "Ex11"
    [ testGroup
        "Simple usage of apply"
        [ testCase "11" $
          (runParser ((==) <$> digitP <*> digitP) "11") @?= Just ("", True)
        , testCase "12" $
          (runParser ((==) <$> digitP <*> digitP) "12") @?= Just ("", False)
        , testCase "1a" $
          (runParser ((==) <$> digitP <*> digitP) "1a") @?= Nothing
        , testCase "a1" $
          (runParser ((==) <$> digitP <*> digitP) "a1") @?= Nothing
        , testCase "aa" $
          (runParser ((==) <$> digitP <*> digitP) "aa") @?= Nothing
        ]
    , testGroup
        "SequenceA"
        [ testCase "runParser (sequenceA []) \"\"" $
          runParser (sequenceA ([] :: [Parser Char])) "" @?= Just ("", "")
        , testCase "runParser (sequenceA []) abc" $
          runParser (sequenceA ([] :: [Parser Char])) "abc" @?= Just ("abc", "")
        , testCase "runParser (sequenceA [charP 'a', charP 'b']) abc" $
          runParser (sequenceA [charP 'a', charP 'b']) "abc" @?=
          Just ("c", "ab")
        , testCase "runParser helloP \"hello world\"" $
          runParser
            (sequenceA [charP 'h', charP 'e', charP 'l', charP 'l', charP 'o'])
            "hello world" @?=
          Just (" world", "hello")
        ]
    , testGroup
        "stringP, which uses sequenceA"
        [ testCase "runParser (stringP bat) batman" $
          runParser (stringP "bat") "batman" @?= Just ("man", "bat")
        , testCase "runParser (stringP hello) \"hello world\"" $
          runParser (stringP "hello") "hello world" @?= Just (" world", "hello")
        , testCase "runParser (sequenceA [I,Love,Haskell]) \"ILoveHaskell\"" $
          runParser
            (sequenceA $ map stringP ["I", "Love", "Haskell"])
            "ILoveHaskell" @?=
          Just ("", ["I", "Love", "Haskell"])
        ]
    ]

passwordP :: String -> Parser String
passwordP user = stringP (getPassword user)
  where
    getPassword "ana" = "123" -- assuma que toda senha começa com um número
    getPassword "bob" = "456"

test12 =
  testGroup
    "Ex12"
    [ testCase "ana123" $
      runParser (alphaStringP >>= passwordP) "ana123" @?= Just ("", "123")
    , testCase "bob456" $
      runParser (alphaStringP >>= passwordP) "bob456" @?= Just ("", "456")
    , testCase "ana456" $
      runParser (alphaStringP >>= passwordP) "ana456" @?= Nothing
    , testCase "ana123 - multiple binds" $
      runParser
        (alphaStringP >>= \user ->
           passwordP user >>= \pass -> return (user, pass))
        "ana123" @?=
      Just ("", ("ana", "123"))
    , testCase "ana123 - do notation" $
      runParser -- same as before
        (do user <- alphaStringP
            pass <- passwordP user
            return (user, pass))
        "ana123" @?=
      Just ("", ("ana", "123"))
    ]

test13 =
  testGroup
    "Ex13"
    [ testGroup
        "oneOrMoreP (charP 'a')"
        [ testCase "a" $
          runParser (oneOrMoreP (charP 'a')) "a" @?= Just ("", "a")
        , testCase "aaaa" $
          runParser (oneOrMoreP (charP 'a')) "aaaa" @?= Just ("", "aaaa")
        , testCase "aaaab" $
          runParser (oneOrMoreP (charP 'a')) "aaaab" @?= Just ("b", "aaaa")
        , testCase "ab" $
          runParser (oneOrMoreP (charP 'a')) "ab" @?= Just ("b", "a")
        , testCase "ba" $ runParser (oneOrMoreP (charP 'a')) "ba" @?= Nothing
        ]
    , testGroup
        "intP"
        [ testCase "1" $ runParser intP "1" @?= Just ("", 1)
        , testCase "14" $ runParser intP "14" @?= Just ("", 14)
        , testCase "42" $ runParser intP "42" @?= Just ("", 42)
        , testCase "57a" $ runParser intP "57a" @?= Just ("a", 57)
        , testCase "a57" $ runParser intP "a57" @?= Nothing
        ]
    , testGroup
        "listOfIntExprP"
        [ testCase "1" $ runParser listOfIntExprP "1" @?= Just ("", [IntLit 1])
        , testCase "2+5" $
          runParser listOfIntExprP "2+5" @?=
          Just ("", [IntLit 2, Add, IntLit 5])
        , testCase "3*7" $
          runParser listOfIntExprP "3*7" @?=
          Just ("", [IntLit 3, Mult, IntLit 7])
        , testCase "42+99-55*12" $
          runParser listOfIntExprP "42+99-55*12" @?=
          Just
            ("", [IntLit 42, Add, IntLit 99, Sub, IntLit 55, Mult, IntLit 12])
        ]
    , testGroup
        "alphaStringP"
        [ testCase "haskell" $
          runParser alphaStringP "haskell" @?= Just ("", "haskell")
        , testCase "hask3ll" $
          runParser alphaStringP "hask3ll" @?= Just ("3ll", "hask")
        , testCase "h4skell" $
          runParser alphaStringP "h4skell" @?= Just ("4skell", "h")
        , testCase "8askell" $ runParser alphaStringP "8askell" @?= Nothing
        ]
    , testGroup
        "alphaNumStrP"
        [ testCase "haskell" $
          runParser alphaNumStrP "haskell" @?= Just ("", "haskell")
        , testCase "hask3ll" $
          runParser alphaNumStrP "hask3ll" @?= Just ("", "hask3ll")
        , testCase "h4skell" $
          runParser alphaNumStrP "h4skell" @?= Just ("", "h4skell")
        , testCase "8askell" $
          runParser alphaNumStrP "8askell" @?= Just ("", "8askell")
        , testCase "ola mundo" $
          runParser alphaNumStrP "ola mundo" @?= Just (" mundo", "ola")
        ]
    , testGroup
        "firstLastNameP"
        [ testCase "\"Haskell Curry\"" $
          runParser firstLastNameP "Haskell Curry" @?=
          Just ("", ("Haskell", "Curry"))
        , testCase "\"Haskell            Curry\"" $
          runParser firstLastNameP "Haskell            Curry" @?=
          Just ("", ("Haskell", "Curry"))
        ]
    ]

test14 =
  testGroup
    "Ex14"
    [ testGroup
        "optionalP (charP ' ')"
        [ testCase "\"hello\"" $
          runParser (optionalP (charP ' ')) "hello" @?= Just ("hello", Nothing)
        , testCase "\" hello\"" $
          runParser (optionalP (charP ' ')) " hello" @?=
          Just ("hello", Just ' ')
        ]
    , testGroup
        "longNameP"
        [ testCase "\"Haskell Curry\"" $
          runParser longNameP "Haskell Curry" @?=
          Just ("", ["Haskell", "Curry"])
        , testCase "\"Haskell            Curry\"" $
          runParser longNameP "Haskell            Curry" @?=
          Just ("", ["Haskell", "Curry"])
        , testCase "\"Haskell Brooks Curry\"" $
          runParser longNameP "Haskell Brooks Curry" @?=
          Just ("", ["Haskell", "Brooks", "Curry"])
        , testCase "\"Haskell   Brooks      Curry\"" $
          runParser longNameP "Haskell   Brooks      Curry" @?=
          Just ("", ["Haskell", "Brooks", "Curry"])
        ]
    , testGroup
        "yamlP"
        [ testCase "\"hello: world\"" $
          runParser yamlP "hello: world" @?= Just ("", [("hello", "world")])
        , testCase "\"hello: world\\n\"" $
          runParser yamlP "hello: world\n" @?= Just ("", [("hello", "world")])
        , testCase "\"hello: world\\nola: mundo\\nhallo: welt\\n\"" $
          runParser yamlP "hello: world\nola: mundo\nhallo: welt\n" @?=
          Just ("", [("hello", "world"), ("ola", "mundo"), ("hallo", "welt")])
        , testCase "saida do teste alphaStringP" $
          runParser yamlP "haskell: OK\nhask3ll: OK\nh4skell: OK\n8askell: OK\n" @?=
          Just
            ( ""
            , [ ("haskell", "OK")
              , ("hask3ll", "OK")
              , ("h4skell", "OK")
              , ("8askell", "OK")
              ])
        ]
    ]

test15 =
  testGroup
    "Ex15"
    [ testCase "1" $ runParser listOfBoolExprP "1" @?= Just ("", [BoolLit True])
    , testCase "0" $
      runParser listOfBoolExprP "0" @?= Just ("", [BoolLit False])
    , testCase "^" $ runParser listOfBoolExprP "^" @?= Just ("", [And])
    , testCase "v" $ runParser listOfBoolExprP "v" @?= Just ("", [Or])
    , testCase "1^0v1v0" $
      runParser listOfBoolExprP "1^0v1v0" @?=
      Just
        ( ""
        , [ BoolLit True
          , And
          , BoolLit False
          , Or
          , BoolLit True
          , Or
          , BoolLit False
          ])
    ]
