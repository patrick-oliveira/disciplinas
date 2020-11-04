#include <stdio.h>
#include <stdlib.h>

void ordena(int *, int);

int main(){
    int N, i;
    int * vetor;
    
    scanf("%d", &N);
    vetor = (int *)malloc(sizeof(int)*N);
    for(i = 0; i < N; i++)
        scanf("%d", &vetor[i]);
    
    ordena(vetor, N);
    return 0;
}

void ordena(int * vetor, int N){
    int i, j, x, cont = 0;
    for(i = 1; i < N; i++){
        x = vetor[i];
        j = i - 1;
        while(j >= 0 && vetor[j] > x){
            vetor[j + 1] = vetor[j];
            j--;
            cont++;
        }
        vetor[j + 1] = x;
    }
    printf("%d\n", cont);
}