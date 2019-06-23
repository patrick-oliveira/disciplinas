/*
 * Que tipos de problemas um algorítmo recursivo é capaz de resolver?
 * 1 - Problemas iterativos, onde um valor é obtido por meio de uma operação
 * sobre o valor anterior.
 * 2 - Casos onde é possível reduzir o problema a instâncias menores dele mesmo.
 */

#include <stdio.h>

int maximo(int, int);
int maximo_recursivo(int, int);
int maximo_recursivo2(int, int);

int main(void){

}

int maximo(int n; int v[]){ /* Passando como argumento uma matriz inteira e seu tamanho n */
  int x;
  x = v[0];
  for(int i = 0; i < n; i++)
    if (x < v[i]) x = v[i];

  return x;
}

int maximo_recursivo(int n, int v[]){
  if(n == 0){ /* caso o vetor contenha apenas um valor */
    return v[0];
  } else {
    int x;
    x = maximo_recursivo(n - 1, v[]) /* reduzo a instância do problema */
    if (x < v[n - 1]) /* comparo com o valor que deixei para trás */
      return v[n - 1];
    else
      return x;
  }
}

int maximoR(int n, int v[]){
  int x;
  if (n == 1) x = v[0]; /* Se o vetor possui um elemento, ele é o maior */
  else {
    x = maximoR(n - 1, v); /* Reduz a instância do problema, buscando o maior valor em um espaço menor. */
    if(x < v[n - 1]) x = v[n - 1]; /* Faz a comparação com o valor que ficou para trás. */
  }
  return x;
  /*
   * Este é um algorítmo recursivo de cauda, isto é, a cada recursão uma
   * operação é deixada para trás. No caso, a operação é a de comparação entre dois números.
   * Ao chegar no último valor o algorítmo retorna fazendo a comparação entre o maior valor obtido e o valor
   * deixado para trás na instância superior.
   */
}

/*
int maximoR1 (int n, int v[]){
  if(n == 1) x = v[0];
  if(n == 2) {
    if (v[0] < v[1]) return v[1];
    else return v[0];
  }
  int x = maximoR1 (n - 1, v);
  if (x < v[n-1]) return v[n-1];
  else return x;
}

Não há nenhuma condição base para parar a interação. Nos casos onde estamos
na última ou na penúltima recursão, é feita a comparação e o retorno para a
instância superior, entretanto, quando n = 3, ele chama a recursão para 2,
comparando e retornando para a instância n = 3, ficando preso em um loop
infinito.


int maximoR2 (int n, int v[]){
  if (n == 1) return v[0];
  if (maximoR2(n-1, v) < v[n-1])
    return v[n -1];
  else
    return maximoR2(n-1, v);
}

A condição do segundo if fará a recursão até o caso base, onde o vetor possui
um único elemento. Retornando, ele compara este único valor com o anterior, deixado nai nstância superior, retornando-o caso este seja o maior, entretanto, caso não seja, ele chama a função recursivamente mais uma vez, baixando uma instância e dando início a um loop infinito.
*/
