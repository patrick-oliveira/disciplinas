module Atividade01 where
import Data.Foldable
import Data.Maybe
import Data.Semigroup





data Cesta = Cesta [String] Double deriving (Eq)
data Arvore a = Folha a | Nó (Arvore a) a (Arvore a) deriving (Show, Eq)
data Expressão a = Constante a | Mul (Expressão a) (Expressão a) | Soma (Expressão a) (Expressão a)| Sub (Expressão a) (Expressão a) deriving (Show, Eq)
