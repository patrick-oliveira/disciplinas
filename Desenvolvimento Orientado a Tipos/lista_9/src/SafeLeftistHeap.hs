{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE LambdaCase #-}

module SafeLeftistHeap (
                     SafeLeftistHeap
                   , empty
                   , singleton
                   , null
                   , pop
                   , merge
                   ) where

import Prelude hiding (null)
import GHC.TypeNats
import Data.Kind
import NatTools
import Data.Proxy


-- | Exercício 1. Em um uma árvore esquerdista (estrutura na qual
--   se baseia um heap esquerdista), a altura (rank) da sub-árvore esquerda 
--   de qualquer nó é sempre maior ou igual à altura da sub-árvore
--   direita. O rank de um nó é o comprimento do caminho de até o nó não 
--   nulo mais à direita.  Se olharmos a definição do 
--   tipo de dados LeftistHeap em `LeftistHeap.hs` veremos que nada impede 
--   que tentemos "pendurar" uma árvore maior à direita do que a sub-árvore
--   à esquerda. Altere a definição dada naquele arquivo para que o rank passe a
--   fazer parte do tipo (e não seja mais um valor contido no tipo). Em outras 
--   palavras, queremos que o compilador possa fazer em tempo de compilação 
--   verificações sobre a corretude da árvore. O esqueleto da definição já é dado 
--   abaixo. A constraint MinEq l r r já garante que r <= l. Note também que, 
--   apesar da definição usual de rank estabelecer o valor -1 para um nó vazio,
--   como estamos usando naturais deslocamos todos os ranks de 1, assim o nó 
--   vazio passa a ser rank 0 (veja o construtor LLeaf).

-- SS de Sized Safe Leftist Heap
type SSLeftistHeap :: Nat -> Type -> Type
data SSLeftistHeap n a where
  LLeaf :: Ord a => SSLeftistHeap 0 a
  LNode :: (Ord a, KnownNat l, KnownNat r, MinEq l r r)
        => -- ...
deriving instance Show a => Show (SSLeftistHeap n a)


-- | Exercício 2. Para podermos trabalhar com segurança nos tipos, o usuário
--   da nossa estrutura de dados vai ter que trabalhar com um tipo existêncial.
--   (já que o tipo vai depender do rank da árvore que é apenas sabido em tempo
--   de execução). Para saber mais o porquê desta necessidade veja aqui:
--   https://haskell.pesquisa.ufabc.edu.br/desenvolvimento-orientado-a-tipos/05.gadts/#tipos-existenciais )
--   Implemente o tipo ExSafeLeftistHeap que é um tipo existencial para SSLefistHeap
 
data ExSafeLeftistHeap a where
  MkExSafeLeftistHeap :: KnownNat n => -- ...
deriving instance Show a => Show (ExSafeLeftistHeap a)


-- | Exercício 3. Para podermos trabalhar com um tipo existencial é comum o
--   uso de uma função "eliminadora"  que dado um tipo existencial nos permite
--   trabalhar como valor que ela contém. Implemente a função eliminadora 
--   `withHeap` cuja assinatura é dada abaixo.
 
withHeap :: ExSafeLeftistHeap a -> (forall n. KnownNat n => SSLeftistHeap n a -> b) -> b
withHeap = undefined


-- | Exercício 4. Implemente a função `rank` que dado um heap devolve o seu
--   rank que é definido como sendo o rank da sua raiz.
rank :: SSLeftistHeap n a -> Proxy n
rank = undefined


-- A criação de um novo nó para a árvore exige alguma ginástica. Isto é
-- necessário porque precisamos provar que o novo nó obedece todas as 
-- regras necessárias para a sua criação (rank esquerdo >= direito).
-- Para codificar esta prova usamos um GADT que carrega a informação de
-- que o rank de um heap é um natural conhecido. 

data KnownNatOrdProof n a where
  MkProof :: KnownNat n => SSLeftistHeap n a -> KnownNatOrdProof n a

-- Em seguida podemos usar essa prova de que conhecemos o rank de um heap
-- para fazer executar uma continuação sobre o heap em questão. (Note a 
-- semelhança com o eliminador do tipo existencial no uso do CPS-style
-- https://en.wikibooks.org/wiki/Haskell/Continuation_passing_style )
withProof :: KnownNatOrdProof n a -> (forall m. KnownNat m => SSLeftistHeap m a -> b) -> b
withProof (MkProof h) f = f h

-- E, finalmente, podemos criar uma função `mkNode` que 
-- dado um valor e duas subárvores (subheaps) devolve uma nova subárvore
-- (embutida em uma prova que o seu rank é conhecido). 
 
mkNode :: (KnownNat l, KnownNat r, Ord a)
       => a -> SSLeftistHeap l a -> SSLeftistHeap r a -> KnownNatOrdProof  (1 + Min l r) a
mkNode x a b =
  case cmpNat (rank a) (rank b) of
    GTI -> MkProof $ LNode x a b -- a > b
    EQI -> MkProof $ LNode x a b -- a == b
    LTI -> MkProof $ LNode x b a -- a < b

-- Exports

-- Como não queremos que o usuário da nossa estrutura de dados precise lidar
-- com tipos existenciais, ranks e tudo mais, exportamos o tipo existêncial
-- mascarado por um sinônimo que, no final, torna o tipo opaco para o usuário.

type SafeLeftistHeap = ExSafeLeftistHeap

-- | Exercício 5. Implemente a função `empty` que devolve um Heap novo vazio 
empty :: Ord a => ExSafeLeftistHeap a
empty = undefined

-- | Exercício 6. Implemente a função `sigleton` que devolve um Heap novo 
--   contendo apenas o elemento recebido como parâmetro. 
singleton :: Ord a => a -> ExSafeLeftistHeap a
singleton = undefined

-- | Exercício 7. Implemente a função `null` que determina se o heap recebido 
--   como parâmetro é vazio. Use a função eliminadora definida no exercício 3. 
null :: ExSafeLeftistHeap a -> Bool
null = undefined

-- | Exercício 8. O grosso do trabalho de um heap esquerdista é feito pela 
--   função merge. Ela junta dois heaps esquerdistas em um só e é usada tanto
--   na inclusão quanto na remoção de elementos de um heap. Aqui separamos a 
--   função merge em duas funções, uma que trata da versão existencial dos 
--   tipos (`merge`) e outra que trada da versão comum dos tipos `merge0`. 
--   Implemente a função `merge0` para que o comportamento da função merge
--   tenha comportamento análogo ao da função merge definida em 
--   `LeftistHeap.hs`. 

merge0 :: (KnownNat n, KnownNat m) => SSLeftistHeap n a -> SSLeftistHeap m a -> ExSafeLeftistHeap a
merge0 = undefined

merge :: ExSafeLeftistHeap a -> ExSafeLeftistHeap a -> ExSafeLeftistHeap a
merge a b = withHeap a $
            withHeap b
            merge0

-- | Exercício 9. Implemente a função `pop` com comportamento análogo àquela
--   definida em `LeftistHeap.hs`.  
pop :: ExSafeLeftistHeap a -> Maybe (a, ExSafeLeftistHeap a)
pop = undefined
