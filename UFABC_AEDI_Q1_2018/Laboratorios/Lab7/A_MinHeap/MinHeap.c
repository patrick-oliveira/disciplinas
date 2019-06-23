#include <stdio.h>
#include <stdlib.h>
#define troca(A, B) { int t = A; A = B; B = t; };

void construir(int *, int);
void imprimirVetor(int * v, int N){
    int i;
    for(i = 0; i < N; i++) printf("%d%s", v[i], i < N - 1?" ":"\n");
}

int main(){
    int N = -1, i;
    int *v;
 
    
    while(N != 0){
        scanf("%d", &N);
        v = (int *)malloc(sizeof(int)*N);
        for(i = 0; i < N; i++)  scanf("%d", &v[i]);
        construir(v, N);
        imprimirVetor(v, N);
        free(v);
    }
    
    
    return 0;
}

int filhoE(int * v, int ind){
    return 2*ind + 1;
}

int filhoD(int * v, int ind){
    return 2*ind + 2;
}

int Pai(int * v, int ind){
    if(ind != 0) return (ind - 1)/2;
}

int menor(int * v, int N, int pai, int filhoE, int filhoD){
    if(N%2 == 0 && pai == N/2 - 1){
        if(v[filhoE] > v[pai]) return pai;
        else return filhoE;
    } else {
        int menor;
        if(v[filhoE] >= v[filhoD]) menor = filhoD;
        else menor = filhoE;
        
        if(v[pai] > v[menor]) return menor;
        else return pai;        
    }
}

void peneirar(int * v, int N, int pai){
    if(pai >= N/2){
        return;
    } else{
        int m = menor(v, N, pai, filhoE(v, pai), filhoD(v, pai));
        if (m != pai){  
            troca(v[pai], v[m]);
            peneirar(v, N, m);
        }
    }
}

void construir(int * v, int N){
    int i;
    for(i = (N / 2) - 1; i >= 0; i--){
        peneirar(v, N, i);
    }
}