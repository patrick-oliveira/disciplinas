data NaiveBoard = NaiveBoard
    { c00 :: Bool
    , c01 :: Bool
    , c10 :: Bool
    , c11 :: Bool
    } deriving (Show)

data Coord = C0 | C1
    deriving (Show, Enum, Eq)

newtype FBoard = FBoard {board :: Coord -> Coord -> Bool}

initialState :: FBoard
initialState = FBoard (\x y -> False)

occupy :: FBoard -> Coord -> Coord -> FBoard
occupy (FBoard f) x y
    | f x y = FBoard f
    | otherwise = FBoard (\a b -> if a == x && b == y then True else f a b)

unnoccupy :: FBoard -> Coord -> Coord -> FBoard
unnoccupy (FBoard f) x y
    | f x y = FBoard (\a b -> if a == x && b == y then False else f a b)
    | otherwise = FBoard f


stateChange :: IO ()
stateChange =
    do
        print $ board initialState C0 C0
        let newState = occupy initialState C0 C0
        print $ board newState C0 C0
        print $ board newState C1 C0
        let anotherState = occupy newState C1 C0
        print $ board anotherState C0 C0
        let yetAnotherState = occupy (occupy anotherState C0 C1) C1 C1 
        print $ board yetAnotherState C0 C0
        print $ board yetAnotherState C0 C1
        print $ board yetAnotherState C1 C0
        print $ board yetAnotherState C1 C1