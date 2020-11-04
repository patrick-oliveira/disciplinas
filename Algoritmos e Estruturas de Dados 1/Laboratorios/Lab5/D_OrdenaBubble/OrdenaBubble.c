#include <stdio.h>
#include <stdlib.h>

long int ordenaBubble(int *, int);
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
    qtde = ordenaBubble(vetor, N);
    imprimeVetor(vetor, N);
    printf("Trocas: %ld\n", qtde);
    
    return 0;
}

long int ordenaBubble(int * vetor, int N){
    int i, j, aux;
    long int qtde = 0;
    for(i = 0; i < N - 1; i++){
        for(j = 0; j < N - 1 - i; j++){
            if(vetor[j] > vetor[j + 1]){
                aux = vetor[j];
                vetor[j] = vetor[j + 1];
                vetor[j + 1] = aux;
                imprimeVetor(vetor, N);
                qtde++;
            }
        }
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