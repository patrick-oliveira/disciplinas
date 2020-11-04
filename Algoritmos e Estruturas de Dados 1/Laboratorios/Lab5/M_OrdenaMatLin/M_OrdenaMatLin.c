#include <stdio.h>
#include <stdlib.h>


void selectionSort(int *, int);

int main(){
    int N, M, i, j;
    
    scanf("%d %d", &N, &M);
    int ** matriz;
    matriz = (int **)malloc(sizeof(int *)*N);
    for(i = 0; i < N; i++){
        matriz[i] = (int *)malloc(sizeof(int *)*M);
    }
    
    for(i = 0; i < N; i++){
        for(j = 0; j < M; j++){
            scanf("%d", &matriz[i][j]);
        }
    }
    
    for(i = 0; i < N; i++){
        selectionSort(matriz[i], M);
    }
    
    for(i = 0; i < N; i++){
        for(j = 0; j < M; j++){
            printf("%d ", matriz[i][j]);
        }
        printf("\n");
    }
    return 0;
}

void selectionSort(int * vetor, int N){
    int i, j, menor;
    int aux;
    
    for(i = 0; i < N; i++){
        menor = i;
        for(j = i; j < N; j++){
            if(vetor[j] < vetor[menor])
                menor = j;
        }
        aux = vetor[i];
        vetor[i] = vetor[menor];
        vetor[menor] = aux;
    }
}