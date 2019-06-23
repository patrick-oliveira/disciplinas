#include <stdio.h>
#include <stdlib.h>

long int ordenaSelection(int *, int);
void imprimeVetor(int *, int);

int main(){
    int N, i;
    long int qtde;
    int *vetor;
    
    scanf("%d", &N);
    vetor = (int *)malloc(N*sizeof(int));
    for(i = 0; i < N; i++){
        scanf("%d", &vetor[i]);
    }
    imprimeVetor(vetor, N);
    qtde = ordenaSelection(vetor, N);
    imprimeVetor(vetor, N);
    printf("%ld\n", qtde);
    
    return 0;
}

long int ordenaSelection(int * vetor, int N){
    int i, j, aux, menor;
    long int qtde = 0;
    
    for(i = 0; i < N - 1; i++){
        menor = i;
        for(j = i; j < N; j++){
            if(vetor[menor] > vetor[j]){
                menor = j;
                qtde++;
            }
        }
        aux = vetor[i];
        vetor[i] = vetor[menor];
        vetor[menor] = aux;
        imprimeVetor(vetor, N);
    }
    
    return qtde;
}

void imprimeVetor(int * vetor, int N){
    int i;
    for(i = 0; i < N; i++){
        if(i == N - 1)
            printf("%d\n", vetor[i]);
        else
            printf("%d ", vetor[i]);
    }
}