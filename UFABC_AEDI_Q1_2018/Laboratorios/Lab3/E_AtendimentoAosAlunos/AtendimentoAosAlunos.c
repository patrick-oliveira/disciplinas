#include <stdio.h>
#include <stdlib.h>

typedef struct{
    int RA;
    char nome[100];
} aluno;

struct fila{
  aluno * elementos;
  int final;
  int inicio;
  int qtde;
  int tamanho_maximo;
};

struct fila cria_fila(int);
void insere_elemento(struct fila *, aluno);
aluno remove_elemento(struct fila *);
void imprime_lista(struct fila *, char);

int main(){
  struct fila F;
  int N;
  char operacao;
  aluno a;

  scanf("%d", &N);
  F = cria_fila(N);
  
  while(1){
    if(scanf("\n%c", &operacao) != EOF){
        if(operacao == 'I'){
          scanf("%d %s", &a.RA, a.nome);
          insere_elemento(&F, a);
        } else if(operacao == 'A'){
          a = remove_elemento(&F);
          if(a.RA != -1){
              printf("[%d] %s\n", a.RA, a.nome);
          }
        } else if(operacao == 'Q'){
            printf("Quantidade: %d\n", F.qtde);
        } else{
            imprime_lista(&F, operacao);
        }
    } else
        return 0;
  }

  return 0;
}

void imprime_lista(struct fila * F, char operacao){
  int i;
  if(operacao == 'M'){
      for(i = F -> inicio; i < F -> final; i++){
          printf("[%d] %s\n", F -> elementos[i].RA, F -> elementos[i].nome);
      }
  } else{
      for(i = F -> final - 1; i >= F -> inicio; i--){
          printf("[%d] %s\n", F -> elementos[i].RA, F -> elementos[i].nome);
      }
  }
}

void insere_elemento(struct fila * F, aluno x){
  if(F -> final < F -> tamanho_maximo){
    F -> elementos[F -> final ++] = x;
    F -> qtde++;
  }
}

aluno remove_elemento(struct fila * F){
  aluno x;
  x.RA = -1;
  if (F -> inicio != F -> final){
    x = F -> elementos[F -> inicio++];
    if(F -> inicio == F -> final){
        F -> inicio = 0;
        F -> final = 0;
    }
    F -> qtde--;
    return x;
  }
  
  return x;
}

struct fila cria_fila(int n){
  struct fila F_temp;
  F_temp.elementos = (aluno *)malloc(n*sizeof(aluno));
  F_temp.final = 0;
  F_temp.inicio = 0;
  F_temp.qtde = 0;
  F_temp.tamanho_maximo = n;
  return F_temp;
}
