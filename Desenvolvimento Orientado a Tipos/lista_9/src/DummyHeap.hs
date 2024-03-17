{-# LANGUAGE GADTs #-}

module DummyHeap (
                     DummyHeap
                   , empty
                   , singleton
                   , null
                   , pop
                   , merge
                   ) where

import Prelude hiding (null)
import Data.List hiding (null)

data DummyHeap a where
  DummyHeap :: Ord a => [a] -> DummyHeap a

-- O(1). Devolve um heap vazio.
empty :: Ord a => DummyHeap a
empty = DummyHeap []

-- O(1). Devolve um heap com um único elemento.
singleton :: Ord a => a -> DummyHeap a
singleton x = DummyHeap [x]

null :: DummyHeap a -> Bool
null (DummyHeap []) = True
null _     = False

pop :: DummyHeap a -> Maybe (a, DummyHeap a)
pop (DummyHeap []) = Nothing
pop (DummyHeap xs0) = Just (h, DummyHeap tl)
  where
    h  = maximum xs0
    tl = delete h xs0

merge :: DummyHeap a -> DummyHeap a -> DummyHeap a
merge (DummyHeap xs) (DummyHeap ys) = DummyHeap $ xs ++ ys
