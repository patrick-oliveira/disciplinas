#include <stdio.h>
#include <stdlib.h>

#define N 100
int fila[N];
int p, u;

void colocanafila(int y){
  if(!(u+1 == p) && !(u+1 == N && p == 0)){
    fila[u++] = y;
    if(u == N) u = 0;
  }
}

int tiradafila(void){
  if(u != p){
    int x = fila[p++];
    if(p == N) p = 0;
    return x;
  }
}

void imprimefila(void){
  int q = p;
  while(q != u){
    printf("%d ", fila[q++]);
    if(q == N) q = 0;
  }
  printf("\n");
}

int main(){
  char operacao;
  int y;

  while(scanf("%c", &operacao) != EOF){
    if(operacao == 'I'){
      scanf("%d", &y);
      colocanafila(y);
    } else if(operacao == 'R'){
      printf("%d\n", tiradafila());
    } else if(operacao == 'M'){
      imprimefila();
    }
  }

  return 0;
}
