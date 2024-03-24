# Introdução

Toda linguagem de programação nos oferece um conjunto de tipos primitivos de dados (e.g., int, float, char), mas não tarda a se fazer necessária a possibilidade de se construir novos tipos e estruturas de dados. No mínimo, o uso de tipos é uma forma de tornar o código legível e mais facilmente interpretável, ainda que a linguagem seja de tipagem fraca, como Python, oferecendo somente a possibilidade de anotação de tipos. Em Haskell, isso pode ser feito através do termo _type_:

```haskell
type Nome = String
```

Aqui, o tipo “Nome” segue sendo apenas um tipo String (que, por sua vez, é somente um tipo [Char]). Havendo tipagem forte, a construção de novos tipos se faz útil quando queremos construir programas que restringem o seu funcionamento a certos tipos, e para isso podemos utilizar o termo _newtype_:

```haskell
newtype NNome  = CNome String

helloFulano :: NNome -> String
helloFulano (Cnome n) = print $ "Olá, " ++ n
```

A função *helloFulano* funcionará apenas com um argumento do tipo NNome, e para isso o newtype introduz um construtor “CNome” que transforma um argumento do tipo String em um elemento do tipo NNome. O construtor é essencialmente um envelope, e poderíamos, inclusive, parametrizá-lo:

```haskell
newtype AbstractType a = AbstractType a
```

Aqui, nomeados o construtor com o mesmo nome do tipo, e ele transforma qualquer tipo de entrada em um elemento do tipo "AbstractType". Porém, o newtype nos permite trabalhar apenas com um único construtor e um único argumento, sendo assim muito limitado no que diz respeito à construção de tipos de dados estruturalmente mais arrojados.

Os Tipos de Dados Algébricos nos oferece fundamentalmente duas novas formas de se construir novos tipos, os quais chamamos de tipo Soma (no Haskell representado por Either) e tipo Produto. Sintaticamente, temos o seguinte:

```haskell
data Either a b = Left a | Right b
data Prod a b = Prod a b
```

Acima, utilizamos dois parâmetros de tipo, a e b, entretanto poderíamos utilizar um número arbitrário deles. O tipo Soma envolve ao menos dois construtores distintos, Left e Right, de tal modo que qualquer elemento Either é construído como um Left, _ou_ como um Right. Ou seja, o tipo Soma nos permite escolher um sub-tipo dentre um conjunto de opções, e faz paralelo com o operador lógico OR. O exemplo mais evidente é o tipo Bool

```haskell
data Bool = True | False
```

O tipo Produto, todavia, envolve um único construtor que _combina_ elementos de dois tipos, então cada exemplar de Prod _deve_ envolver um exemplo tanto de um tipo quanto de outro, como em um produto cartesiano:

```haskell
data Vector2D = Vector2D Double Double
```

Além disso, podemos combinar ambos os tipos na construção de um novo tipo:

```haskell
data Temperatura = Celcius Double | Fahrenheit Double

newtype Volume = Double
newtype Chance = Double
data Chuva = Chuva Volume Chance

data PrevisaoTempo = Previsao Temperatura Chuva
```

O fato de podermos construir novos tipos através destas “operações” do tipo Soma e Produto atribui a estes títulos o nome de “tipos algébricos”. Porém, isto não é meramente um apelido, existindo de fato uma estrutura algébrica formal subjacente ao processo de construção de tipos a partir dos blocos básicos Soma e Produto.

# A Álgebra dos Tipos de Dados Algébricos

Intuitivamente, podemos entender que uma álgebra é determinada por um conjunto de símbolos, em cima dos quais definimos operações que devem seguir um certo conjunto de regras, e posteriormente novas regras podem ser deduzidas a partir das definições básicas dessa estrutura. Temos então, por exemplo, os números inteiros $\mathbb{Z}$, e a operação de soma “+”, que admite, dentre outras coisas, comutatividade: $a + b = b + a$ para quaisquer $a, b \in \mathbb{N}$. Ademais, certos elementos podem ter atributos particulares dentro dessas operações, e.g. o 0 que é o elemento neutro da soma, ou seja: $0 + a = a$ para qualquer $a \in \mathbb{N}$.

