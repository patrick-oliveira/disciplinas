{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}

{-# OPTIONS_GHC -Wno-unticked-promoted-constructors #-}

module Atividade07 (validate) where

import Data.Kind
import Data.Proxy
import Data.Typeable

-- Nessa lista de exercício vamos trabalhar com tipos
-- representando diversos tipos de delimitadores.
-- Inicialmente fornecemos os tipos relativos a "()" e "{}"
-- Com a implementação dessa lista, criaremos um GADT
-- que armazenará a informação de empilhamento desses
-- símbolos em seu tipo. Após isso, criaremos um mecanismo
-- para validar uma string verificando se o fechamento
-- de cada delimitador corresponde a abertura de seu análogo.

-- Nota: o programa só irá compilar ao terminar
-- a implementação dos cinco primeiros exercícios.



-- Delim especifica os tipos e kinds dos diferentes
-- tipos de delimitadores. O sufixo O representa abertura
-- (opening) e o sufixo C representa fechamento (closing)
data Delim = ParenO | ParenC | CurlyO | CurlyC

-- A estrutura Either4 servirá como auxiliar para
-- identificarmos o tipo carregado por um Proxy
data Either4 a b c d = A a | B b | C c | D d | None
type EitherDelim = Either4 (Proxy ParenO) (Proxy ParenC)
                           (Proxy CurlyO) (Proxy CurlyC)

-- Cada caractere deve casar com o tipo que
-- ele deve representar.
-- Praticamente todo o nosso programa está amarrado com tipos.
-- Isso nos dá a segurança que eventuais erros de implementação
-- serão pegos durante a compilação e que não explodirão durante
-- a execução. Contudo, ainda é preciso existir uma interface
-- que faça o meio de campo entre os valores
-- (disponíveis apenas durante a execução) e os tipos
-- (disponíveis durante a compilação).
-- A função sDelimFromChar é uma função que faz este papel.
-- Logo ela é um ponto crítico, onde possíveis falhas podem se esconder.
-- Por exemplo, seria fácil digitar um caractere errado ou ainda devolver
-- o Proxy com o tipo incorreto. Esta  função é, portanto,
-- uma seríssima candidata a ter seus próprios testes de unidade
-- para assegurar que ela está efetivamente se comportando como esperado.
sDelimFromChar :: Char -> EitherDelim
sDelimFromChar = \ case
  '(' -> A $ Proxy @ParenO
  ')' -> B $ Proxy @ParenC
  '{' -> C $ Proxy @CurlyO
  '}' -> D $ Proxy @CurlyC
  _   -> None

-- Exercício 01: Implemente o type family
-- PairOf que recebe um tipo Delim e retorna
-- o seu correspondente. Ou seja, o tipo
-- representando "(" deve retornar o tipo
-- representando ")" e vice-versa.
type PairOf :: Delim -> Delim
type family PairOf ...

-- Opening é uma restrição de tipo
-- que marca quais delimitadores são de abertura.
-- Podemos pensar nela como uma classe de tipos
-- que não possui implementação. Portanto, basta
-- indicar uma `instance` do tipo que quer que ela pertença.
type Opening :: Delim -> Constraint
class Typeable d => Opening d
instance Opening ParenO
instance Opening CurlyO

-- Marca quais delimitadores são fechamento
type Closing :: Delim -> Constraint
class Typeable d => Closing d
instance Closing ParenC
instance Closing CurlyC

-- A GADT Stack representa uma pilha indutiva!
-- Ela é similar a nossa lista heterogênea, porém
-- ela não guarda nenhum valor, apenas tipos!
--
-- Stack (Stack EmptyStack) :: Stack [ParenC, ParenO]
-- representa uma pilha equivalente a "()"
-- Note que a lista de tipos armazena na ordem reversa, pois é uma pilha.
type Stack :: [Delim] -> *
data Stack ds where
  EmptyStack :: Stack '[]
  Stack :: Typeable x => Stack xs -> Stack (x ': xs)

-- Mesmo sem guardar valores, podemos
-- calcular o tamanho de nossa pilha de forma
-- análoga a uma lista.
stackSize :: Stack ds -> Int
stackSize EmptyStack = 0
stackSize (Stack s)  = 1 + stackSize s

-- Exercício 02: Em algum momento estaremos limitados
-- em como trabalhar com nossa pilha e
-- precisaremos esquecer os seus tipos.
-- Crie uma pilha existencial com um construtor de nome SomeStack.
type SomeStack :: ...
data SomeStack where
    SomeStack :: ...

-- Para trabalhar com pilhas existenciais é interessante
-- criar uma função `withStack` que facilita a aplicação
-- de funções dentro da nossa pilha.
withStack :: SomeStack -> (forall xs. Stack xs -> a) -> a
withStack (SomeStack s) f = f s

-- Exercício 03: crie a função que empilha um delimitador do tipo
-- opening. Note que sempre que temos um tipo da classe Opening,
-- podemos empilhar sem restrições.
-- Repare que na assinatura retornamos um Maybe Stack para manter
-- compatibilidade com a função `close`.
open :: Opening o => Proxy o -> Stack xs -> Maybe (Stack (o ': xs))
open = undefined

-- Exercício 04: crie uma função que empilha o
-- fechamento de parênteses. Nesse caso, precisamos
-- garantir que o fechamento corresponde a uma abertura.
-- A assinatura da função deve ser lida como:
--
-- Para quaisquer tipos c, o, xs
-- c é da classe Closing, o par de  c é um typeable
-- recebemos um Proxy do tipo Proxy c, uma pilha não vazia
-- contendo um tipo `o` no topo e um resto de tipos `xs`
-- e, se tudo der certo, retornamos um `Stack xs`, ou seja,
-- desempilhamos o tipo `o` pois casava com o tipo `c`.
-- Para facilitar, utilizem a função `cast` que, no nosso caso,
-- recebe um `Proxy` com nosso tipo `o` e, se casar com o tipo
-- esperado (`PairOf c`), ele retorna um `Just`, caso contrário
-- retorna `Nothing`.
-- Por exemplo, ao fazer:
-- cast (Proxy @ParensO) :: Maybe (Proxy (PairOf ParensC))
-- ele retorna `Just Proxy`.
-- cast (Proxy @CurlyO) :: Maybe (Proxy (PairOf ParensO))
-- retorna Nothing.
close :: forall c o xs.
         (Closing c, Typeable (PairOf c)) =>
         Proxy c -> Stack (o ': xs) -> Maybe (Stack xs)
close = undefined


-- Exercício 05: implemente a função `fromChar`
-- que dado um caractere e um `SomeStack`,
-- retorna um `Maybe SomeStack` que retorna
-- `Just stack` caso seja possível empilhar o
-- caractere, ou `Nothing` caso contrário.
-- Note que aqui precisamos envolver nossa pilha
-- em `SomeStack` pois não temos como determinar
-- um tipo de saída.
-- Dica: utilize `sDelimFromChar` para validar
-- os tipos e o `withStack` para deixar o código mais
-- limpo.
fromChar :: Char -> SomeStack -> Maybe SomeStack
fromChar = undefined

fromString :: String -> Maybe SomeStack
fromString = foldl (\mss c -> fromChar c =<< mss) (Just $ SomeStack EmptyStack)

isValid :: SomeStack -> Bool
isValid st0 = 0 == withStack st0 stackSize

validate :: String -> Bool
validate = maybe False isValid . fromString

-- Exercício 06:
-- transforme a família de tipos PairOf em
-- open type family e adicione suporte ao
-- colchetes.
-- Responda: o que mais precisaria ser
-- feito para facilitar a manutenção do código
-- caso um usuário precise acrescentar novos
-- caracteres.
