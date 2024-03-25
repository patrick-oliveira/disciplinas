import Data.List (intercalate)

data Nat = Zero | Succ Nat

data Nat' = One | Two | Three
    deriving Enum

-- ************************************************************

data List a = Empty | Cons a (List a)
    deriving Show

exemploLista:: IO ()
exemploLista = do
    let lista = Cons 1 (Cons 2 (Cons 3 Empty))
    print lista

-- ************************************************************
data Json =
    JInt Int
    | JFloat Float
    | JString String
    | JBool Bool
    | JList [Json]
    | JMap [(String, Json)]
    deriving Show

jsonToString :: Json -> String
jsonToString (JInt n) = show n
jsonToString (JFloat f) = show f
jsonToString (JString s) = "\"" ++ s ++ "\""
jsonToString (JBool b) = if b then "true" else "false"
jsonToString (JList xs) = "[" ++ intercalate ", " (map jsonToString xs) ++ "]"
jsonToString (JMap kvs) = "{" ++ intercalate ", " (map (\(k, v) -> "\"" ++ k ++ "\": " ++ jsonToString v) kvs) ++ "}"

exemploJson:: IO ()
exemploJson = do
    let json = JMap [("nome", JString "João"), ("idade", JInt 20), ("endereço", JMap [("rua", JString "Rua 1"), ("cidade", JString "Cidade 1")])]
    print json
    putStrLn $ jsonToString json
