type Nome = String

newtype NNome = CNome String
    deriving (Show)
helloFulano :: NNome -> String
helloFulano (CNome nome) = "Olá, " ++ nome

exemploNome :: IO ()
exemploNome =
    do
        let nome = CNome "Fulano"
        putStrLn $ helloFulano nome

-- *********************************************************************************************************************

newtype AbstractType a = AbstractType a
    deriving (Show)

exemploAbstractType :: IO ()
exemploAbstractType =
    do
        let abstractType = AbstractType 10
        print abstractType
        let otherAbstractType = AbstractType "Hello"
        print otherAbstractType

-- *********************************************************************************************************************

data Either a b = Left a | Right b
data Prod a b = Prod a b

data Bool = True | False

data Vector2D = Vector2D Double Double
-- *********************************************************************************************************************

newtype Volume = Volume Double
    deriving (Show)
newtype Probabilidade = Probabilidade Double
    deriving (Show)

data Chuva = Chuva Volume Probabilidade
    deriving (Show)
data Temperatura = Celcius Double | Fahrenheit Double
    deriving (Show)

data PrevisaoTempo = Previsao Temperatura Chuva
    deriving (Show)

previsaoDeHoje :: IO ()
previsaoDeHoje =
    do
        let chuva = Chuva (Volume 10) (Probabilidade 0.5)
        let temperatura = Celcius 25
        print $ Previsao temperatura chuva