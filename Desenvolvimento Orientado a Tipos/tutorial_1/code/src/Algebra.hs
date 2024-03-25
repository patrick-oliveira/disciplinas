data Void

data Either_ a = Left_ Void | Right_ a
data Prod_ a = Prod_ () a

-- *********************************************************************************************************************

-- Associatividade da soma
sumAssocLeft :: Either (Either a b) c -> Either a (Either b c)
sumAssocLeft (Left (Left a)) = Left a
sumAssocLeft (Left (Right b)) = Right (Left b)
sumAssocLeft (Right c) = Right (Right c)

sumAssocRight :: Either a (Either b c) -> Either (Either a b) c
sumAssocRight (Left a) = Left (Left a)
sumAssocRight (Right (Left b)) = Left (Right b)
sumAssocRight (Right (Right c)) = Right c

  
-- Associatividade do produto
prodAssocLeft :: ((a, b), c) -> (a, (b, c))
prodAssocLeft ((a, b), c) = (a, (b, c))

prodAssocRight :: (a, (b, c)) -> ((a, b), c)
prodAssocRight (a, (b, c)) = ((a, b), c)


-- Comutando operações
comutaEither :: Either a b -> Either b a
comutaEither (Left a) = Right a
comutaEither (Right b) = Left b

comutaProd :: (a, b) -> (b, a)
comutaProd (a, b) = (b, a)

-- As operações não são comutativas
threshold :: (Num a, Ord a) => Either a a -> Maybe a
threshold (Left x)
    | x > 10 = Just x
    | otherwise = Nothing
threshold (Right x)
    | x > 0 = Just x
    | otherwise = Nothing

testeThreshold :: IO ()
testeThreshold =
    do
        print $ threshold (Left 5)
        print $ threshold (Right 5)
        print $ threshold . comutaEither $ Left 5
        print $ threshold . comutaEither $ Right 5

-- *********************************************************************************************************************


eitherToBool :: Either a a -> Bool
eitherToBool (Left _) = False
eitherToBool (Right _) = True

boolToEither :: Bool -> Either a a
boolToEither False = Left undefined
boolToEither True = Right undefined

-- *********************************************************************************************************************

data Coordinates = Coordinates Int Int
data Piece = PieceA | PieceB | PieceC
data Occupied = Empty | HasPiece Piece
data Position = Position Coordinates Occupied

data Position2 = EmptyCoord Int Int | OccCoord (Int, Int) Piece

positionToPosition2 :: Position -> Position2
positionToPosition2 (Position (Coordinates x y) Empty)        = EmptyCoord x y
positionToPosition2 (Position (Coordinates x y) (HasPiece p)) = OccCoord (x, y) p

position2ToPosition :: Position2 -> Position
position2ToPosition (EmptyCoord x y)    = Position (Coordinates x y) Empty
position2ToPosition (OccCoord (x, y) p) = Position (Coordinates x y) (HasPiece p)