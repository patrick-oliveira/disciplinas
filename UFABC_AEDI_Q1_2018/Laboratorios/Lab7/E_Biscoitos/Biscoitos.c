#include <stdio.h>
#include <stdlib.h>
#define troca(A, B) { int t = A; A = B; B = t; }

void construir(int *, int);
void peneirar(int *, int, int);
int menorFilho(int *, int, int, int, int);
int filhoE(int);
int filhoD(int);
int pai(int);

void imprimirVetor(int * v, int N){
    int i;
    for(i = 0; i < N; i++){
        printf("%d%s", v[i], i < N - 1?" ": "\n");
    }
}


int main(){
    int N, K, i, menor, qtde = 0, c = 1;
    int *biscoitos;
    
    scanf("%d %d", &N, &K);
    biscoitos = (int *)malloc(sizeof(int)*N);
    for(i = 0; i < N; i++) {
        scanf("%d", &biscoitos[i]);
        if(biscoitos[i] != 0);
    }
    
    imprimirVetor(biscoitos, N);
    if(N <= 1) {
        printf("%d\n", -1); // ha apenas um ou nenhum biscoito e o procedimento nao pode ser conduzido
    } else {
        construir(biscoitos, N); // construo o heap
        while(biscoitos[0] < K){
            if(biscoitos[1] > biscoitos[2]){
                biscoitos[0] = biscoitos[0] + 2*biscoitos[2];
                if(biscoitos[0] > biscoitos[1])
                    biscoitos[2] = biscoitos[2] + 2*biscoitos[1];
                else
                    biscoitos[2] = biscoitos[2] + 2*biscoitos[0];
            } else {
                biscoitos[0] = biscoitos[0] + 2*biscoitos[1];
                if(biscoitos[0] > biscoitos[2])
                    biscoitos[1] = biscoitos[1] + 2 *biscoitos[2];
                else
                    biscoitos[1] = biscoitos[1] + 2*biscoitos[0];
            }
            peneirar(biscoitos, N, 0);
            qtde++;
        }
        printf("%d\n", qtde);
    }
    
    return 0;
}

int filhoE(int ind){ return 2*ind + 1; }

int filhoD(int ind){ return 2*ind + 2; }

int pai(int ind){ if(ind != 0) return (ind - 1)/2; }

int menor(int * v, int N, int pai, int filhoE, int filhoD){
    if(N%2 == 0 && pai == (N - 1)/2){
        if(v[filhoE] > v[pai]) return pai;
        else return filhoE;
    } else {
        int menor;
        if(v[filhoE] > v[filhoD]) menor = filhoD;
        else menor = filhoE;
        
        if(v[pai] > v[menor]) return menor;
        else return pai;        
    }
}

void peneirar(int * v, int N, int pai){
    if(pai >= N/2){
        return;
    } else{
        int m = menor(v, N, pai, filhoE(pai), filhoD(pai));
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