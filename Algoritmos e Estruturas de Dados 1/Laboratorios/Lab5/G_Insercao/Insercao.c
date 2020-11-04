#include <stdio.h>
#include <stdlib.h>

void imprime(int *, int);

int main(){
    int N, i, j, x;
    int * vetor;
    
    scanf("%d", &N);
    vetor = (int *)malloc(sizeof(int)*N);
    
    for(i = 0; i < N; i++){
        scanf("%d", &vetor[i]);
    }
    
    x = vetor[N - 1];
    j = N - 2;
    while(j >= 0 && vetor[j] > x){
        vetor[j + 1] = vetor[j];
        j--;
        imprime(vetor, N);
    }
    vetor[j + 1] = x;
    
    imprime(vetor, N);
    return 0;
}

void imprime(int * vetor, int N){
    int i;
    for(i = 0; i < N; i++){
        if(i == N - 1)
            printf("%d\n", vetor[i]);
        else
            printf("%d ", vetor[i]);
    }
}