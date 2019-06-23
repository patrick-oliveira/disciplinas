#include <stdio.h>
#include <stdlib.h>
#include <string.h>



void selectionSort(char **, int);

int main(){
    int N, i;
    
    scanf("%d", &N);
    char ** vetor = (char **)malloc(sizeof(char *)*N);
    for(i = 0; i < N; i++){
        vetor[i] = (char*)malloc(sizeof(char)*1000);
        scanf("%s", vetor[i]);
    }
    selectionSort(vetor, N);
    for(i = 0; i < N; i++){
        printf("%s\n", vetor[i]);
    }
    return 0;
}

void selectionSort(char ** vetor, int N){
    int i, j, maior;
    char * aux;
    
    for(i = 0; i < N; i++){
        maior = i;
        for(j = i; j < N; j++){
            if(strlen(vetor[j]) >= strlen(vetor[maior])){
                maior = j;
            }
        }
        aux = vetor[i];
        vetor[i] = vetor[maior];
        vetor[maior] = aux;
    }
}