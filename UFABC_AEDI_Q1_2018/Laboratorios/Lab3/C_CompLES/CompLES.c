#include <stdio.h>
#include <stdlib.h>


struct lista{
    int * elementos;
    int quantidade;
    int tamanho;
};

struct lista cria_lista(int);
void insere_elemento(struct lista *, int);
void remove_elemento(struct lista *, int);
int busca_elemento(int *, int, int, int);

int main(){
    struct lista L1, L2;
    int q, r, i, x;
    char operacao;
    
    scanf("%d %d", &q, &r);
    
    L1 = cria_lista(q);
    L2 = cria_lista(r);
    
    for(i = 0; i < q; i++){
        scanf("\n%c %d", &operacao, &x);
        if(operacao == 'I'){
            insere_elemento(&L1, x);
        } else {
            remove_elemento(&L1, x);
        }
    }
    for(i = 0; i < r; i++){
        scanf("\n%c %d", &operacao, &x);
        if(operacao == 'I'){
            insere_elemento(&L2, x);
        } else {
            remove_elemento(&L2, x);
        }
    }
    
    for(i = 0; i < L1.quantidade; i++){
        int j = busca_elemento(L2.elementos, 0, L2.quantidade, L1.elementos[i]);
        if(j == -1){
            printf("NAO\n");
            return 0;
        }
    }
    printf("SIM\n");
    return 0;
}

void remove_elemento(struct lista * L, int x){
    int i = busca_elemento(L -> elementos, 0, L -> quantidade - 1, x);
    int j;
    if(i != -1){
        for(j = i; j < L -> quantidade - 1; j++){
            L -> elementos[j] = L -> elementos[j + 1];
        }
        L -> quantidade--;
    }
}

void insere_elemento(struct lista * L, int x){
    int i = 0, achei = 0, j;
    while(i < L -> quantidade && !achei){
        if(L -> elementos[i] == x){
            return;
        } else if(L -> elementos[i] > x){
            achei = 1;
        } else {
            i++;
        }
    }
    if(L -> quantidade != L -> tamanho){
        for(j = L -> quantidade - 1; j >= i; j--){
            L -> elementos[j + 1] = L -> elementos[j];
        }
        L -> elementos[i] = x;
        L -> quantidade++;        
    }
}

int busca_elemento(int *v, int e, int d, int x){
    int meio;
    while(e <= d){
        meio = (e + d)/2;
        if(v[meio] == x){
            return meio;
        } else if(v[meio] > x){
            d = meio - 1;
        } else {
            e = meio + 1;
        }
    }
    return -1;
}

struct lista cria_lista(int n){
    struct lista L_temp;
    L_temp.elementos = (int *)malloc(n*sizeof(int));
    L_temp.quantidade = 0;
    L_temp.tamanho = n;
    
    return L_temp;
}