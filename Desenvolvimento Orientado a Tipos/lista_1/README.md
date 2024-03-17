[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/mfd5npFg)
# Exercícios


1. Defina uma função `arvorePossui a` que retorna `True` caso `a` seja um valor presente na árvore e `False` caso contrário. A definição de `Arvore` já está dada.

1. Defina uma função `convertString2MInt t` que recebe uma árvore do tipo `Tree [Char]` e retorna uma árvore do tipo `Tree (Maybe Int)` em que todos os elementos são convertidos para Int quando possível.

1. Defina uma função `frutasDaArvore t` que recebe uma árvore do tipo `Tree [Char]` e retorna o número de frutas que a árvore tem (Maybe Int). Cada nó possui uma string que informa a quantidade de frutas que aquele nó possui. Caso a string não corresponda a um número inteiro, ignorar.

1. Defina uma função `eval expr`, que recebe um argumento do tipo `Expressao` e retorna o resultado numérico da expressão. `Expressao` já está definida em Atividade01.hs.

1. Estenda `Expressao` adicionando o construtor `Div (Expressao a) (Expressao a)`. Escreva uma função `safeEval`, que interprete a divisão como divisão inteira, mas que retorne Nothing para quando não for possível fazer a divisão.

1. Defina uma instância de `Functor` para valores do tipo `Expressao`. Deve ser possível chamar `fmap` sobre as expressões. Por exemplo, dada uma expressão `e :: Expressao a` e uma função `f :: a -> b`, `fmap f e` deve retornar uma expressão do tipo `Expressao b`.


1. Uma loja possui um catálogo no qual produtos são armazenados na forma `Cesta [String] Double`, com a lista de string identificando os nomes dos produtos e um double representando o preço total dos produtos da cesta. Crie uma instância de `Monoid` para esse tipo que concatena os nomes dos produtos na cesta e some os valores desses produtos. A instância de `Monoid` deve cuidar dos casos em que a string é vazia, ou seja, `Cesta ["notebook"] 1000 <> Cesta [] 0 == Cesta ["notebook"] 1000`.

1. Crie uma definição de uma instância de Show para fazer a separação com vírgulas dos produtos. Isto é, `show (Cesta ["Alface","Ovo","Repolho"] 15.1)` deve retornar a string `"Alface,Ovo,Repolho"`.

1. Faça uma função `produtosCaros xs d` que receba uma lista de cestas _xs_ e um double  _d_. Ela deve retornar uma Cesta com a lista dos nomes dos produtos (na mesma ordem dada) que custam mais do que o valor _d_ e o valor total. **Dica: utilize `foldMap`**.


1. Após uma revisão no catálogo da loja, o gerente percebeu que havia na base de dados produtos com preço negativo. Como isso não faz sentido, desenvolva uma função `atualizaCatalogo xs` que recebe uma lista de cestas da mesma forma que no exercício anterior. A função devolve uma nova lista, mas com os preços dos produtos que eram negativos agora com o sinal positivo.

1. Crie uma função `somarCarrinho` que, dada uma lista de cestas, retorne o valor total daquele carrinho. Utilize `fold`.


# Orientações

As definições das funções solicitadas acima estão no arquivo `Atividade01.hs`, localizado na pasta `src`. Este é o **único** arquivo que você precisa editar. Você deve implementar as funções acima **sem alterar seus nomes ou tipos** já definidos no arquivo. Você pode criar funções auxiliares da forma que achar melhor.

Os casos de teste estão no arquivo `Spec.hs`, dentro da pasta `test`. **Não modifique o arquivo Spec.hs**. Após implementar suas funções no arquivo `Atividade01.hs`, basta digitar
`stack test`
e acompanhar em quais casos de teste seu código passou.

Você pode criar funções auxiliares da forma que achar melhor, mas as funções chamadas no arquivo `Spec.hs` devem, obviamente, constar no arquivo `Atividade01.hs` (caso contrário dará erro nos testes).