Similarmente, em Haskell, podemos considerar os tipos básicos da linguagem como o conjunto inicial de símbolos com os quais podemos trabalhar, como Int, Double, Bool, Char, (), etc. Podemos entender que estes e eventuais outros símbolos são todos elementos de um conjunto $\mathbb{T}$ que reúne tudo aquilo que a linguagem admite como um “tipo”, e.g. o tipo String. Nesse sentido, relacionamos estes símbolos através da construção de novos tipos Soma ou Produto, sendo operações fechadas em $\mathbb{T}$: recebem dois elementos em $\mathbb{T}$, retornando um novo elemento em $\mathbb{T}$. E quais propriedades possuem estas operações?

Consideremos, por exemplo, os seguintes tipos:

```haskell
data Void

data Either a = Left Void | Right a 
data Prod a = MkProd () a
```

Posto que “Void” é um tipo que não pode possuir nenhum valor, no primeiro caso é impossível que tenhamos um Left; qualquer exemplo de Sum a é, necessariamente, Right a, portanto, $\text{Sum a} \equiv a$, isto é, “Void” é o elemento neutro do tipo Soma. No segundo caso, todo exemplar de Prod () a deve ter necessariamente o tipo () como primeiro elemento, enquanto o segundo será do tipo *a*, portanto $\text{Prod () a} \equiv a$, e () é, desse modo, o elemento neutro do tipo Prod.

É possível demonstrar que os tipos Soma e Produto são associativos. Na aritmética teríamos $a + (b + c) = (a + b) + c$, porém em se tratando de tipos, não podemos demonstrar que $\text{Either a (Either b c)} = \text{Either (Either a b) c}$, posto que esta igualdade não faz sentido na linguagem. A demonstração equivalente consiste em determinar que os dois tipos são similares ao nível de isomorfismo. Dois elementos A e B são ditas isomórficos se existe um mapeamento invertível, chamado de isomorfismo, de A para B, que preserva a estrutura de A (e no caso inverso, de B). Em geometria temos o exemplo das transformações de corpo rígido — em teoria de tipos, dois tipos são ditos isomórficos se existem funções $\text{f}$ e $\text{g}$ tais que para cada elemento $\text{x}$ do primeiro tipo, $\text{g (f x)} = \text{x}$, e para cada $\text{y}$ do segundo tipo, $\text{f (g y)} = \text{y}$. Para a propriedade de associatividade dos tipos Soma e Produto, as funções são dadas por:

```haskell
-- Associatividade da soma
sumAssocLeft :: Either (Either a b) c -> Either a (Either b c)
sumAssocLeft (Left (Left a)) = Left a
sumAssocLeft (Left (Right b)) = Right (Left b)
sumAssocLeft (Right c) = Right (Right c)

sumAssocRight :: Either a (Either b c) -> Either (Either a b) c
sumAssocRight (Left a) = Left (Left a)
sumAssocRight (Right (Left b)) = Left (Right b)
sumAssocRight (Right (Right c)) = Right c

  
-- Associatividade do produto
prodAssocLeft :: ((a, b), c) -> (a, (b, c))
prodAssocLeft ((a, b), c) = (a, (b, c))

prodAssocRight :: (a, (b, c)) -> ((a, b), c)
prodAssocRight (a, (b, c)) = ((a, b), c)
```

Note que as funções não exigem nenhuma alteração na construção dos tipos, por isso podemos concluir que os tipos Soma e Produto são associativos. Porém, não podemos dizer que eles são comutativos, ainda que exista um isomorfismo relacionando $\text{Either a b}$ e $\text{Either b c}$, e entre $\text{(a, b)}$ e $\text{(b, a)}$:


