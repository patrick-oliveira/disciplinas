{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Atividade06 where

import GHC.TypeNats
import Data.Proxy
import Data.Kind
import Data.Type.Equality


-- | Exercício 1. Na lista de exercícios anterior nós definimos o tipo
-- `SizedList` que nada mais é do que uma lista de valores com tamanho
-- codificado no tipo. Isso nos dava seguranças adicionais no código
-- já que podíamos especificar claramente que uma funçao devolvia ou
-- recebia uma lista de um determinado tamanho, e este número de
-- elementos era garantido pelo compilador.
--
-- Na lista anterior, contudo, utilizamos números de Peano para
-- codificar o comprimento das listas. Altere a definição da lista com
-- tamanho que você fez na lista de exercícios passada para que passe
-- a utilizar os naturais no nível dos tipos disponibilizados pelo
-- próprio compilador. Veja a página da disciplina aqui:
--
-- https://haskell.pesquisa.ufabc.edu.br/desenvolvimento-orientado-a-tipos/05.gadts/#finalmente-indexando-os-elementos
--
-- e a documentação do Haskell aqui:
--
-- https://hackage.haskell.org/package/base-4.16.2.0/docs/GHC-TypeNats.html
--
-- para mais informações sobre como essa alteração na definição pode
-- ser feita.
--
-- ATENÇÃO 1: a classe `NatToInt` já não é mais necessária. Sua
-- análoga fornecida pelo compilador é a classe `KnownNat` que tem o
-- método `natVal` que é o análogo ao nosso antigo `natToInt`.
--
-- ATENÇÃO 2: os sinônimos de tipos `N0`, `N1`, ..., `N5` também já
-- não são mais necessários. Podemos escrever diretamente 0, 1, ..., 5
-- no código que o compilador faz a sua mágica.

type SizedList :: ...
data SizedList l a where
  SEmpty :: ...
  SCons :: ...

instance (Show a, KnownNat l) => Show (SizedList l a) where
  show sls = "SizedList[" ++ show (sLength sls) ++ "]: " ++ show (sToList sls)


-- | Exercício 2. A função `sLength` que foi apresentada na lista de
-- exercícios 05 precisa ser adaptada para utilizar os números
-- naturais do compilador. Copie a função da lista de exercícios
-- anterior e adapte-a para usar os type literals. Atenção, sua função
-- `sLength` deve rodar em tempo constante (Dica: use a função
-- `natVal`).

sLength :: ...
sLength = undefined

-- | Exercício 3. Para construir `SizedList` de tamanhos variados, na
-- lista anterior nós criamos várias funções (`sl0 :: [a] -> SizedList
-- N0 a`, `sl1 :: [a] -> SizedList N1 a`, ..., `sl5 :: [a] ->
-- SizedList N5 a`) que devolviam uma `SizedList` de tamanho
-- específico, uma função para cada tamanho. Já não precisamos mais
-- recorrer a esses truques!  No entanto, para criarmos uma função
-- genérica `sl`, que trabalha com listas de qualquer tamanho, é
-- preciso usar tipos existenciais. Tipos existenciais são necessários
-- para "esconder" do compilador o tipo real do valor construído já
-- que o tipo real varia a depender da entrada (lembre-se, o tamanho
-- da lista de retorno está codificado no seu tipo!).
--
-- a) Crie o tipo existencial `ExSizedList`. Adicione a assinatura de
-- tipos ao esqueleto da definição dada e preencha o tipo do
-- construtor.
--
-- b) Crie a função `exsLength :: ExSizedList a -> Int` que a partir
-- de uma lista existencial `ExSizedList` devolva o seu
-- comprimento. Sua função, assim como a função `sLength`, deve rodar
-- em tempo constante.
--
-- c) Crie a função `sl :: [a] -> ExSizedList a` que devolve uma lista
-- existencial `ExSizedList` ao receber uma lista comum de tamanho
-- qualquer. Atenção, na chamada recursiva à sl, faça o pattern match
-- do resultado (para tirar a lista comum da lista existencial) usando
-- case (e não let ou where). Caso contrário receberá um erro similar
-- a "Unable to deduce KnownNat from...".
--
-- d) Sua função `sToList` provavelmente continua a funcionar sem
-- qualquer alteração. Contudo se este não for o caso, ajuste-a para
-- que volte a funcionar. Crie também a função `exsToList` que devolve
-- uma lista comum a partir de um `ExSizedList`.


type ExSizedList ::...
data ExSizedList a where
  MkExSizedList :: KnownNat l => ...
deriving instance Show a => Show (ExSizedList a)

exsLength :: ExSizedList a -> Int
exsLength = undefined

sl :: [a] -> ExSizedList a
sl = undefined

