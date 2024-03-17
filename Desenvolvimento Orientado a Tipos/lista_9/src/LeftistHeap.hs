{-# LANGUAGE GADTs #-}
{-# LANGUAGE StandaloneDeriving #-}

module LeftistHeap (
                     LeftistHeap
                   , empty
                   , singleton
                   , null
                   , pop
                   , merge
                   ) where

import Prelude hiding (null)

-- Heap esquerdista. Veja informações adicionais sobre essa implementação aqui
-- https://haskell.pesquisa.ufabc.edu.br/estruturas-de-dados/03.heaps/#%C3%A1rvores-esquerdistas

data LeftistHeap a where
  LLeaf   :: Ord a => LeftistHeap a
  LNode   :: Ord a => {
    _rank  :: Int,
    _key   :: a,
    _left  :: LeftistHeap a,
    _right :: LeftistHeap a
  } -> LeftistHeap a
deriving instance Show a => Show (LeftistHeap a)


rank :: LeftistHeap a -> Int
rank LLeaf = -1
rank (LNode r _ _ _) = r

makeNode :: Ord a => a -> LeftistHeap a -> LeftistHeap a -> LeftistHeap a
makeNode x a b
  | ra >= rb  = LNode (rb + 1) x a b
  | otherwise = LNode (ra + 1) x b a
  where
    ra = rank a
    rb = rank b

-- Exports

-- O(1). Devolve um heap vazio.
empty :: Ord a => LeftistHeap a
empty = LLeaf

-- O(1). Devolve um heap com um único elemento.
singleton :: Ord a => a -> LeftistHeap a
singleton x = LNode 0 x LLeaf LLeaf

-- O(1). True caso heap vazio, False cc.
null :: LeftistHeap a -> Bool
null LLeaf = True
null _     = False

pop :: LeftistHeap a -> Maybe (a, LeftistHeap a)
pop LLeaf = Nothing
pop (LNode _ v h1 h2) = Just (v, merge h1 h2)

merge :: LeftistHeap a -> LeftistHeap a -> LeftistHeap a
merge LLeaf h = h
merge h LLeaf = h
merge h1@(LNode _ v1 e1 d1) h2@(LNode _ v2 e2 d2)
  | v1 >= v2  = makeNode v1 e1 (merge d1 h2)
  | otherwise = makeNode v2 e2 (merge h1 d2)