```haskell
comutaEither :: Either a b -> Either b a
comutaEither (Left a) = Right a
comutaEither (Right b) = Left b

comutaProd :: (a, b) -> (b, a)
comutaProd (a, b) = (b, a)
```

No caso do Either, é necessária uma troca dos construtores, _que possuem interpretações distintas_. 

```haskell
threshold :: (Num a, Ord a) => Either a a -> Maybe a
threshold (Left x)
	| x > 10 = Just x
	| otherwise = Nothing
threshold (Right x)
	| x > 0 = Just x
	| otherwise = Nothing
```

Com a função acima, temos que _threshold Left 5 = Nothing_, mas threshold (comutaEither Left 5) = threshold (Right 5) = Just 5. Não vale, pois, a comutatividade. Similarmente, a posição do valor na tupla do tipo Produto também pode ter interpretações particulares, de modo que trocar a posição do valor pode implicar em erros na execução do programa.

O conjunto de tipos munido das operações binárias de Soma ou Produto, que são associativas, formam uma estrutura algébrica de semi-grupo. A existência de um elemento neutro para ambas as operações nos permite concluir que a estrutura é um Monoid. 

# Manipulando Cardinalidades

A discussão anterior nos sugere que podemos manipular os tipos similarmente a como faríamos na aritmética. Neste sentido, um tipo poderia ser construído a partir de uma sucessão de operações Soma e Produto. Porém, na aritmética, uma mesma expressão pode ser reescrita de múltiplas formas, decompondo e recompondo números em somas e produtos, sem alterar o valor resultante. Podemos também fazer algo similar com os tipos, e isso passa novamente pela noção de isomorfismo.

Primeiramente, trataremos da cardinalidade dos tipos. O propósito de um tipo de dados é representar um certo conjunto de valores, portanto para cada tipo podemos atribuir um inteiro denotando quantos valores ele pode representar. O tipo Void, ao passo que não pode expressar valor nenhum, tem cardinalidade 0; o tipo Unit expressa apenas um valor, então sua cardinalidade é 1; o tipo Bool pode ser True ou False, portanto, |Bool| = 2. Já o tipo Either, não parametrizado, também pode expressar dois valores: Left e Right. Poderíamos inclusive apontar uma bijeção entre Bool e Either:

```haskell
eitherToBool :: Either a a -> Bool
eitherToBool (Left _) = False
eitherToBool (Right _) = True

boolToEither :: Bool -> Either a a
boolToEither False = Left undefined
boolToEither True = Right undefined
```

Eles são, portanto, isomorfos. 

De forma mais geral, a cardinalidade de um tipo Soma é a soma das cardinalidades dos seus tipos componentes. Então |Either a b| = |a| + |b|, ou por um abuso de notação, |Either a b| = a + b. Similarmente, a cardinalidade de um tipo Produto é o produto das cardinalidades dos seus tipos: |(a, b)| = a × b. Se um tipo é composto por soma e produto, naturalmente, a sua cardinalidade envolverá a soma e o produto das cardinalidades dos tipos Soma e Produto componentes.

```haskell
data Coordinates = Coordinates Int Int
data Piece = PieceA | PieceB | PieceC
data Occupied = Empty | HasPiece Piece
data Position = Position Coordinates Occupied
```

No exemplo acima, supomos um jogo com um tabuleiro com coordenadas identificadas por um par de inteiros (tipo Coordinates), e em cada coordenada pode haver ou não uma peça, onde uma peça pode ser uma de três tipos. Portanto, representamos as posições no tabuleiro por um tipo Position que deve conter duas informações: as coordenadas e o que ela contém. Assim,

```
|Position| = |Coordinates| x |Occupied|
= (|Int| x |Int|) x (1 + |Piece|)
= (|Int| x |Int|) + |Int| x |Int| x |Piece|
= |Coordinates| + |Coordinates| x |Piece|
```

