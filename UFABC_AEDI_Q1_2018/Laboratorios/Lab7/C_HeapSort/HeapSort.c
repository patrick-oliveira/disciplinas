#include <stdio.h>
#include <stdlib.h>
#define troca(A, B) { int t = A; A = B; B = t; };

void construir(int *, int);
void ordenar(int *, int);
void imprimirVetor(int * v, int N){
    int i;
    for(i = 0; i < N; i++) printf("%d%s", v[i], i < N - 1?" ":"\n");
}
void peneirar(int *, int, int);

int main(){
    int N, i;
    int *v;

    scanf("%d", &N);
    v = (int *)malloc(sizeof(int)*N);
    for(i = 0; i < N; i++)  scanf("%d", &v[i]);
    
    imprimirVetor(v, N);
    ordenar(v, N);
    imprimirVetor(v, N);
  
    
    
    return 0;
}

void ordenar(int * v, int N){
    int i;
    construir(v, N);
    for(i = N; i > 0; i--){
        troca(v[0], v[i - 1]);
        peneirar(v, i - 1, 0);
    }
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

int maior(int * v, int N, int pai, int filhoE, int filhoD){
    if(N%2 == 0 && pai == (N - 1)/2){
        if(v[filhoE] > v[pai]) return filhoE;
        else return pai;
    } else {
        int maior;
        if(v[filhoE] > v[filhoD]) maior = filhoE;
        else maior = filhoD;
        
        if(v[pai] > v[maior]) return pai;
        else return maior;        
    }
}

void peneirar(int * v, int N, int pai){
    if(pai >= N/2){
        return;
    } else{
        int m = maior(v, N, pai, filhoE(v, pai), filhoD(v, pai));
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

