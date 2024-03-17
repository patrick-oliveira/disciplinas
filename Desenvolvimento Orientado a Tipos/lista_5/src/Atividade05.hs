{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unticked-promoted-constructors #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

module Atividade05 where

import Data.Kind

-- | Exercício 1. A definição de naturais (`Nat`) de Peano no nível
-- dos tipos está dada abaixo. Para facilitar o seu uso, vamos
-- utilizar uma classe de tipos chamada `NatToInt` com um único método
-- `natToInt :: Int`, que não recebe nenhum parâmetro e que devolve um
-- termo (valor em tempo de execução) do tipo `Int` que é o valor
-- equivalente ao número de Peano representado pelo tipo em questão.
--
-- a) Forneça a assinatura de tipos completa para a definição da
-- classe `NatToInt`
-- b) Implemente as instancias necessárias de `NatToInt`
-- c) Ainda não dispomos das ferramentas necessárias para definir
-- tipos do kind `Nat` de maneira genérica. Portanto, apenas por
-- enquanto, vamos fazer  uma versão hard-coded representando os
-- naturais de 0 até 5. Crie os sinônimos de tipos `N0`, `N1`, `N2`,
-- `N3`, `N4` e `N5` usando a palavra reservada `type` para os
-- números de Peano correspondentes.

data Nat = Zero | Suc Nat

type NatToInt :: ...
class NatToInt n where
  natToInt :: Int

-- | Exercício 2. O tipo lista, padrão em Haskell, tem duas
-- características importantes. A primeira é a de que todos os
-- elementos que elas contém DEVEM ter o mesmo tipo. A segunda é a de
-- que o tamanho da lista é arbitrário podendo ser, inclusive,
-- infinito. Neste exercício vamos criar uma lista de tamanho fixo e
-- pré-determinado, que apesar de só aceitar valores do mesmo tipo, já
-- vai ter presente alguns dos conceitos que vamos precisar quando
-- formos criar uma lista realmente heterogênea e tipada! Uma lista de
-- tamanho fixo pode ser útil, por exemplo, para garantir que uma
-- função receba um parâmetro contendo uma lista de valores com um
-- tamanho pré-determinado. Isso garante que não teremos erros durante
-- a execução do código porque uma função que esperava uma lista com 3
-- valores recebeu uma lista com 4. Mais ainda, essa verificação é
-- feita em tempo de compilação garantindo que não haja overhead na
-- execução do código.
--
-- Nosso novo tipo que chamará `SizedList`, é um tipo paramétrico com
-- 2 parâmetros: um representando o tamanho da lista (usando naturais
-- de Peano) e o outro o tipo dos elementos que a lista conterá. Um
-- esqueleto da sua definição é fornecido abaixo. Ele possui 2
-- construtores, `SEmpty`, equivalente ao `[]`, que representa a lista
-- vazia e o `SCons`, equivalente ao `(:)` que, dado um valor e a
-- cauda da lista devolve uma nova lista. Atente-se para o fato de
-- que, como `SizedList` é um tipo paramétrico no tamanho e no tipo
-- dos elementos, o construtor `SCons` deve prever que a cauda tenha
-- um tipo diferente do seu retorno, mais especificamente, o tamanho
-- da cauda é o tamanho do retorno menos um.
--
-- a) Adicione a assinatura de tipos para a declaração de `SizedList`
--
-- b) Complete o preenchimento do GADT `SizedList` com os tipos
-- apropriados para ambos os construtores. Eles devem funcionar de
-- maneira análoga aos construtores correspondentes (`[]` e `(:)`)
-- usados para uma lista comum.
--
-- c) Implemente a função
-- `sLength :: forall l a. NatToInt l => SizedList l a -> Int` que
-- quando chamada com uma `SizedList` devolva o seu tamanho.
--
-- d) Assim como ocorreu no exercício 01, ainda não dispomos de todo o
-- ferramental necessário para implementarmos operações genéricas nos
-- nossos tipos novos, então, pelo menos por enquanto, vamos usar
-- versões hard-coded. Crie as funções `sl0 :: [a] -> SizedList N0 a`,
-- `sl1 :: [a] -> SizedList N1 a`, ..., `sl5 :: [a] -> SizedList N5 a`
-- que quando chamadas com uma lista de elementos do tipo `a` devolve
-- uma `SizedList n a` contendo os elementos fornecidos. Você pode
-- assumir que a lista fornecida tem o número de elementos exatamente
-- igual ao necessário para a criação da `SizedList`.
--
-- e) Implemente a função `sToList :: SizedList l a -> [a]` que faz a
-- conversão de uma `SizedList` em uma lista comum.

type SizedList :: ...
data SizedList l a where
  SEmpty :: ...
  SCons :: ...

instance (Show a, NatToInt l) => Show (SizedList l a) where
  show sl = "SizedList[" ++ show (sLength sl) ++ "]: " ++ show (sToList sl)


