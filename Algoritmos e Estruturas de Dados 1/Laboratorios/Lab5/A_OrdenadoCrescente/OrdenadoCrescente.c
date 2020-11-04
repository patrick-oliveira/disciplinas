#include <stdio.h>
#include <stdlib.h>

int confereOrdenacao(int *, int);

int main(){
    int * vetor;
    int N, i;
    
    while(scanf("%d", &N) != EOF){
        vetor = (int *)malloc(N*sizeof(int));
        for(i = 0; i < N; i++)
            scanf("%d", &vetor[i]);
        if(confereOrdenacao(vetor, N))
            printf("S\n");
        else
            printf("N\n");
        free(vetor);
    }
    
    return 0;
}

int confereOrdenacao(int * vetor, int N){
    int i;
    for(i = 0; i < N - 1; i++){
        if(vetor[i] > vetor[i + 1])
            return 0;
    }
    return 1;
}