{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# OPTIONS_GHC -Wno-unticked-promoted-constructors #-}
{-# LANGUAGE FlexibleInstances #-}

module Atividade08 where

import Data.Type.Bool
import Data.Type.Equality

import Data.Proxy
import GHC.TypeNats (KnownNat, natVal)

-- | Uma Type Family poode ser encarada como sendo uma
-- função que atua no nível dos tipos em vez de atuar no nível dos
-- termos. A type family `Elem` abaixo recebe um tipo e uma lista (um
-- tipo do kind `a` e uma lista de kind `[a]`), e verifica se o tipo
-- está dentro da lista. Note a semelhança com uma versão de `elem`
-- escrita para termos/valores convencionais:
--
-- elem :: Eq a => a -> [a] -> Bool
-- elem r []                    = False
-- elem r0 (r1 : rs) | r0 == r1 = True
-- elem r0 (_  : rs)            = elem r0 rs
--
-- A principal diferença, nesta implementação, é o fato de que tipos
-- são naturalmente comparáveis por igualdade e na versão de valores,
-- precisamos adicionar a restrição `Eq a`.

type Elem :: a -> [a] -> Bool
type family Elem r rs where
  Elem r '[]      = False
  Elem r (r : rs) = True
  Elem r (_ : rs) = Elem r rs

-- | Exercicio 1. Implemente a type family `Null` cujo comportamento
-- deve ser análogo à sua versão para listas comuns (`null`). A
-- assinatura já é dada abaixo.

type Null :: [a] -> Bool
type family Null xs where
--  ...

-- | Exercicio 2. Implemente a type family `Intersect` cujo
-- comportamento deve ser análogo à sua versão para listas comuns
-- (`intersect`) cuja documentação pode ser vista aqui:
-- https://hackage.haskell.org/package/base-4.16.3.0/docs/Data-List.html#v:intersect
-- A assinatura já é dada abaixo.

type Intersect :: [a] -> [a] -> [a]
type family Intersect xs ys where
--  ...

-- | Exercicio 3. Implemente a type family `Same` que dadas duas
-- listas devolve um booleano indicando se as listas são iguais. A
-- assinatura já é dada abaixo.

type Same :: [a] -> [a] -> Bool
type family Same xs ys where
--  ...

-- | Exercicio 4. Até 1900 não se sabia muito bem porque, às vezes,
-- quando se efetuava uma transfusão de sangue o receptor acabava
-- morrendo e porque as vezes tudo funcionava como esperado. Neste ano
-- Karl Landsteiner, descobriu (descoberta esta que lhe rendeu um
-- Nobel em 1930) que misturar o sangue de algumas pessoas, em alguns
-- casos, causava uma forte reação que resultava na destruição das
-- hemácias (glóbulos vermelhos) além de formação de coágulos. Após
-- diversos experimentos Karl encontrou três tipos de sangue chamados
-- de A, B e O. Alguns anos depois também foi descoberto o tipo AB,
-- dando origem à classificação ABO de sangue que usamos até hoje. O
-- ADT `TipoABO`, definido abaixo, representa esses 4 tipos
-- sanguíneos:
--
data TipoABO = A | B | AB | O
--
-- O tipo sanguíneo de uma pessoa é determinado pela presença dos
-- antígenos A e B em suas hemáceas. Confira a tabela abaixo:
--
--  | Antígeno A | Antígeno B | Tipo Sanguíneo | Anticorpos Contra |
--  |------------|------------|----------------|-------------------|
--  | Sim        | Não        | A              | Anti. B           |
--  | Não        | Sim        | B              | Anti. A           |
--  | Sim        | Sim        | AB             | Nenhum            |
--  | Não        | Não        | O              | Anti. A e B       |
--
-- A incompatibilidade entre os tipos sanguíneos é dada pela presença
-- de anticorpos contra um determinado antígeno. Assim, caso uma
-- pessoa tenha anticorpos contra o antígeno X, ela não pode receber
-- doações de sangue que contenham o antígeno X.
--
-- Existe ainda outra consideração a ser feita para determinar a
-- viabilidade da doação que é o fator Rh do sangue, descoberto em
-- 1940 pelo mesmo Karl Landsteiner. O Fator Rh do sangue de uma
-- pessoa é dado pela presença do antígeno Rh em suas hemáceas. Caso o
-- antígeno esteja presente, o sangue tem o fator Rh positivo, caso
-- esteja ausente, fator Rh negativo. Pessoas com Rh positivo não tem
-- anticorpos contra o antígeno Rh. Por outro lado pessoas com Rh
-- negativo podem ter ou não anticorpos contra este antígeno.
--
-- O ADT `Antigeno` representa os 3 antígenos relevantes, e o ADT
-- `FatorRh` o fator do sague de uma pessoa.
--
data Antigeno = AntA | AntB | AntRh deriving Show
data FatorRh = Pos | Neg
--
-- Como nesta disciplina estamos interessados em verificar tudo no
-- nível dos tipos, enxergue as definições acima promovidas, ou seja,
-- temos os kinds `TipoABO`, `Antigeno` e `FatorRh` com os seus
-- respectivos tipos. Desta maneira podemos definir `TipoSanguineo`
-- como abaixo e em seguida definir um sinônimo para cada um dos
-- possíveis tipos sanguíneos:
--
data TipoSanguineo t r = TipoS t r

type AP  = TipoS A  Pos
type AN  = TipoS A  Neg
type BP  = TipoS B  Pos
type BN  = TipoS B  Neg
type ABP = TipoS AB Pos
type ABN = TipoS AB Neg
type OP  = TipoS O  Pos
type ON  = TipoS O  Neg
--
-- Escreva a type family `TipoTemAntigenos`, cuja assinatura é dada
-- abaixo, que dado um TipoABO devolve uma lista dos antígenos que o
-- sangue daquele tipo com certeza possui.
--

type TipoTemAntigenos :: TipoABO -> [Antigeno]
type family TipoTemAntigenos t where
--  ...

-- | Exercicio 5. Escreva a type family `FatorRhTemAntigeno` que dado
-- um `FatorRh` devolva uma lista com os antígenos que aquele sangue
-- com certeza possúi. A assinatura é dada abaixo.

type FatorRhTemAntigeno :: FatorRh -> [Antigeno]
type family FatorRhTemAntigeno t where
--  ...

-- | Exercicio 6. Escreva a type family `TipoTemAnticorposPara` que
-- dado um `TipoABO` devolva uma lista com os antígenos que aquele
-- sangue com certeza possúi. A assinatura é dada abaixo.

type TipoTemAnticorposPara :: TipoABO -> [Antigeno]
type family TipoTemAnticorposPara t where
--  ...


-- | Exercicio 7. Escreva as type families `PodeDoarPara` e
-- `PodeReceberDe` que dados os `TipoSanguineo`s do doador e
-- receptor/receptor doador devolva um booleano indicando se a doação
-- é possível ou não. Consulta a descrição dos doadores compatíveis no
-- Exercício 4.

type PodeDoarPara :: TipoSanguineo TipoABO FatorRh -> TipoSanguineo TipoABO FatorRh -> Bool
type family PodeDoarPara doador receptor where
--  ...

type PodeReceberDe :: TipoSanguineo TipoABO FatorRh -> TipoSanguineo TipoABO FatorRh -> Bool
type family PodeReceberDe receptor doador  where
--  ...

-- | Exercicio 8. Escreva as type families `GetTipoABO`, `GetFatorRh`,
-- e `GetTipoSanguineo` que recebem uma lista de antígenos presentes
-- no sangue e que devolvem o tipo, fator e tipo sanguineo. As
-- assinaturas estão dadas abaixo. Lembre-se de utilizar as type
-- families desenvolvidas nos exercícios anteriores e, caso ache
-- necessário, desenvolva type families auxiliares! Assim a
-- implementação ficará bem simples.

type GetTipoABO :: [Antigeno] -> TipoABO
type family GetTipoABO as where
--  ...

type GetFatorRh :: [Antigeno] -> FatorRh
type family GetFatorRh as where
--  ...

type GetTipoSanguineo :: [Antigeno] -> TipoSanguineo TipoABO FatorRh
type family GetTipoSanguineo as where
--  ...

-- A seguinte typeclass e instâncias são para facilitar o debug da sua
-- implementação. Você pode, por exemplo, executar a seguinte linha no
-- GHCI para testar suas implementações de type families:
--
-- > :set -XDataKinds
-- > :set -XTypeApplications
-- >
-- >
-- > :k! TipoTemAntigenos O
-- > TipoTemAntigenos O :: [Antigeno]
-- > = '[]
-- >
-- > pprint0 @(TipoTemAntigenos O)
-- > "[]"
-- >
-- >
-- > :k! TipoTemAntigenos A
-- > TipoTemAntigenos A :: [Antigeno]
-- > = '[ 'AntA]
-- >
-- > pprint0 @(TipoTemAntigenos A)
-- > "Antigeno A : []"
-- >
-- >
-- > :k! TipoTemAnticorposPara O
-- > TipoTemAnticorposPara O :: [Antigeno]
-- > = '[ 'AntA, 'AntB]
-- >
-- > pprint0 @(TipoTemAnticorposPara O)
-- > "Antigeno A : Antigeno B : []"
-- >
-- >
-- > :k! PodeDoarPara BP AN
-- > PodeDoarPara BP AN :: Bool
-- > = 'False
-- >
-- > pprint0 @(PodeDoarPara BP AN)
-- > "False"
-- >
--
-- Note que até conseguimos transformar o resultado das nossas
-- computações no nível dos tipos para um valor no nível dos termos
-- usando o pprint0. Poderíamos eventualmente criar novas classes de
-- tipos especializadas para cada uma das combinações de typeclasses
-- para obter cada um dos resultados. Contudo, estamos limitados aos
-- tipos já existentes. Fica muito difícil (a menos de fazer uma
-- sequencia enorme de condicionais cobrindo cada uma das entradas
-- possíveis -- vide os testes! :-p) pedir para o usuário digitar os
-- parâmetros desejados. Veremos como fazer essa conversão do nível
-- dos termos para o nível dos tipos nas próximas listas.


class PPrintable a where
  pprint0 :: String

  pprint :: Proxy a -> String
  pprint _ = pprint0 @a

instance PPrintable AntA where
  pprint0 = "Antigeno A"
instance PPrintable AntB where
  pprint0 = "Antigeno B"
instance PPrintable AntRh where
  pprint0 = "Antigeno Rh"

instance PPrintable A where
  pprint0 = "A"
instance PPrintable B where
  pprint0 = "B"
instance PPrintable AB where
  pprint0 = "AB"
instance PPrintable O where
  pprint0 = "O"

instance PPrintable Pos where
  pprint0 = "+"
instance PPrintable Neg where
  pprint0 = "-"

instance (PPrintable t, PPrintable r) => PPrintable (TipoS t r) where
  pprint0 = pprint0 @t ++ pprint0 @r

instance PPrintable True where
  pprint0 = "True"
instance PPrintable False where
  pprint0 = "False"

instance KnownNat n => PPrintable n where
  pprint0 = show $ natVal (Proxy @n)

instance PPrintable '[] where
  pprint0 = "[]"
instance (PPrintable x, PPrintable xs) => PPrintable (x : xs) where
  pprint0 = pprint0 @x ++ " : " ++ pprint0 @xs
