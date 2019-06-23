#include <stdio.h>

void imprimir_vetor(int *, int);

void main(){
  int v[99];

  for(int i = 0; i < 99; ++i) v[i] = 98 - i;
  imprimir_vetor(v, 99);
  printf("\n");
  for(int i = 0; i < 99; ++i) v[i] = v[v[i]];

  imprimir_vetor(v, 99);
}

void imprimir_vetor(int *v, int n){
  for(int i = 0; i < n; i++){
    printf("%d ", v[i]);
  }
}
