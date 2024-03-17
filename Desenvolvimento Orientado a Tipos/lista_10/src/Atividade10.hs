{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE IncoherentInstances #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE StandaloneDeriving #-}

module Atividade10 where

import Data.Kind
import Data.Type.Bool
import Data.Type.Equality

import Data.List

import Data.Proxy

-- Esta primeira parte do arquivo é, basicamente, a resolução da lista
-- 08 que pedia uma implementação no nível dos tipos para as regras de
-- transfusão sanguínea. Mas ela faz algo diferente! Ela implementa
-- tudo no nível dos termos!

-- ATENÇÃO! Os testes desta lista não testam nada! :D A correção dela
-- será manual! Preste atenção para ver seu código compila e escreva
-- os seus próprios testes! Isso será levado em conta na correção e
-- pode até gerar um bônus.

-- Até 1900 não se sabia muito bem porque, às vezes, quando se
-- efetuava uma transfusão de sangue o receptor acabava morrendo e
-- porque as vezes tudo funcionava como esperado. Neste ano Karl
-- Landsteiner, descobriu (descoberta esta que lhe rendeu um Nobel em
-- 1930) que misturar o sangue de algumas pessoas, em alguns casos,
-- causava uma forte reação que resultava na destruição das hemácias
-- (glóbulos vermelhos) além de formação de coágulos. Após diversos
-- experimentos Karl encontrou três tipos de sangue chamados de A, B e
-- O. Alguns anos depois também foi descoberto o tipo AB, dando origem
-- à classificação ABO de sangue que usamos até hoje. O ADT `TipoABO`,
-- definido abaixo, representa esses 4 tipos sanguíneos:
--
data TipoABO = A | B | AB | O deriving (Show, Eq)
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
data Antigeno = AntA | AntB | AntRh deriving (Show, Eq)
data FatorRh = Pos | Neg deriving Eq
instance Show FatorRh where
  show Pos = "+"
  show Neg = "-"

--
-- Como nesta disciplina estamos interessados em verificar tudo no
-- nível dos tipos, enxergue as definições acima promovidas, ou seja,
-- temos os kinds `TipoABO`, `Antigeno` e `FatorRh` com os seus
-- respectivos tipos. Desta maneira podemos definir `TipoSanguineo`
-- como abaixo e em seguida definir um sinônimo para cada um dos
-- possíveis tipos sanguíneos:
--
data TipoSanguineo where
  TipoS :: TipoABO -> FatorRh -> TipoSanguineo
deriving instance Eq TipoSanguineo
instance Show TipoSanguineo where
  show (TipoS t r) = show t ++ show r

sAP, sAN, sBP, sBN, sABP, sABN, sOP, sON :: TipoSanguineo
sAP  = TipoS A  Pos
sAN  = TipoS A  Neg
sBP  = TipoS B  Pos
sBN  = TipoS B  Neg
sABP = TipoS AB Pos
sABN = TipoS AB Neg
sOP  = TipoS O  Pos
sON  = TipoS O  Neg
--
-- A função `tipoTemAntigenos` recebe um valor TipoABO devolve uma
-- lista dos antígenos que o sangue daquele tipo com certeza possui.
tipoTemAntigenos :: TipoABO -> [Antigeno]
tipoTemAntigenos A  = [AntA]
tipoTemAntigenos B  = [AntB]
tipoTemAntigenos AB = [AntA, AntB]
tipoTemAntigenos O  = []

-- A função `fatorRhTemAntigeno` recebe um `FatorRh` e devolve
-- uma lista com os antígenos que aquele sangue com certeza possúi.
fatorRhTemAntigeno :: FatorRh -> [Antigeno]
fatorRhTemAntigeno Pos = [AntRh]
fatorRhTemAntigeno Neg = []

-- A função `tipoTemAnticorposPara` recebe um `TipoABO` e devolve
-- uma lista com os anticorpos que aquele sangue com certeza possúi.
tipoTemAnticorposPara :: TipoABO -> [Antigeno]
tipoTemAnticorposPara A  = [AntB]
tipoTemAnticorposPara B  = [AntA]
tipoTemAnticorposPara AB = []
tipoTemAnticorposPara O  = [AntA, AntB]

-- As funções `podeDoarPara` e `podeReceberDe` recebem o
-- `TipoSanguineo`s do doador e receptor/receptor e doador e devolve
-- um booleano indicando se a doação é possível ou não. Consulte a
-- descrição dos doadores compatíveis no comentário do tipo `TipoABO`.
podeDoarPara :: TipoSanguineo -> TipoSanguineo -> Bool
podeDoarPara (TipoS dt dr) (TipoS rt rr) =
    null (tipoTemAnticorposPara rt `intersect` tipoTemAntigenos dt) &&
    (dr == Neg || rr == Pos)

podeReceberDe :: TipoSanguineo -> TipoSanguineo -> Bool
podeReceberDe r d = podeDoarPara d r

-- As funções `getTipoABO`, `getFatorRh`, e `getTipoSanguineo`
-- recebem uma lista de antígenos presentes no sangue e devolvem o
-- tipo, fator e tipo sanguineo.
achaTipo :: [TipoABO] -> [Antigeno] -> TipoABO
achaTipo ~(x : xs) as
  | tipoTemAntigenos x == as = x
  | otherwise                = achaTipo xs as

antigenosRelevantesParaTipagemABO = [AntA, AntB]

getTipoABO :: [Antigeno] -> TipoABO
getTipoABO as = achaTipo [A, B, AB, O] (antigenosRelevantesParaTipagemABO `intersect` as)

getFatorRh :: [Antigeno] -> FatorRh
getFatorRh []       = Neg
getFatorRh (x : xs)
  | x == AntRh = Pos
  | otherwise  = getFatorRh xs

getTipoSanguineo :: [Antigeno] -> TipoSanguineo
getTipoSanguineo xs = TipoS (getTipoABO xs) (getFatorRh xs)

-- ===================================================================
-- ===================================================================
-- ===================================================================

-- | Exercício 1. Crie um singleton type para o tipo Antigeno. A
-- assinatura é dada abaixo.

type SAntigeno :: Antigeno -> Type
data SAntigeno a where
  -- Sua implementação aqui

-- | Exercício 2. A biblioteca singletons faz uma boa ginástica
-- utilizando data families para unificar a interface do singletons
-- gerados para ser simplesmente as funções `fromSing` e `toSing`.
-- Aqui, para facilitar, vamos criar uma função específica para cada
-- singleton type. Crie a função `fromSingAntigeno`, cuja assinatura é
-- dada abaixo, que dado um singleton de um antígeno devolve um
-- `Antigeno`.

fromSingAntigeno :: SAntigeno k -> Antigeno
fromSingAntigeno = undefined

-- | Exercício 3. Crie um tipo existencial para o singleton type de
-- Antigeno. A assinatura já e dada abaixo.
data SomeSAntigeno where
  SomeSAntigeno :: -- Sua implementação aqui

-- | Exercício 4. Crie uma função eliminadora `withSomeSAntigeno` cuja
-- assinatura está dada abaixo.
withSomeSAntigeno :: SomeSAntigeno -> (forall a. SAntigeno a -> b) -> b
withSomeSAntigeno = undefined

-- | Exercício 5. Crie a função `toSingAntigeno` cuja assinatura está
-- dada abaixo. Essa função reifica o tipo antígeno.
toSingAntigeno :: Antigeno -> SomeSAntigeno
toSingAntigeno undefined

-- | Exercício 6. Para representar de maneira segura uma lista de
-- antígenos, vamos precisar de um singleton type para `[Antigeno]`.
-- Podemos fazer isso com um GADT recursivo que guarda algumas
-- similaridades com o GADT que usamos para Nat. O esqueleto de tal
-- singleton é dado abaixo. Complete a sua definição.
type SAntigenoList :: [Antigeno] -> Type
data SAntigenoList as where
    -- Sua implementação aqui

-- | Exercício 7. Implemente a função `fromSingAntigeno` que devolve
-- um `[Antigeno]` a partir de um singleton de lista de antigenos. A
-- assinatura da função é dada abaixo.
fromSingAntigenoList :: SAntigenoList xs -> [Antigeno]
fromSingAntigenoList = undefined

-- | Exercício 8. Implemente um tipo existencial para o tipo
-- SAntigenoList. A assinatura é dada abaixo.
data SomeSAntigenoList where
    -- Sua implementação aqui

-- | Exercício 9. Implemente a função eliminadora
-- `withSomeSAntigenoList` para o tipo existencial `SomeSAntigenoList`
withSomeSAntigenoList :: SomeSAntigenoList -> (forall a. SAntigenoList a -> b) -> b
withSomeSAntigenoList = undefined

-- A função `toSingAntigenoList` reifica o tipo [Antigeno].
toSingAntigenoList :: [Antigeno] -> SomeSAntigenoList
toSingAntigenoList [] = SomeSAntigenoList SANil
toSingAntigenoList (x:xs) =
  withSomeSAntigeno (toSingAntigeno x) $ \ sa ->
  withSomeSAntigenoList (toSingAntigenoList xs) $ \sas ->
      SomeSAntigenoList $ SCons sa sas

-- | Exercício 10. Implemente o singleton type, o tipo existencial, e
-- as funções relacionadas para o tipo `TipoABO` cujas assinaturas são
-- dadas abaixo.

type STipoABO :: TipoABO -> Type
data STipoABO t where
     -- Sua implementação aqui

fromSingTipoABO :: STipoABO t -> TipoABO
fromSingTipoABO = undefined 

data SomeSTipoABO where
    -- Sua implementação aqui

withSomeSTipoABO :: SomeSTipoABO -> (forall t. STipoABO t -> a) -> a
withSomeSTipoABO = undefined 

toSingTipoABO :: TipoABO -> SomeSTipoABO
toSingTipoABO = undefined 

-- | Exercício 11. Implemente o singleton type, o tipo existencial, e
-- as funções relacionadas para o tipo `FatorRh` cujas assinaturas são
-- dadas abaixo.

type SFatorRh :: FatorRh -> Type
data SFatorRh f where
    -- Sua implementação aqui

fromSingFatorRh :: SFatorRh f -> FatorRh
fromSingFatorRh = undefined 

data SomeSFatorRh where
    -- Sua implementação aqui

withSomeSFatorRh :: SomeSFatorRh -> (forall f. SFatorRh f -> a) -> a
withSomeSFatorRh = undefined 

toSingFatorRh :: FatorRh -> SomeSFatorRh
toSingFatorRh = undefined 

-- | Exercício 12. Implemente o singleton type, o tipo existencial, e
-- as funções relacionadas para o tipo `TipoSanguineo`

type STipoSanguineo :: TipoABO -> FatorRh -> Type
data STipoSanguineo t r where
     -- Sua implementação aqui

fromSingTipoSanguineo :: STipoSanguineo t f -> TipoSanguineo
fromSingTipoSanguineo = undefined 

data SomeSTipoSanguineo where
     -- Sua implementação aqui

withSomeSTipoSanguineo :: SomeSTipoSanguineo -> (forall (t :: TipoABO) (r :: FatorRh). STipoSanguineo t r -> a) -> a
withSomeSTipoSanguineo = undefined 

toSingTipoSanguineo :: TipoSanguineo -> SomeSTipoSanguineo
toSingTipoSanguineo (TipoS t r) = undefined 
