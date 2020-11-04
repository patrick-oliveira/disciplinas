#include <stdio.h>
#define N 20

void imprimir_vetor(int *, int);
void inverter_vetor(int *, int);

void main(){
  int v[N];

  for(int i = 0; i < N; i++) v[i] = N - i;
  imprimir_vetor(v, N);
  inverter_vetor(v, N);
  imprimir_vetor(v, N);
}

void imprimir_vetor(int *v, int n){
  for(int i = 0; i < n; i++){
    printf("%d ", v[i]);
  }
  printf("\n");
}

void inverter_vetor(int *v, int n){
  int aux;
  for(int i = 0; i < n/2; i++){
    aux = v[i];
    v[i] = v[n - 1 - i];
    v[n - 1 - i] = aux;
  }
}
