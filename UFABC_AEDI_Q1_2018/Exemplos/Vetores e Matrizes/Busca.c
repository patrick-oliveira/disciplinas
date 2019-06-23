#include <stdio.h>
#define N 10

/* Convenção: comece pensando no que a função vai retornar.
 * No caso de uma busca, retorna o índice do array onde está o elemento
 * sendo buscado.
 */

int busca_trasfrente(int, int, int *);
int busca_frentetras(int, int, int *);
int busca_recursiva(int, int, int *);
void remove(int, int, int *);
int remove_recursivo(int, int, int *);
void insere(int, int, int, int *);
void insere_recursivo(int, int, int, int *);
void imprimir_vetor(int *, int);

void main(){
  int v[N];

  for(int i = 0; i < N; i++)
    v[i] = N - i;
}

/*
 * Busca de trás para frente. Caso não ache, retorna -1, índice fora do intervalo
 * da matriz.
 */

int busca_trasfrente(int x, int n, int *v){
  int k;
  k = n - 1;
  while(k >= 0 && v[k] != x)
    k--;
  return k;
    /* Igualmente funcional (e mais elegante imo)
    for(int k = n-1; k >= 0; --k)
      if(v[k] == x) return k;
    return -1;
    */
    /* Solução - sutilmente - incorreta. A ordem dos elementos importa.
      int k = n-1;
      while (v[k] != x && k >= 0)
        k -= 1;
      return k;
    */

}

int busca_frentetras(int x, int n, int *v){
  int k = 0;
  v[n] = x;
  while(v[k] != x)
    k++;
  return k;
  /*
    Solução elegante. O elemento v[n] não existe no array (vai de 0 até n -1) mas
    a linguagem permite o acesso à memória, portanto podemos introduzir uma "sen-
    tinela" e evitar as comparações k < n.
  */
}

/* Busca recursiva de trás para frente. */
int busca_recursiva(int x, int n, int *v){
  if(n == 0) return -1;
  if(x == v[n-1]) return n - 1;
  return busca_r (x, n-1, v);
  /* Observe que não é necessário incluir um else. */
}

/*
 * Remover um elemento k de um vetor v[0,...,n-1] consiste em pegar todos os e-
 * lementos k+1,...,n-1 e deslocá-los uma casa atrás. A complexidade do algorítmo
 * é O(x) pois no pior caso ele precisará percorrer o vetor inteiro. Listas ligadas
 * resolvem este problema.
 */
int remove(int k, int n, int *v){
  for(int j = k + 1; j < n; j++)
    v[j-1] = v[j];
}

/*
 * Adicionar um elemento x entre k e k+1 consiste em deslocar todos os k+1,...,n - 1
 * elementos para frente. Isso só pode ser feito, naturalmente, se o vetor não está
 * cheio, caso em que ocorreria um overflow.
 */
void insere(int k, int x, int n, int *){
  for(int i = n; i > k; i--)
    v[i] = v[i - 1];
  v[k] = x;
}

void insere_recursivo(int k, int x, int n, int *v){
  if(k == n) v[n] = x;
  else{
    v[n] = v[n - 1];
    insere_recursivo(k, x, n-1, v);
  }
}

void remove_recursivo(int k, int n, int *v){
  int x = v[k];
  if (k < n-1){
    int y = remove_recursivo(k+1, n, v);
    v[k] = y;
  }
}



void imprimir_vetor(int *v, int n){
  for(int i = 0; i < n; i++){
    printf("%d ", v[i]);
  }
  printf("\n");
}

/* Anotações gerais */
/*
    Definição(Invariante): é uma *relação* entre os valores das variáveis que
  *vale no início de cada iteração* e não se altera de uma iteraçao para outra.
  No caso da função busca, o invariante é a relação de que x é diferente de todos
  os elementos anteriormente verificados do vetor. Obviamente que esta relação
  permance caso outra iteração se inicie.

*/
