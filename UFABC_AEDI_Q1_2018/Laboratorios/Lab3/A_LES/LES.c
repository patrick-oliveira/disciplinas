#include <stdio.h>
#include <stdlib.h>

struct lista{
  int * elementos;
  int  quantidade;
  int  tamanho_maximo;
};

struct lista criar_lista(int);
void insere_elemento(struct lista *, int);
void remove_elemento(struct lista *, int);
void imprime_lista(struct lista *);
int busca_binaria(int *, int, int, int);
int main(){
  struct lista L;
  int q, i, x;
  char operacao;

  scanf("%d", &q);
  L = criar_lista(q);

  for(i = 0; i < q; i++){
    scanf("\n%c %d", &operacao, &x);
    if(operacao == 'I'){
      insere_elemento(&L, x);
    } else if (operacao == 'E') {
      remove_elemento(&L, x);
    }
  }
  imprime_lista(&L);
  return 0;
}

struct lista criar_lista(int q){
  struct lista L_temp;
  L_temp.elementos = (int *)malloc(q*sizeof(int));
  L_temp.quantidade = 0;
  L_temp.tamanho_maximo = q;
  return L_temp;
}

void insere_elemento(struct lista * L, int x){
  int i = 0, j, achei = 0;

  while(!achei && i < L -> quantidade){
    if(x < L -> elementos[i]){
      achei = 1;
    } else if (x == L -> elementos[i]){
      return;
    } else
      i++;
  }
  for(j = L -> quantidade - 1; j >= i; j--){
    L -> elementos[j + 1] = L -> elementos[j];
  }
  L -> elementos[i] = x;
  L -> quantidade++;
}

void remove_elemento(struct lista * L, int x){
  int i = busca_binaria(L -> elementos, 0, L -> quantidade - 1, x);
  int j;
  if (i != -1){
    for(j = i; j < L -> quantidade - 1; j++){
      L -> elementos[j] = L -> elementos[j + 1];
    }
    L -> quantidade--;
  }
}

void imprime_lista(struct lista * L){
  int i;
  for(i = 0; i < L -> quantidade; i++){
    printf("%d\n", L -> elementos[i]);
  }
}

int busca_binaria(int *v, int e, int d, int x){
  int meio;
  while(e <= d){
      meio = (e + d)/2;
      if(v[meio] == x)
          return meio;
      else if(v[meio] < x)
          e = meio + 1;
      else
          d = meio - 1;
  }
  return -1;
}
