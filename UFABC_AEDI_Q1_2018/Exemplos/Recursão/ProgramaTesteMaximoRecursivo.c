#include <stdio.h>
#include <stdlib.h>

int maximoR(int, int *);
int verificador_linear_iterativo(int, int *, int);
int verificador_linear_recursivo();

int main(){
  int *v, n, i, maior;

  scanf("%d", &n);
  v = (int *)malloc(n*sizeof(int));

  for(i = 0; i < n; i++){
    scanf("%d", &v[i]);
  }

  maior = maximoR(n, v);

  printf("\nMairo valor: %d\n", maior);

  printf("Teste do verificador por busca linear iterativa: ");
  if(verificador_linear_iterativo(n, v, maior)){
    printf("Funciona.\n");
  } else {
    printf("Nao funciona.\n");
  }

  printf("Teste do verificador por busca linear recursiva: ");
  if(verificador_linear_recursivo(n, v, maior)){
    printf("Funciona.\n");
  } else {
    printf("Nao funciona.\n");
  }
  return 0;
}

int maximoR(int n, int *v){
  if(n == 1)
    return *v;
  else{
    int x = maximoR(n - 1, v);
    if(x < v[n - 1])
      return v[n - 1];
    else
      return x;
  }
}

int verificador_linear_iterativo(int n, int *v, int maior){
  int i;
  for(i = 0; i < n; i++){
    if(maior < v[i]){
      return 0;
    }
  }
  return 1;
}

int verificador_linear_recursivo(int n, int *v, int maior){
  if(n == 1){
    if(maior < *v)
      return 0;
  } else {
    if(maior < v[n - 1]){
      return 0;
    } else {
      return  verificador_linear_recursivo(n - 1, v, maior);
    }
  }

  return 1;
}