O que significa dizer que $\text{|Coordinates|} + \text{|Coordinates|}\times \text{|Piece|} = \text{|Coordinates|} \times \text{|Occupied|}$? Que poderíamos representar as posições de duas formas: associando a cada coordenada a informação de que ela está vazia ou ocupada, e caso esteja ocupada, o que a ocupa; separando as posições em dois conjuntos, um primeiro com as coordenadas vazias, e outro com as coordenadas ocupadas, associadas à informação do que a ocupa.

```haskell
data Position' = EmptyCoord Int Int | OccCoord (Int, Int) Piece
```

Ambos os tipos _representam a mesma informação_. Pode-se mapear cada exemplo de um tipo em outro através de uma bijeção. 

```haskell
positionToPosition_ :: Position -> Position_
positionToPosition_ Position (Coordinates x y) Empty = EmptyCoord x y
positionToPosition_ Position (Coordinates x y) p     = OccCoord (x, y) p

position_ToPosition :: Position_ -> Position
position_ToPosition EmptyCoord x y    = Position (x, y) Empty
position_ToPosition (OccCoord x y, p) = Position (Coordinates x y) p
```

E de forma mais geral, tal mapeamento é possível para _quaisquer dois tipos com cardinalidade igual_. Isto nos dá uma enorme flexibilidade para transformar uma estrutura de dados em outra, talvez mais conveniente de se trabalhar, a partir de manipulações algébricas sobre as suas cardinalidades.

# Representação Algébrica de Funções

Uma função faz um mapeamento de elementos de um tipo $a$ em elementos de um tipo $b$, assim, o tipo de uma função $f$ é dado por $a \to b$. Para cada elemento $x$ do $a$, podemos escolher um dentre $|b|$ elementos $y$ do tipo $b$ tais que $f(x) = y$. Portanto, existem $\prod_{n=1}^{|a|}|b|$ possíveis mapeamentos de $a$ em $b$, e vale então que $|f| = b^a$.

Para ilustrar o benefício de se poder transformar algebricamente um tipo em outro, suponhamos agora que precisamos de uma estrutura de dados que represente o tabuleiro inteiro de uma só vez, e não somente as posições isoladas. Para um tabuleiro com lados de tamanho 2, teríamos, por exemplo:

```haskell
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

data NaiveBoard = NaiveBoard
	{ C00 :: Bool
	, C01 :: Bool
	, C10 :: Bool
	, C11 :: Bool
	}
	deriving (Show)
```

Neste caso, a título de simplicidade, cada coordenada é um tipo Bool representando se a posição está ou não ocupada. Ainda assim, apresentar um determinado estado do tabuleiro envolveria atribuir um valor para cada posição, e posto que não podemos modificar o estado de variáveis, cada mudança no tabuleiro implicaria em reescrever cada uma das posições. E se tivéssemos tabuleiros de tamanho $n \times n$ com $n = 9$, ou mesmo reticulados de várias dimensões, como $n \times n \times n$?

NaiveBoard é um tipo produto de cardinalidade $2^4$ — de forma geral, o tipo teria cardinalidade $2^{n \times n}$. É a mesma cardinalidade de uma função de tipo $(a, a) \to Bool$, onde $a$ é um tipo de cardinalidade $n$. Digamos:

```haskell
data Coord = C0 | C1
deriving (Show, Enum, Eq)

newtype FBoard = FBoard {board :: Coord -> Coord -> Bool}
```

Os dois tipos são isomórficos, posto que possuem a mesma cardinalidade, e a similaridade é intuitiva: a função mapeia cada coordenada em seu estado. Poderíamos construir uma expressão inicial para o tabuleiro onde nenhuma célula está ocupada:

```haskell
initialState :: FBoard
initialState = FBoard (\x y -> False)
``` 

E funções para alterar o estado de uma determinada célula:

