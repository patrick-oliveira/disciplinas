{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Atividade09 (
                     Heap (..)
                   , DH.DummyHeap
                   , LH.LeftistHeap
                   , SLH.SafeLeftistHeap
                   ) where

import qualified DummyHeap as DH
import qualified LeftistHeap as LH
import qualified SafeLeftistHeap as SLH

import Data.Maybe

-- Nesta lista de exercícios nós vamos implementar uma estrutura de dados muito
-- versátil e útil conhecida como fila de prioridades. Em uma fila de prioridades
-- somos capazes de inserir e retirar elementos, com a adicional propriedade de 
-- que os valores retirados são sempre obtidos em ordem (não decrescente/não 
-- crescente a depender da implementação). 
-- Filas de prioridades bem implementadas garantem que a inserção e a retirada de
-- elementos são feitas em tempo logaritmico. A implementação mais tradicional de 
-- filas de prioridades é feita utilizando um heap binário, contudo essa 
-- implementação não é muito apropriada no contexto funcional. Por isso aqui estamos
-- interessados na implementação de heaps esquerdistas. Veja mais informações sobre
-- outros heaps aqui https://haskell.pesquisa.ufabc.edu.br/estruturas-de-dados/03.heaps/
--
--
-- A implementação base para três filas de prioridades é dada nos seguintes arquivos
--
-- * `DummyHeap.hs`   - contém uma implementação bem fuleira de uma fila de prioridades  
--                      usando listas. Essa implementação não é eficiente e não deve ser
--                      usada na prática. Ela está aqui apenas como ponto de comparação.  
-- * `LeftistHeap.hs' - contém a implementação de um heap baseado em árvores esquerdistas.
--                      Árvores esquerdistas são uma estrutura bem simples e que garante
--                      ótimos resultados na prática. Caso queria mais informações sobre
--                      como um heap deste tipo funciona consulte o código, o site da disciplina 
--                       (https://haskell.pesquisa.ufabc.edu.br/estruturas-de-dados/03.heaps/)
--                       ou o livro do Okasaki.
-- 
-- O objetivo desta atividade é pegarmos a estrutura de dados já implementadas nos 
-- arquivos acima e fazermos uma nova versão com segurança nos tipos, ou seja,
-- versões onde o sistema de tipos nos ajuda a provar propriedades de que a implementação
-- é correta.
-- 
-- Para organizar o código criamos (implementação abaixo) uma typeclass que abstrai
-- os detalhes de implementação do heap escolhido. São fornecidas instâncias para 
-- as versões dummy, LeftistHeap e SafeLeftistHeap (esta última só vai funcionar 
-- quando você terminar os exercícios).
--
-- Reveja o código de heaps esquerdistas disponível no arquivo `LeftistHeap.hs`. Em seguida,
-- abra o arquivo `SafeLeftistHeap` e resolva os exercícios ali contidos.
--

-- Typeclass que representa heaps em geral
class Ord a => Heap h a where
  -- Devolve um heap vazio
  empty     :: h a
  
  -- Devolve um heap contendo o elemento recebido como parãmetro
  singleton :: a -> h a
  
  -- Determina se o heap está vazio
  null     :: h a -> Bool
  
  -- Retira o maior elemento do heap (caso exista) e devolve um par contendo o
  -- Elemento retirado e o heap remanescente.
  pop      :: h a -> Maybe (a, h a)

  -- Devolve o maior elemento do heap. Note que por usar `pop` se baseia na 
  -- preguiça do código para não calcular o que seria o heap remanescente após
  -- a retirada do valor.
  head :: h a -> Maybe a
  head h = fst <$> pop h

  -- Devolve o heap sem o seu maior elemento (caso tal elemento exista). Assim
  -- como `head` se apoia na preguiça do código.
  tail :: h a -> Maybe (h a)
  tail h = snd <$> pop h

  -- Dados dois heaps devolve um único heap que é a união dos elementos de ambos.
  merge :: h a -> h a -> h a

  -- Insere um elemento em um heap.
  insert :: a -> h a -> h a
  insert a h = merge h (singleton a)

  -- Constroi um heap de uma lista qualquer.
  fromList  :: [a] -> h a
  fromList [] = empty
  fromList l =
    mergeList (map singleton l)
    where
      -- merge a lista até que tenha um único elemento
      mergeList [a] = a
      mergeList x = mergeList (mergePairs x)
      -- merge par a par da lista de heaps
      mergePairs (a:b:c) = merge a b : mergePairs c
      mergePairs x = x

  -- Quase um HeapSort (dependendo da impl. do heap)
  toList :: h a -> [a]
  toList h = fromMaybe [] $ do
    (hd, tl) <- pop h
    return $ hd : toList tl
    
-- Declaração de instãncias para cada uma das implementações de Heaps

instance Ord a => Heap DH.DummyHeap a where
  empty     = DH.empty
  singleton = DH.singleton
  null      = DH.null
  pop       = DH.pop
  merge     = DH.merge

instance Ord a => Heap LH.LeftistHeap a where
  empty     = LH.empty
  singleton = LH.singleton
  null      = LH.null
  pop       = LH.pop
  merge     = LH.merge

instance Ord a => Heap SLH.SafeLeftistHeap a where
  empty     = SLH.empty
  singleton = SLH.singleton
  null      = SLH.null
  pop       = SLH.pop
  merge     = SLH.merge

 
