#include <stdio.h>
#include <stdlib.h>

void imprime(int *, int);
void insere(int *, int, int, int);
void ordena(int *, int);

int main(){
    int N, i, input;
    int * vetor;
    
    scanf("%d", &N);
    vetor = (int *)malloc(sizeof(int)*N);
    
    for(i = 0; i < N; i++){
        scanf("%d", &vetor[i]);
    }
    
    if(N != 1)
        ordena(vetor, N);
    else
        printf("%d\n", vetor[0]);
    return 0;
}

void ordena(int * vetor, int N){
    int i, j, x;
    for(i = 1; i < N; i++){
        x = vetor[i];
        j = i - 1;
        while(j >= 0 && vetor[j] > x){
            vetor[j + 1] = vetor[j];
            j--;
        }
        vetor[j + 1] = x;
        imprime(vetor, N);
    }
}

/*
void insere(int * vetor, int input, int N, int i){
    if(i == 0){
        vetor[i] = input;
        return;
    } else {
        int j = i - 1;
        while(j >= 0 && vetor[j] > input){
            vetor[j + 1] = vetor[j];
            j--;
        }
        vetor[j + 1] = input;
        imprime(vetor, N);
    }
}
*/

void imprime(int * vetor, int N){
    int i;
    for(i = 0; i < N; i++){
        if(i == N - 1)
            printf("%d\n", vetor[i]);
        else
            printf("%d ", vetor[i]);
    }
}