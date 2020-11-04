#include <stdio.h>
#include <stdlib.h>

struct fila{
  int * elementos;
  int final;
  int inicio;
  int tamanho_maximo;
};

struct fila cria_fila(int);
void insere_elemento(struct fila *, int);
int remove_elemento(struct fila *);
void imprime_lista(struct fila *);

int main(){
  struct fila F;
  int q, x;
  char operacao;

  scanf("%d", &q);
  F = cria_fila(q);

  while(1){
      if(scanf("\n%c", &operacao) != EOF){
        if(operacao == 'E'){
          scanf("%d", &x);
          insere_elemento(&F, x);
        } else {
          int x = remove_elemento(&F);
          if(x != -1){
              printf("%d\n", x);
          }
        }
      } else
        return 0;
  }

  return 0;
}

void imprime_lista(struct fila * F){
  int i;
  for(i = F -> inicio; i < F -> final; i++){
    printf("%d ", F -> elementos[i]);
  }
  printf("\n");
}

void insere_elemento(struct fila * F, int x){
  if(F -> final < F -> tamanho_maximo)
    F -> elementos[F -> final ++] = x;
}

int remove_elemento(struct fila * F){

  if (F -> inicio != F -> final){
    int x = F -> elementos[F -> inicio++];
    if(F -> inicio == F -> final){
        F -> inicio = 0;
        F -> final = 0;
    }
    return x;
  }
  return -1;
}

struct fila cria_fila(int n){
  struct fila F_temp;
  F_temp.elementos = (int *)malloc(n*sizeof(int));
  F_temp.final = 0;
  F_temp.inicio = 0;
  F_temp.tamanho_maximo = n;
  return F_temp;
}