-- | Exercício 3. Como mostramos no Exercício 2, em alguns casos pode
-- ser importante garantir o tamanho de uma lista em tempo de
-- compilação. Para algumas aplicações é razoável supor também que
-- precisemos garantir alguma propriedade de uma matriz como, por
-- exemplo, que ela seja uma matriz triangular. A maneira tradicional
-- de se representar matrizes em Haskell é através de listas de
-- listas, ou seja, uma matriz de inteiros seria representada como
-- `[[Int]]`. Essa representação não nos garante as propriedades que
-- desejamos (nem mesmo que seria uma matriz!) já que poderíamos
-- definir algo assim:
--
-- `[[1], [2, 3, 4, 5], [6, 7], [8, 9, 10, 11, 12]]`
--
-- É fácil consertar esse problema e garantir que uma matriz MxN seja
-- bem formada usando o tipo `SizedList` que definimos no exercício
-- anterior. Basta criar um valor do tipo
--
-- `SizedList m (SizedList n a)`.
--
-- Nese exercício iremos um pouquinho além, vamos definir um tipo de
-- dados `MatrizTriangular` que vai garantir que tenhamos uma matriz
-- triangular bem formada! A ideia é que nosso tipo vai ser uma lista
-- ligada contendo, para uma matriz de dimensão NxN contendo valores
-- do tipo `a`, `SizedList`s com N, N - 1, N -2, ..., 0 elementos
-- cada.
--
-- a) Usando a mesma ideia que foi aplicada em `SizedList`, adicione a
--    assinatura de tipos e complete as definições do GADT
--    `MatrizTriangular`
--
-- b) Defina a função
--    `mDim :: forall n a. NatToInt n => MatrizTriangular n a -> Int`
--     que devolve um inteiro com a dimensão da matriz.
--
-- c) Assim como nos exercício 01 e 02, ainda não temos o que
--    precisamos para operações genéricas. Vamos nas versões
--    hard-coded. Crie as funções:
--       `ms0 :: [[a]] -> MatrizTriangular N0 a`
--       `ms1 :: [[a]] -> MatrizTriangular N1 a`
--       ...
--       `ms5 :: [[a]] -> MatrizTriangular N5 a`
--    que quando recebem uma matriz triangular definida como lista de
--    listas devolvem uma `MatrizTriangular`. Você pode assumir que a
--    lista fornecida tem o número de elementos correto e que apenas os
--    valores abaixo da diagonal principal (inclusive) são fornecidos.
--
-- d) Implemente a função `mToList :: MatrizTriangular n a -> [[a]]`
--    conversão de uma `MatrizTriangular` em uma lista de listas comum.


type MatrizTriangular :: ...
data MatrizTriangular n a where
  MEmpty :: ...
  MCol :: ...

instance (Show a, NatToInt l) => Show (MatrizTriangular l a) where
  show m = "MatrizTriangular[" ++ show (mDim m) ++ "]: " ++ show (mToList m)


-- | Exercício 4. Árvores binomiais são um componente essencial para a
-- implementação de um heap binomial, uma estrutura de dados que ainda
-- ouviremos falar neste curso.
--
-- Uma árvore binomial é uma estrutura recursiva que é definida como:
--
--   (i) Toda árvore binomial tem um rank >= 0
--
--   (ii) Uma árvore binomial de rank r contém exatamente 2^r valores
--
--   (iii) Uma árvore binomial de rank r + 1 é formada pela conexão de
--         duas árvores binomiais de rank r, fazendo uma árvore se
--         tornar uma filha à esquerda da outra
--
-- Uma maneira alternativa de definir uma árvore binomial é:  uma
-- árvore binomial de rank r é um nó com  r filhos, t_1, t_2, ..., t_r
-- onde cada t_i é uma árvore binomial de rank r - i.
--
-- Exemplos:
--
--  Rank 0     Rank 1     Rank 2     Rank 3
--
--    3          4           6        _-- 8
--               |         / |       /  / |
--               3        4  5      7  5  3
--                        |       / |  |
--                        3      2  0  4
--                               |
--                               1
--
-- Mais informações (incluindo a implementação de referência que vocês
-- podem usar de base) podem ser vistas aqui:
-- https://haskell.pesquisa.ufabc.edu.br/estruturas-de-dados/03.heaps/#heaps-binomiais
--
-- Em particular, quando olhamos a definição (iii) vocês já devem ter
-- se lembrado de algo! Quem sabe dos exercícios 2 e 3! :)
--
-- a) Preencha a assinatura do tipo BiTree e também complete o GADT
--    que possui dois construtores, `BiTree0` para criar árvores de
--    rank 0 e `BiTree` pra árvores de rank > 0. O primeiro recebe
--    apenas o valor ser armazenado pelo nó e devolve uma árvore de
--    rank 0. O segundo recebe as duas sub-árvores de rank n e devolve
--    uma árvore de rank n + 1.
--
-- b) Implemente uma função `getRoot :: BiTree r a -> a` que devolva a
--    o valor armazenado na raiz da árvore binomial.
--
-- c) Implemente a função
--    `getRank :: forall r a. NatToInt r => BiTree r a -> Int`
--    que dada uma `BiTree` devolva o seu rank.
--
-- d) Como vamos usar essa implementação de árvore binomial para
--    implementar um heap binomial, é importante que o processo de
--    conexão de duas árvores seja feito de modo sempre a deixar o
--    maior elemento sempre na raiz. O construtor que definimos no
--    item a) simplesmente conecta as árvores na ordem dada sem olhar
--    para os valores. Implemente a função:
--
--    `linkTree :: Ord a => BiTree r a -> BiTree r a -> BiTree (Suc r) a`
--
--    que faça justamente isso, ou seja, que dadas duas árvores de
--    rank r devolva uma nova árvore de rank r + 1 mas que tem como
--    propriedade que a árvore com maior raiz fique à direita.


type BiTree :: ...
data BiTree rnk a where
  BiTree0 :: ...
  BiTree ::  ...
deriving instance Show a => Show (BiTree r a)
