#include <stdio.h>
#include <stdlib.h>

typedef struct{
    int num;
    int den;
    double decimal;
} fracao;

struct lista{
    fracao * elementos;
    int quantidade;
    int maximo;
};

void imprime_lista(struct lista *);
void insere_elemento(struct lista *, fracao);
void remove_elemento(struct lista *, fracao);
int busca_elemento(fracao *, int, int, fracao);
struct lista cria_lista(int);

int main(){
    int N, i;
    fracao f;
    struct lista L;
    char operacao;
    
    scanf("%d", &N);
    L = cria_lista(N);
    
    while(1){
        scanf("\n%c", &operacao);
        if(operacao == 'M'){
            imprime_lista(&L);
        } else {
            scanf("%d %d", &f.num, &f.den);
            f.decimal = (double)f.num/(double)f.den;
            if(operacao == 'I'){
                insere_elemento(&L, f);
            } else if(operacao == 'R'){
                remove_elemento(&L, f);
            } else{
                if(busca_elemento(L.elementos, 0, L.quantidade - 1, f) == -1){
                    printf("NAO\n");
                } else{
                    printf("SIM\n");
                }
            }
        }   
    }
    imprime_lista(&L);
    return 0;
}

void remove_elemento(struct lista *L, fracao f){
    int i = busca_elemento(L -> elementos, 0, L -> quantidade - 1, f);
    int j;
    if (i != -1){
        for(j = i; j < L -> quantidade - 1; j++)
            L -> elementos[j] = L -> elementos[j + 1];
    }
    L -> quantidade--;
}

int busca_elemento(fracao * elementos, int e, int d, fracao f){
  int meio;
  while(e <= d){
      meio = (e + d)/2;
      if(elementos[meio].decimal == f.decimal)
          return meio;
      else if(elementos[meio].decimal < f.decimal)
          e = meio + 1;
      else
          d = meio - 1;
  }
  return -1;
}

void imprime_lista(struct lista *L){
    int i;
    for(i = 0; i < L -> quantidade; i++){
        if(i == L -> quantidade - 1){
            printf("%d/%d\n", L -> elementos[i].num, L -> elementos[i].den);
        } else
            printf("%d/%d ", L -> elementos[i].num, L -> elementos[i].den);
    }
}

void insere_elemento(struct lista * L, fracao f){
    int i = 0, achei = 0, j;
    
    while(i < L -> quantidade && !achei){
        if(f.decimal < L -> elementos[i].decimal){
            achei = 1;
        } else if(f.decimal == L -> elementos[i].decimal){
            return;
        } else
            i++;
    }
    for(j = L -> quantidade - 1; j >= i; j--){
        L -> elementos[j + 1] = L -> elementos[j];
    }
    L -> elementos[i] = f;
    L -> quantidade++;
}

struct lista cria_lista(int N){
    struct lista L_temp;
    L_temp.elementos = (fracao *)malloc(N*sizeof(fracao));
    L_temp.quantidade = 0;
    L_temp.maximo = N;
    return L_temp;
}