#include <stdio.h>
#include <stdlib.h>

void ordena(int *, int);
void imprimeListaOrdenada(int *, int);
void imprimeListaDesordenada(int *, int, int);

int main(){
    int N, i;
    int * vetor;
    
    scanf("%d", &N);
    vetor = (int *)malloc(sizeof(int)*N);
    
    for(i = 0; i < N; i++){
        scanf("%d", &vetor[i]);
    }
    
    ordena(vetor, N);
    
    return 0;
}

void ordena(int * vetor, int N){
    int i, j, k, x;
    for(i = 1; i < N; i++){
        imprimeListaOrdenada(vetor, i);
        imprimeListaDesordenada(vetor, i, N);
        x = vetor[i];
        j = i - 1;
        while(j >= 0 && vetor[j] > x){
            vetor[j + 1] = vetor[j];
            j--;
        }
        vetor[j + 1] = x;
    }
    imprimeListaOrdenada(vetor, N);
    imprimeListaDesordenada(vetor, N, N);
}

void imprimeListaDesordenada(int * vetor, int i, int N){
    int j;
    printf("Sublista Desordenada: ");
    if(i != N)
        for(j = i; j < N; j++){
            if(j == N - 1)
                printf("%d\n", vetor[j]);
            else
                printf("%d ", vetor[j]);
        }
    else{
        printf("\n");
        return;
    }
}

void imprimeListaOrdenada(int * vetor, int i){
    int j;
    printf("Sublista Ordenada: ");
    for(j = 0; j < i; j++){
        if(j == i - 1)
            printf("%d\n", vetor[j]);
        else
            printf("%d ", vetor[j]);
    }
}