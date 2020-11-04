#include <stdio.h>
#include <stdlib.h>
#define N 1000001



void selectionSort(char *);

int main(){
    char ch;
    char * vetor = (char *)malloc(sizeof(char)*N);
    int i = 0;
    
    while(scanf("%s", vetor) != EOF){
        selectionSort(vetor);
        printf("%s\n", vetor);
    }
    
    return 0;
}

void selectionSort(char * vetor){
    int i, j;
    int menor;
    char aux;
    
    for(i = 0; vetor[i] != '\0'; i++){
        menor = i;
        for(j = i; vetor[j] != '\0'; j++){
            if(vetor[j] < vetor[menor]){
                menor = j;
            }
        }
        aux = vetor[i];
        vetor[i] = vetor[menor];
        vetor[menor] = aux;
    }
}