sToList :: SizedList l a -> [a]
sToList = undefined

exsToList :: ExSizedList a -> [a]
exsToList = undefined

-- | Exercício 4. Assim como fizemos para `SizedList`, adapte a
-- definição de `MatrizTriangular` para que utilize os type literals
-- do GHC.

-- type MatrizTriangular :: ...
type MatrizTriangular :: ...
data MatrizTriangular n a where
  MEmpty :: ...
  MCol :: ...
instance (Show a, KnownNat l) => Show (MatrizTriangular l a) where
  show m = "MatrizTriangular[" ++ show (mDim m) ++ "]: " ++ show (mToList m)


-- | Exercício 5. Adapte a sua implementação de `mDim` para que passe
-- a funcionar com a nova lista. Lembre-se, seu código deve rodar em
-- tempo constante.
mDim :: ...
mDim = undefined


-- | Exercício 6. Assim como foi necessário com `SizedLists`, também
-- precisaremos uma versão existencial de `MatrizTriangular` para que
-- possamos trabalhar com tamanhos desconhecidos em tempo de
-- compilação. Preencha o esquelo do GADT de `MkExMatrizTriangular`
-- abaixo. Aproveite e implemente a função `exmDim ::
-- ExMatrizTriangular a -> Int` que devolve a dimensão de uma matriz
-- existencial (em tempo constante!)


type ExMatrizTriangular :: ...
data ExMatrizTriangular a where
  MkExMatrizTriangular :: KnownNat n => ...
deriving instance Show a => Show (ExMatrizTriangular a)

exmDim :: ExMatrizTriangular a -> Int
exmDim = undefined

-- | Exercício 7. Para pensar! A construção de uma matriz triangular
-- sem sabermos o tamanho em tempo de compilação exige um pouco mais
-- de ginástica do programador do que a versão de listas. Isto ocorre
-- pois o compilador não consegue provar automaticamente alguns fatos
-- sobre o código sem que tenhamos que dar uma maozinha. A definição
-- de `ms :: [[a]] -> Maybe (ExMatrizTriangular a)` que transforma uma
-- matriz triangular em forma de listas de listas numa matriz
-- triangular existencial é dada abaixo.
--
-- A função `ms` funciona recursivamente, assim como a versão com
-- tamanho anterior. Vamos começar pelo caso fácil, a base da
-- recursão. Caso a lista fornecida como parâmetro seja vazia, a
-- matriz devolvida é vazia. Note o uso de `Maybe` no retorno. Isso é
-- necessário pois não sabemos se conseguiremos produzir uma matriz
-- triangular com a entrada, ela pode estar mal formada!
--
-- Em seguida, temos o caso geral. Numeramos as linhas para facilitar
-- o acompanhamento da explicação. Como temos uma lista não vazia,
-- neste caso construimos uma matriz triangular com a cauda da lista
-- (xs0) através de uma chamada recursiva (linha 1). Essa chamada pode
-- falhar, daí o nosso uso do do-notation dentro da monad Maybe. Se a
-- chamada tiver sucesso, significa que precisamos combinar o
-- resultado a lista gerada a partir da cabeça da lista (x0). Geramos
-- o resultado a partir da cabeça da lista (linha 2) e fazemos um
-- pattern match na linha 3 para podermos obter o resultado (tipo
-- normal, não existencial) na variável `x1`. Em seguida, o desejo
-- seria de combinar diretamente x1 com xs1, mas se tentarmos fazer
-- isto o compilador vai reclamar. O problema que ocorre aqui é que,
-- aos olhos do compilador, não há nada que ligue o tipo xs1 ao tipo
-- de x1 e, como o construtor `MCol` tem o tipo: `SizedList (n + 1) a
-- -> MatrizTriangular n a -> MatrizTriangular (n + 1) a` ele tenta
-- amarrar o tamanho da `SizedList` x1 com o tamanho de xs1 e não
-- consegue. De fato ele tem razão em reclamar! Se a matriz de entrada
-- não for bem formada, os tipos de xs1 e x1 podem não bater!
-- (Porque?)  Precisamos, então, fornecer uma prova para o compilador
-- de que está tudo certo ou que realmente a entrada estava
-- estragada. Essa é a tarefa da função `proof` chamada na linha 4.
--
-- A função `proof` em sua assinatura diz o seguinte: me dê uma lista
-- de tamanho l (codificado nos tipos), uma matriz de tamanho n. Se
-- `l` for igual a `n + 1` eu te devolvo um `Just Refl`, senão devolvo
-- `Nothing`. Para fazer o seu trabalho a função `proof` usa a função
-- mágica `sameNat` que dados dois proxies de números naturais
-- verifica se os números são os mesmos.
--
-- Quando fazemos o patter match da prova (linha 4) dentro do padrão
-- `Just Refl` o compilador sabe (consegue inferir) que l é de fato
-- igual a n + 1, ou seja, o tamanho de x1 é 1 a mais do que a
-- dimensão da matriz já criada de maneira recursiva e pode, portanto,
-- montar uma matriz triangular (linha 5). Caso entre no caso Nothing
-- (linha 6) então sabemos que os tamanhos da nova coluna (x1) e do
-- resto da matriz (xs1) não são compatíveis e portanto devolvemos
-- Nothing.
--
-- Uma pergunta que pode ficar no ar é: porque usar o case e não o let
-- (ou ainda, >>= já que o resultado é um Maybe, etc, etc..). A
-- resposta é um tanto complexa, mas o motivo é que o compilador não é
-- capaz de fazer o carregamento/inferência de tipos envolvendo tipos
-- existenciais se não usarmos o pattern match do case. Esse é mesmo
-- caso do exercício 3.c. Tente mudar o código abaixo para usar let,
-- por exemplo, e veja o que acontece!

