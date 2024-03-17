{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE ConstraintKinds #-}

module Atividade02 where

import Prelude hiding (Real)
import Data.Proxy ( Proxy(..) )
import Text.Printf ( printf )
import Data.Maybe

------------
-- Moedas --
------------

-- | Aqui temos tipos que não contém valor algum!
-- A utilidade deles é apenas marcar qual moeda estamos trabalhando.
data Real
data Dolar
data Euro
data Libra
data Rupia

-- | A Classe Moeda representa todo tipo que
-- é uma moeda. Podemos extrair a sigla e o fator
-- de conversão pro Dólar.
class Moeda m where
  sigla :: String
  fatorDolar :: Double

-- | Vamos criar as instâncias para cada moeda
-- que estamos trabalhando.
instance Moeda Real where
  sigla = "R$"
  fatorDolar = 0.1831

instance Moeda Dolar where
  sigla = "US$"
  fatorDolar = 1.0

instance Moeda Euro where
  sigla = "€"
  fatorDolar = 1.1311

instance Moeda Libra where
  sigla = "£"
  fatorDolar = 1.3299

instance Moeda Rupia where
  sigla = "₹"
  fatorDolar = 0.0134


-------------
-- Valores --
-------------

-- | Envolvemos o tipo Double dentro de Valor
-- para contextualizarmos com o que estamos trabalhando.
--
-- Derivamos a classe Num para podermos fazer:
-- `MkValor x + MkValor y`
newtype Valor m = MkValor Double deriving Num

-- | Para mostrar uma moeda, precisamos usar TypeApplications
-- para definir que instância de sigla devemos utilizar.
instance Moeda m => Show (Valor m) where
  show (MkValor v) = sigla @m ++ " " ++  printf "%.2f" v



-- ===================================================================
-- ===================================================================
-- ===================================================================

-- | Exercício 01: implemente a função `converteValor`
-- que converte a moeda v0 do tipo m0 para um valor do
-- tipo m1.
--
-- É necessário manter o `forall m0 m1` na assinatura
-- para indicar que precisaremos manter esses tipos
-- dentro do escopo da função.
converteValor :: forall m0 m1. (Moeda m0, Moeda m1) =>
                 Valor m0 -> Valor m1
converteValor (MkValor v0) = undefined

-- ===================================================================
-- ===================================================================
-- ===================================================================



-- ===================================================================
-- ===================================================================
-- ===================================================================

-- | Exercício 02: implemente a função `somaValoresEmDolar`
-- que recebe dois valores em moedas diferentes e retorna o
-- valor em dólar. Reflita o pq não precisarmos colocar
-- as variáveis em escopo com `forall`.
somaValoresEmDolar :: (Moeda m, Moeda n) => Valor m -> Valor n -> Valor Dolar
somaValoresEmDolar v0 v1 = undefined

-- ===================================================================
-- ===================================================================
-- ===================================================================

----------------
-- Transacoes --
----------------

-- | Tipo soma com as duas possíveis operações.
data Operacao = Debito | Credito deriving Enum

-- | Função auxiliar para saber se estamos retirando
-- dinheiro da conta ou colocando.
sinalOperacao :: Num a => Operacao -> a
sinalOperacao Debito  = -1
sinalOperacao Credito = 1

-- | O tipo Transacao descreve a conta de um cliente como
-- uma sequência de transações partindo de um saldo inicial
-- com valor 0.
--
-- A parte mais externa da estrutura representará a transação
-- mais recente:
--
-- MkTrans (Valor 3) (MkTrans (Valor 5) MkTrans0) representa que a
-- conta inicia com 0, foram depositados 5 unidades da moeda e,
-- depois, depositaram mais 3 unidades, totalizando 8 unidades.  Note
-- que é impossível encadear duas transações com moedas diferentes.
data Transacao m = MkTrans0 | MkTrans (Valor m) (Transacao m)

------------
-- Contas --
------------

-- | Vamos criar uma conta corrente
type ContaCorrente = Transacao



-- ===================================================================
-- ===================================================================
-- ===================================================================

-- | Exercício 03: Dada uma ContaCorrente contendo valores
-- na moeda `m`, calcule o saldo total dessa conta.
saldoContaCorrente :: ContaCorrente m -> Valor m
saldoContaCorrente  = undefined

-- ===================================================================
-- ===================================================================
-- ===================================================================



-- Podemos criar um apelido para restrições de classe de tipos com a
-- palavra-chave `type` (isso exige a extensão ConstraintKinds)
-- Portanto, `Moedas m0 m1 m2` representa a restrição que os tipos m0,
-- m1, m2 são da classe Moeda.
type Moedas m0 m1 m2 = (Moeda m0, Moeda m1, Moeda m2)

-- | A conta bancária de um cliente pode ter até 3 contas corrente
-- de moedas diferentes.
data ContaBancaria m0 m1 m2 = MkContaBancaria (ContaCorrente m0) (ContaCorrente m1) (ContaCorrente m2)


-- ===================================================================
-- ===================================================================
-- ===================================================================

-- | Exercício 04: Crie uma função `mkContaBancaria`que inicializa uma
-- conta bancária para um novo cliente. Em seguida, crie a função
-- `saldoContas` que calcula o saldo atual na conta de um cliente.
mkContaBancaria :: Moedas m0 m1 m2 => Proxy m0 -> Proxy m1 -> Proxy m2 -> ContaBancaria m0 m1 m2
mkContaBancaria _ _ _ = undefined


saldoContas :: Moedas m0 m1 m2 =>
               ContaBancaria m0 m1 m2 -> (Valor m0, Valor m1, Valor m2)
saldoContas  (MkContaBancaria cc1 cc2 cc3) = undefined


-- ===================================================================
-- ===================================================================
-- ===================================================================


-- | `sumarioConta` mostra o total na conta do cliente convertido em dólares.
sumarioConta :: Moedas m0 m1 m2 => ContaBancaria m0 m1 m2 -> String
sumarioConta cc =
  unlines [show vs, "Total: " ++ show (somaValoresEmDolar (somaValoresEmDolar v0 v1) v2)]
  where
   vs@(v0, v1, v2) = saldoContas cc



-- ===================================================================
-- ===================================================================
-- ===================================================================

-- | Exercício 05: crie uma função `processaTransacao` que recebe como
-- argumentos uma conta bancária e um valor. Você deve verificar quais
-- das três contas correntes do cliente possui a mesma moeda do valor
-- de entrada e efetuar a transação naquela conta.  Caso nenhuma delas
-- seja da mesma moeda do depósito, você deve dividir o valor em três,
-- converter essas partes para a moeda de cada conta e distribuir
-- entre elas.
--
-- Ex.:
--
-- conta = MkContaBancaria MkTrans0 MkTrans0 MkTrans0 :: ContaBancaria Real Dolar Rupia
-- conta1 = processaTransacao conta (MkValor 10 :: Valor Real)
-- > MkContaBancaria (MkTrans (MkValor 10) MkTrans0) MkTrans0 MkTrans0
--
-- conta2 = processaTransacao conta1 (MkValor 5 :: Valor Rupia)
-- > MkContaBancaria (MkTrans (MkValor 10) MkTrans0) MkTrans0 (MkTrans (MkValor 5) MkTrans0)
--
-- cont3 = processaTransacao conta2 (MkValor 9 :: Valor Euro)
-- > MkContaBancaria (MkTrans (MkVAlor 18.53) (MkTrans (MkValor 10) MkTrans0)) (MkTrans (MkValor 3.39) MkTrans0) (MkTrans (MkValor 253.23) (MkTrans (MkValor 5) MkTrans0))
processaTransacao :: forall m0 m1 m2 mValor. (Moedas m0 m1 m2, Moeda mValor) =>
                     ContaBancaria m0 m1 m2 -> Valor mValor -> ContaBancaria m0 m1 m2
processaTransacao (MkContaBancaria cc0 cc1 cc2) (MkValor vFloat) = undefined

-- ===================================================================
-- ===================================================================
-- ===================================================================


-----------------------------
-- Carregamento da entrada --
-----------------------------

-- | Vamos construir um Either5 que guarda o valor de um entre 5 tipos
data Either5 a b c d e = One a | Two b | Three c | Four d | Five e

-- | E, com isso, podemos definir AlgumValor como um dentre as 5 moedas que consideramos
type AlgumValor = Either5 (Valor Real) (Valor Dolar) (Valor Euro) (Valor Libra) (Valor Rupia)



-- ===================================================================
-- ===================================================================
-- ===================================================================

-- | Exercício 06: Que recebe uma conta bancária e uma moeda dentro do
-- tipo AlgumValor. Essa função vai então aplicar a função
-- processaTransacao na conta bancária e no valor associado ao
-- AlgumValor.
processaAlgumValor :: forall m0 m1 m2. Moedas m0 m1 m2 =>
                      ContaBancaria m0 m1 m2 ->
                      AlgumValor ->
                      ContaBancaria m0 m1 m2
processaAlgumValor cc av = undefined

-- ===================================================================
-- ===================================================================
-- ===================================================================



-- ===================================================================
-- ===================================================================
-- ===================================================================

-- | Exercício 07: Crie uma função linhaComoValor que recebe uma String
-- composta de 3 palavras:
--
-- - Uma String "D" ou "C" representando a operação de débito ou crédito
-- - Uma String com a sigla da moeda
-- - Uma String contendo o valor
--
-- A saída da função deve ser um Maybe AlgumValor, se a string da
-- sigla da moeda corresponder a uma das moedas conhecidas devemos
-- retornar `Just valor`, caso contrário `Nothing`
--
-- Exemplos:
--
-- linhaComoValor "C R$ 10"
-- > Just (One (MkValor 10)) :: Maybe AlgumValor
--
-- linhaComoValor "D US$ 5"
-- > Just (Two (MkValor (-5))) :: Maybe AlgumValor
--
-- linhaComoValor "C ¥ 10"
-- Nothing :: Maybe AlgumValor
linhaComoValor :: String -> Maybe AlgumValor
linhaComoValor str = undefined

-- ===================================================================
-- ===================================================================
-- ===================================================================



-- ===================================================================
-- ===================================================================
-- ===================================================================

-- | Exercício 08: A função linhaComoValor é muito parecida com o par de
-- funções converteUsuario e aplicaPara. Ela recebe uma string e
-- devolve um valor de um tipo diferente a depender do conteúdo da
-- string.
--
-- Veja a implementação de converteUsuario e aplicaPara aqui:
-- https://haskell.pesquisa.ufabc.edu.br/desenvolvimento-orientado-a-tipos/02.tipos/#polimorfismo-ad-hoc
--
-- Naquelas funções, utilizando proxies e a higher rank polymorphism,
-- nós fomos capazes de fugir do uso de um Either5 para cuidar de cada
-- uma das unidades e devolver a resposta desejada diretamente.
--
-- Explique a razão pela qual essas mesmas técnicas não funcionam no
-- contexto da função linhaComoValor. Qual é o problema que você
-- enfrenta caso tente implementar essa função com higher rank types?


processaLinhas :: Moedas m0 m1 m2 => ContaBancaria m0 m1 m2 ->
                                     [String] ->
                                     ContaBancaria m0 m1 m2
processaLinhas cc lns =
  foldl processaAlgumValor cc algunsValores
  where
    algunsValores = catMaybes $ linhaComoValor <$> lns

-- ===================================================================
-- ===================================================================
-- ===================================================================



-- ===================================================================
-- ===================================================================
-- ===================================================================

-- | Exercício 09: para pensar: do jeito que o tipo Valor está implementado agora
-- é possível criar um valor do tipo Valor que não é uma Moeda?

-- ===================================================================
-- ===================================================================
-- ===================================================================


---------------------
-- Main, te achei! --
---------------------

main :: IO ()
main = do
  input <- lines <$> readFile "test/input.txt"
  let cc1  = mkContaBancaria (Proxy @Real)  (Proxy @Dolar) (Proxy @Libra)
      cc2  = mkContaBancaria (Proxy @Dolar) (Proxy @Real)  (Proxy @Libra)
      cc3  = mkContaBancaria (Proxy @Rupia) (Proxy @Libra) (Proxy @Euro)

  putStrLn $ sumarioConta (processaLinhas cc1 input)
  putStrLn $ sumarioConta (processaLinhas cc2 input)
  putStrLn $ sumarioConta (processaLinhas cc3 input)
