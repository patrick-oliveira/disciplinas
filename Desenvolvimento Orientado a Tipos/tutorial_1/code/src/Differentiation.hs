
data ListDerivative a = ListDerivative [a] [a]
    deriving Show

diffOperator :: [a] -> ListDerivative a
diffOperator la = ListDerivative [] la

-- Isto não é exatamente uma função inversa, mas para fins didáticos...
diffOperatorInverse :: ListDerivative a -> [a]
diffOperatorInverse (ListDerivative la ra) = reverse la ++ ra

context :: ListDerivative a -> Maybe a
context (ListDerivative _ []) = Nothing
context (ListDerivative ra (a:la)) = Just a

moveUp :: ListDerivative a -> ListDerivative a
moveUp (ListDerivative la (x:ra)) = ListDerivative (x:la) ra

moveDown :: ListDerivative a -> ListDerivative a
moveDown (ListDerivative [] ra) = ListDerivative [] ra
moveDown (ListDerivative (x:la) ra) = ListDerivative la (x:ra)

exemploDerivadaLista :: IO ()
exemploDerivadaLista = do
    let lista = [1, 2, 3, 4, 5] :: [Int]
    let derivada = diffOperator lista
    print derivada
    print $ context derivada
    print $ moveUp derivada
    let derivada' = moveUp $ moveUp derivada
    print derivada'
    print $ context derivada'
    print $ moveDown $ moveUp $ moveUp derivada
    print $ diffOperatorInverse $ moveDown $ moveUp derivada