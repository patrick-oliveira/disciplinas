#include <stdio.h>
#include <stdlib.h>

void ordena(int *, int);

int main(int argc, char ** argv){
    int q1 = atoi(argv[1]);
    int q2 = atoi(argv[2]);
    int i, input;
    int *v1 = (int *)malloc(sizeof(int)*q1);
    int *v2 = (int *)malloc(sizeof(int)*q2);
    int *v = (int *)malloc(sizeof(int)*(q1 + q2));
    srand(time(NULL));
    
    for(i = 0; i < q1; i++)
        v1[i] = rand()%100;
    
    for(i = 0; i < q2; i++)
        v2[i] = rand()%100;
    
    ordena(v1, q1);
    ordena(v2, q2);
    
    for(i = 0; i < q1; i++){
        v[i] = v1[i];
    }
    for(i = 0; i< q2; i++){
        v[i + q1] = v2[i];
    }
    
    printf("%d\n%d\n", q1, q2);
    for(i = 0; i < q1 + q2; i++)
        printf("%d ", v[i]);
    
}

void ordena(int * vetor, int N){
    int i, j, menor, aux;
    for(i = 0; i < N - 1; i++){
        menor = i;
        for(j = i+1; j < N; j++){
            if(vetor[j] < vetor[menor])
                menor = j;
        }
        aux = vetor[i];
        vetor[i] = vetor[menor];
        vetor[menor] = aux;
    }
}