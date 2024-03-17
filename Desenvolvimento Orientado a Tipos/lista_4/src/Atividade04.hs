{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unticked-promoted-constructors #-}

module Atividade04 where

import Data.Char
import Data.Kind
import Data.Set (Set)
import qualified Data.Set as Set


-- | Exercício 0. Essa lista de exercícios se baseia na sua
-- implementação da lista anterior. Antes de começar os demais
-- exercícios, preencha toda a implementação do código que falta (que
-- você já entregou ou deveria ter entregue na lista anterior!). Note
-- que diferentemente das listas anteriores, esta lista passará por
-- uma etapa manual de correção pois os testes NÃO cobrem tudo o que
-- precisa ser feito. Então leia os enunciados com atenção!


-- | Exercício 1. Tal qual o código foi feito na lista anterior,
-- qualquer um poderia criar um novo estado em qualquer parte do
-- código e usar como um novo estado para a máquina de vendas. Não
-- apenas isso, mas também permitia que alguém inadvertidamente
-- criasse uma `MaquinaDeVenda Float` que obviamente não faz sentido
-- algum. Nós queremos nesta lista restringir a lista de estados
-- válidos para que não haja nenhuma supresa no código. Altere as
-- definições para os possíveis estados da máquina de vendas (já
-- existentes na lista anterior) para que formem um novo Kind chamado
-- Estado. Este novo kind deve ter 4 tipos diferentes representando
-- cada um dos estados possíveis.

data Aguardando
data InseriuMoeda
data ProcessandoPedido
data ServindoPedido


-- | Exercício 2. A definição para o tipo Transicao (dada na lista 03)
-- foi ligeiramente alterada. Agora, ela tem uma anotação de tipos que
-- nos permite declarar com precisão o que aceitamos como parâmetors
-- no construtor de tipos Transicao. Altere a anotação de tipos abaixo
-- para que ela fique compatível com os novos tipos do kind Estado
-- definido no exercício anterior.

type Transicao :: Type -> Type -> Type
newtype Transicao de para = Transicao (Int -> Int)


-- | Exercício 3. Adicione uma anotação de tipos para MaquinaDeVenda
-- que permita apenas tipos do kind Estado como parâmetro.

newtype MaquinaDeVenda estado = MaquinaDeVenda Int deriving (Eq, Show)

transicao :: Transicao estadoAtual novoEstado -> MaquinaDeVenda estadoAtual -> MaquinaDeVenda novoEstado
transicao t m = undefined

(|>) :: MaquinaDeVenda estadoAtual -> Transicao estadoAtual novoEstado -> MaquinaDeVenda novoEstado
(|>) = undefined

insereMoeda :: Transicao Aguardando InseriuMoeda
insereMoeda = Transicao id

escolheProduto :: Transicao InseriuMoeda ProcessandoPedido
escolheProduto = Transicao id

entregaPedido :: Transicao ProcessandoPedido ServindoPedido
entregaPedido = Transicao id

finalizaEntrega :: Transicao ServindoPedido Aguardando
finalizaEntrega = Transicao (+1)



-- | Exercício 5. Assim como nos exercícios anteriores, o tipo
-- CheckedString aceita como parâmetro qualquer tipo. Nada nos impede,
-- por exemplo, de criarmos um `CheckedString [Float]` (seja lá o que
-- for isso). O mesmo ocorre para o tipo `Checker` que aceita qualquer
-- parâmetro de tipo e para a classe CheckStringClass que atualmente
-- não tem restrições sobre que tipos podem se tornar suas
-- instancias. Adicione anotações de tipos em todos os locais que
-- forem necessários para que seja impossível:
--
-- (a) criar uma abominação como `CheckedString [Float]`
-- (b) uma bizarrice como `Check Double`
-- (c) instâncias sem sentido de CheckStringClass
--
-- Adapte o código em todos os locais que forem necessários. Todas as
-- validações existentes devem continuar a funcionar e permanecer
-- coerentes. Dica: siga os mesmos passos dos exercícios 1-4.

newtype CheckedString c = CheckedString String deriving (Show, Eq)
type Checker c = String -> Maybe (CheckedString c)

data Sanitized
sanitizeString :: Checker Sanitized
sanitizeString = Just . CheckedString . ("<SANITIZED>" ++) . (++ "</SANITIZED>")

data Validated
validateString :: Checker Validated
validateString = Just . CheckedString . ("<VALIDATED>" ++) . (++ "</VALIDATED>")

data Capitalized
capitalizeString :: Checker Capitalized
capitalizeString = Just . CheckedString . map toUpper

data AllCaps
isAllCaps :: Checker AllCaps
isAllCaps s =
  case filter isLower s of
    [] -> Just $ CheckedString s
    _  -> Nothing

class CheckStringClass a where
  check :: Checker a

-- | Exercício 6. Você achou que tinha acabado? Repita o processo para
-- as versões com 2, 3 e 4 checagens.

newtype CheckedString2 c0 c1 = CheckedString2 String deriving (Show, Eq)

class CheckString2Class a b where
  check2 :: String -> Maybe (CheckedString2 a b)

newtype CheckedString3 c0 c1 c2 = CheckedString3 String deriving (Show, Eq)

class CheckString3Class a b c where
  check3 :: String -> Maybe (CheckedString3 a b c)

fullCheck :: String -> Maybe (CheckedString3 Capitalized Validated Sanitized)
fullCheck = check3

newtype CheckedString4 c0 c1 c2 c3 = CheckedString4 String deriving (Show, Eq)

class CheckString4Class a b c d where
  check4 :: String -> Maybe (CheckedString4 a b c d)


-- | Exercício 7. Nas nossas notas de aula
-- https://haskell.pesquisa.ufabc.edu.br/desenvolvimento-orientado-a-tipos/04.kinds/#o-kind-constraint
-- criamos uma nova versão de functor, chamada FunctorPlus, que
-- permitiu que criássemos uma instância (com quase exatamente o mesmo
-- comportamento do Functor padrão) tanto para listas comuns como para
-- tipos que não possuiam (e não poderiam ter) uma instância de
-- Functor como ListaShow e Set. Neste exercício vamos dar um passo
-- adiante para criar uma classe FunctorPlus2 que seja capaz de lidar
-- com duas restrições ao mesmo tempo. Crie a classe FunctorPlus2 com
-- um único método `fmaplus2` e defina instancias de FunctorPlus2 para
-- os mesmos tipos que já têm uma instância de FunctorPlus, ou seja,
-- `[]`, `Set` e `ListaShow`.

data ListaShow a where
  ListaShow :: Show a => [a] -> ListaShow a
deriving instance Show (ListaShow a)

mapListaShow :: Show b => (a -> b) -> ListaShow a -> ListaShow b
mapListaShow f (ListaShow xs) = ListaShow (fmap f xs)

type FunctorPlus :: (Type -> Constraint) -> (Type -> Type) -> Constraint
class FunctorPlus c f | f -> c where
  fmaplus :: c b => (a -> b) -> f a -> f b

class NullConstraint a
instance NullConstraint a

instance FunctorPlus NullConstraint [] where
  fmaplus = fmap

instance FunctorPlus Show ListaShow where
  fmaplus = mapListaShow

instance FunctorPlus Ord Set where
  fmaplus = Set.map


-- | Exercício 8: O tipo ListaDeNumerosOrdenaveis é um tipo de lista
-- aceita apenas números que guardam entre si uma relação de
-- ordem. Você pode estar se pergutando: "Ué? Dados dois números a e
-- b, não podemos sempre estabelecer uma ordem para dizer se a < b,
-- a = b, ou se a > b?" Não! Os números complexos não tem relação de
-- ordem!  Este tipo, assim como Set e ListaShow, não é apropriados
-- para criarmos uma instância de Functor tal qual definida pela
-- biblioteca padrão. Crie uma instância de FunctorPlus2 para o tipo
-- ListaDeNumerosOrdenaveis.

data ListaDeNumerosOrdenaveis a where
  LDNO :: (Ord a, Num a) => [a] -> ListaDeNumerosOrdenaveis a
deriving instance Eq (ListaDeNumerosOrdenaveis a)
deriving instance Show a => Show (ListaDeNumerosOrdenaveis a)
