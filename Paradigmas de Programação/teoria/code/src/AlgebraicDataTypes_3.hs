data Tree a = Empty | Node (Tree a) a (Tree a)

insertBalanced :: a -> Tree a -> Tree a
insertBalanced x Empty = Node Empty x Empty
insertBalanced x (Node l y r)
    | height l < height r = Node (insertBalanced x l) y r
    | height l > height r = Node l y (insertBalanced x r)
    | otherwise = Node (insertBalanced x l) y r

height :: Tree a -> Int
height Empty = 0
height (Node l _ r) = 1 + max (height l) (height r)
