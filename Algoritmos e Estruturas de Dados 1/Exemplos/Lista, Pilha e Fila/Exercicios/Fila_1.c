#include <stdio.h>
#define N 10

int fila[N];
int u, p;

void gerafila(void);
void colocanafila(int);
int tiradafila(void);
int filavazia(void);
int filaheia(void);

int main(){

  return 0;
}

int filacheia(void){
  return (u == N -1);
}

int filavazia(void){
  return (p == u+1);
}

int tiradafila(void){
  if(!filavazia()){
    int x = fila[p++];
  } else {
    p = 0;
    u = 0;
  }
  return x;
}


void colocanafila(int y){
  if(u != N - 1){
    fila[++u] = y;
  }
}

void gerafila(void){
  u = 0;
  p = 0;
}
