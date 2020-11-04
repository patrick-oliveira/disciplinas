
#include <stdio.h>
#include <stdlib.h>
int t;

void empilha_valor(int *, int, int);
int desempilha_valor(int *);
void inicializa_pilha(void);
void imprime_pilha(int *, int, char);

int main(){
  int N, * pilha, x;
  char operacao;

  scanf("%d", &N);

  pilha = (int *)malloc(N*sizeof(int));
  inicializa_pilha();

  while(scanf("\n%c", &operacao) != EOF){
    if(operacao == 'E'){
      scanf("%d", &x);
      empilha_valor(pilha, x, N);
    } else if(operacao == 'D'){
      int a = desempilha_valor(pilha);
    } else if(operacao == 'T'){
      imprime_pilha(pilha, N, operacao);
    } else{
      imprime_pilha(pilha, N, operacao);
    }
  }

  return 0;
}

void imprime_pilha(int * pilha, int N, char operacao){
  int i;
  if(operacao == 'T'){
    for(i = t - 1; i >= 0; i--){
      printf("%d\n", pilha[i]);
    }
  } else {
    for(i = 0; i < t; i++){
    printf("%d\n", pilha[i]);
    }
  }
}

void empilha_valor(int * pilha, int x, int N){
  if(t < N)
    pilha[t++] = x;
}

void inicializa_pilha(void){
  t = 0;
}
int desempilha_valor(int * pilha){
  int a = -1;
  if(t > 0)
    a = pilha[--t];
  return a;
}
