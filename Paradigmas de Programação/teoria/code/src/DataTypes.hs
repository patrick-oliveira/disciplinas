{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- Using Type Annotations to give a significant name to a type
type Money = Int
withdraw :: Money -> Money -> Money
withdraw account qtty
    | account < qtty = error "Not enough money"
    | otherwise      = account - qtty

-- Type annotation doesn't impede meaningless operations
type Temperature = Int
x :: Temperature
x = -3
y :: Money
y = withdraw x 4

-- Creating a new type force type checking at compile time
newtype Money_ = Money_ Int
    deriving (Read, Show, Num)
withdraw_ :: Money_ -> Money_ -> Money_
withdraw_ (Money_ account) (Money_ qtty)
    | account < qtty = error "Not enough money"
    | otherwise      = Money_ (account - qtty)


-- Creating an instance of a type class
newtype Money' = MkMoney' Int
    deriving (Read, Show)

instance Num Money' where
    (+) :: Money' -> Money' -> Money'
    (MkMoney' x) + (MkMoney' y) = MkMoney' (x + y)
    (-) :: Money' -> Money' -> Money'
    (MkMoney' x) - (MkMoney' y) = MkMoney' (x - y)
    (*) :: Money' -> Money' -> Money'
    (MkMoney' x) * (MkMoney' y) = MkMoney' (x * y)
    abs :: Money' -> Money'
    abs (MkMoney' x) = MkMoney' (abs x)
    signum :: Money' -> Money'
    signum (MkMoney' x) = MkMoney' (signum x)
    fromInteger :: Integer -> Money'
    fromInteger x = MkMoney' (fromIntegral x)
    negate :: Money' -> Money'
    negate (MkMoney' x) = MkMoney' (negate x)

-- Composite types
newtype Account = MkAccount (Money_, Money_)
-- Alternative notation
data Account_ = Account_
    { balance :: Money_
    , overdraft :: Money_
    }
    deriving (Read, Show)

newtype Counter a = MkCounter [(a, Int)]
    deriving (Read, Show)

countWords :: Counter String
countWords = MkCounter [("Oi", 10), ("Olá", 15), ("Mundo", 25)]

evidences :: Counter Bool
evidences = MkCounter [(True, 10), (False, 15)]

-- Abstract Data Types: Ceratin details of its definition are hidden.
checkFacts :: Counter Bool -> Double
checkFacts counts = trues / falses
    where
        trues = fromIntegral $ filterAndGroup id counts
        falses = fromIntegral $ filterAndGroup not counts

filterAndGroup :: (a -> Bool) -> Counter a -> Int
filterAndGroup p (MkCounter xs) = foldr countIf 0 xs
    where
        countIf (x, c) acc
            | p x = c + acc
            | otherwise = acc