```haskell
occupy :: FBoard -> Coord -> Coord -> FBoard
occupy (FBoard f) x y
	| f x y = FBoard f
	| otherwise = FBoard (\a b -> if a == x && b == y then True else f a b)

unnoccupy :: FBoard -> Coord -> Coord -> FBoard
unnoccupy (FBoard f) x y
	| f x y = FBoard (\a b -> if a == x && b == y then False else f a b)
	| otherwise = FBoard f
```

Dessa forma, qualquer estado do tabuleiro pode ser obtido mediante aplicações sucessivas das funções occupy ou unnoccupy, como no exemplo a seguir:

```haskell
stateChange :: IO ()
stateChange =
	do
		print $ board initialState C0 C0
		let newState = occupy initialState C0 C0
		print $ board newState C0 C0
		print $ board newState C1 C0
		let anotherState = occupy newState C1 C0
		print $ board anotherState C0 C0
		let yetAnotherState = occupy (occupy anotherState C0 C1) C1 C1
		print $ board yetAnotherState C0 C0
		print $ board yetAnotherState C0 C1
		print $ board yetAnotherState C1 C0
		print $ board yetAnotherState C1 C1
```

O aumento do tamanho do tabuleiro exigiria tão somente aumentar a composição no tipo Coord, e o aumento de dimensões do reticulado envolveria apenas ajustes no número de parâmetros das funções que retornam os estados das células.

# Equivalência entre Álgebra e Tipos

A tradução entre a construção de tipos e operações algébricas sobre as suas cardinalidades não são uma mera _heurística_, mas uma equivalência factual entre sistemas de tipos, sistemas lógicos e algébricos. Essa equivalência é conhecida como Isomorfismo de Curry-Howard, resumida na tabela:

| Algebra      | Lógica                     | Tipos                 |
| ------------ | -------------------------- | --------------------- |
| $a + b$      | $a \vee b$                 | $\text{Either a b}$   |
| $a \times b$ | $a \wedge b$               | $\text{a, b}$         |
| $b^{a}$      | $a \implies b$             | $\text{a}\to\text{b}$ |
| $a = b$      | $a \Longleftrightarrow b$  | $\text{Isomorfismo}$  |
| 0            | $\bot$                     | $\text{Void}$         |
| 1            |  $\top$                    | $\text{( )}$          |


A equivalência entre tipos algébricos e proposições lógicas nos permite entender que para todo teorema corresponde um programa, e todo programa é tão somente uma demonstração matemática. Dessa forma, não apenas podemos, por meio de manipulações algébricas, construir novos tipos, como podemos expor propriedades dos nossos programas traçando paralelos com teoremas válidos sobre uma estrutura algébrica.

Por exemplo, considere que para quaisquer $a, b, c \in \mathbb{N}$ vale que $(c^b)^a = c^{a \times b}$. Posto que esta afirmação é verdadeira, ela equivale a dizer que são isomórficas as funções $a \to (b \to a)$ e $(a, b) \to c$, sendo justamente a equivalência entre as versões _curried_ e _non-curried_ de uma função com múltiplos parâmetros. Inversamente, demonstramos que $a^b \times a^c = a^{b + c}$ apresentando o isomorfismo (i.e., um programa válido) entre as funções de tipo $(b \to a, c \to a)$ e $\text{Either b c} \to a$:

```haskell
f :: (b -> a) -> (c -> a) -> Either b c -> a
f g h (Left x) = g x
f g h (Right y) = h y

f_ :: (Either b c -> a) -> (b -> a, c -> a)
f_ w = (w . Left, w . Right)
```

Enfim, encerrando este desvio teórico, ao passo que qualquer número natural pode ser representado como somas e produtos de outros números naturais, segue que todo tipo de dado possui uma chamada *representação canônica* da forma $t = \sum_{m}\prod_{n} t_{m, n}$, em que $t_{m, n}$ denota tipos Som e Produto. Um conjunto de tipos, todos de cardinalidade $|t|$, são isomórficos mutualmente e possuem uma mesma representação canônica.