proof :: forall l n a. (KnownNat l, KnownNat n) => SizedList l a -> MatrizTriangular n a -> Maybe (l :~: (n + 1))
proof _ _ = sameNat (Proxy @l) (Proxy @(n + 1))

ms :: [[a]] -> Maybe (ExMatrizTriangular a)
ms [] = Just $ MkExMatrizTriangular MEmpty
ms (x0:xs0) = do
  MkExMatrizTriangular xs1 <- ms xs0                            -- 1
  case sl x0 of                                                 -- 2
    MkExSizedList x1 ->                                         -- 3
      case proof x1 xs1 of                                      -- 4
        Just Refl -> Just . MkExMatrizTriangular $ MCol x1 xs1  -- 5
        Nothing   -> Nothing                                    -- 6


-- | Exercício 8. Sua função `mToList` deve ter continuado a
-- funcionar, mas caso ela precise de ajustes faça-os. Escreva a
-- função `exmToList` que dada uma matriz existencial triangular
-- devolva a sua representação em listas de listas.

mToList :: MatrizTriangular n a -> [[a]]
mToList = undefined

exmToList :: ExMatrizTriangular a -> [[a]]
exmToList = undefined


-- | Exercício 9. Adivinhou! Adapte o código da sua BiTree para que
-- passe a trabalhar com os type-level nats do GHC.

type BiTree :: Nat -> Type -> Type
data BiTree rnk a where
  BiTree0 :: Ord a => ...
  BiTree  :: (KnownNat r, Ord a) => ...
deriving instance Show a => Show (BiTree r a)

-- | Exercício 10. Suas funções `getRoot`, `getRank` e `linkTree`
-- devem continuar a funcionar com apenas ligeiras
-- adaptações. Faça-as.

getRoot :: BiTree r a -> a
getRoot = undefined

getRank :: ...
getRank = undefined

linkTree :: ...
linkTree = undefined

-- | Exercício 11. Em casos mais corriqueiros podemos, através de
-- pattern matching, recuperar uma das subárvores passadas como
-- parâmetro para o construtor `BiTree` do tipo `BiTree`. Algo
-- parecido com o código abaixo:
--
-- getLeft :: forall r a. KnownNat r => BiTree (r + 1) a -> Maybe (BiTree r a)
-- getLeft BiTree0{} = Nothing
-- getLeft (BiTree l r) = Just l
--
-- Neste caso, contudo, o compilador não gosta do código e reclama que
--
-- Could not deduce: r1 ~ r
--    from the context: ((r + 1) ~ (r1 + 1), KnownNat r1, Ord a)
--
-- O que ele está nos dizendo é que não está conseguindo amarrar o
-- tipo do retorno BiTree r a, com o tipo r1 (que é o nome que ele deu
-- para o r usado dentro da definição do construtor BiTree).
--
-- Neste caso precisamos usar o mesmo artifício que usamos no
-- exercício 7 e fornecer uma prova para o compilador de que tudo está
-- certo. Escreva a prova `proof2` de modo que a função `getSubTrees`
-- passe a funcionar corretamente.


proof2 :: forall m n a. (KnownNat m, KnownNat n) =>
          BiTree m a -> Proxy n -> Maybe (m :~: n)
proof2 = undefined

getSubTrees :: forall r a. KnownNat r => BiTree (r + 1) a -> Maybe (BiTree r a, BiTree r a)
getSubTrees BiTree0{} = Nothing -- Nunca vai ocorrer já que o tio r+1 da entrada impede
getSubTrees (BiTree e d) =
  case proof2 d (Proxy @r) of
    Just Refl -> Just (e, d)
    Nothing   -> Nothing
