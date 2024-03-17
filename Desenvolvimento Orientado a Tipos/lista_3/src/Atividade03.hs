{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Atividade03 where
import Data.Char


-- | Exercício 1. Neste primeiro exercício vamos simular a criação de
-- uma máquina de estados e suas possíveis transiçõe com ajuda do
-- sistema de tipos. Vamos modelar uma simples máquina de venda
-- automática. Os possíveis estados da máquina são: Aguardando,
-- InseriuMoeda, ProcessandoPedido e ServindoPedido. Como é uma
-- maquina muito simples as transições possíveis são apenas as
-- listadas abaixo:
--
-- - Aguardando -> InseriuMoeda
-- - InseriuMoeda -> ProcessandoPedido
-- - ProcessandoPedido -> ServindoPedido
--
-- Sua tarefa é implementar a função `transicao` e a função `(|>)` de
-- modo que as funções `insereMoeda`, `escolheProduto`,
-- `entregaPedido` e `finalizaEntrega` estejam corretas.
--
-- Em particular, note que a assinatura da função `(|>)` é muito
-- parecida com a da função `transicao`. Então não reinvente a roda!

data Aguardando
data InseriuMoeda
data ProcessandoPedido
data ServindoPedido

newtype Transicao de para = Transicao (Int -> Int)
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


-- | Exercício 2. Na página da disciplina
-- https://haskell.pesquisa.ufabc.edu.br/desenvolvimento-orientado-a-tipos/03.adts/#tipos-fantasmas-numa-linguagem-não-funcional
-- exploramos como podemos utilizar tipos fantamas em uma linguagem
-- não funcional como Java. Lá mostramos o exemplo de como validar
-- strings usando o sistema de tipos para nos auxiliar. Vemos também
-- que em Java, infelizmente, quando o número de verificações cresce
-- nós acabamos tendo que criar um número quadrático de classes para
-- modelar as validações.
--
-- Em breve (quando estudarmos type families) vamos ver uma solução
-- muito elegante para este problema. Até lá, contudo, os Javeiros nos
-- desafiaram a fazer uma solução melhor do que a solução em Java e
-- sem essas firulas de type-level programming. O desafio é fazer isso
-- usando apenas polimorfismo ad hoc!
--
-- Implemente instancias da classe `CheckStringClass` para as 3
-- possíveis validações abaixo. A saber: `Sanitized`, `Validated` e
-- `Capitalized`.

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

class CheckStringClass a where
  check :: Checker a

-- | Exercício 3. Seu amigo Javeiro está rindo sem parar! Está dizendo
-- na sua cara que você implementou exatamente a mesma ideia que seria
-- feita em Java. Que vantagem você levou em usar Haskell?  Disposto a
-- mostrar pra ele quem é que manda você resolve implementar a versão
-- para 2 validações! Agora sim ele vai ver quem manda!
--
-- Escreva usando o menor número possível de instâncias para a classe
-- `CheckString2Class` um código para que seja possível validar
-- strings usando QUAISQUER dois pares de validações.


newtype CheckedString2 c0 c1 = CheckedString2 String deriving (Show, Eq)

class CheckString2Class a b where
  check2 :: String -> Maybe (CheckedString2 a b)


-- | Exercício 4. Para acabar de vez com a moral do seu colega,
-- escreva instâncias para as clases CheckString3Class e
-- CheckedString4Class que sejam capazes de lidar com quaisquer
-- combinações de verificações escolhidas pelo usuário.

newtype CheckedString3 c0 c1 c2 = CheckedString3 String deriving (Show, Eq)

class CheckString3Class a b c where
  check3 :: String -> Maybe (CheckedString3 a b c)

fullCheck :: String -> Maybe (CheckedString3 Capitalized Validated Sanitized)
fullCheck = check3

newtype CheckedString4 c0 c1 c2 c3 = CheckedString4 String deriving (Show, Eq)

class CheckString4Class a b c d where
  check4 :: String -> Maybe (CheckedString4 a b c d)

main :: IO ()
main =
  putStrLn "Nothing to see here. Move along!"
