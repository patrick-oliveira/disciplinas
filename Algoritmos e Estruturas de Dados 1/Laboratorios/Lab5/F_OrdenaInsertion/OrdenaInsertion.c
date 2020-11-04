#include <stdio.h>
#include <stdlib.h>

int ordena(int *, int);
void imprime(int *, int);

int main(){
    int N, i;
    int * vetor;
    
    scanf("%d", &N);
    vetor = (int *)malloc(sizeof(int)*N);
    for(i = 0; i < N; i++)
        scanf("%d", &vetor[i]);
        
        
    imprime(vetor, N);    
    int cont = ordena(vetor, N);
    imprime(vetor, N);
    printf("Trocas:%d\n", cont);
    if(cont == (N*N - N)/2)
        printf("PIOR CASO\n");
    else if (cont == N - 1 || cont == 0)
        printf("MELHOR CASO\n");
    else
        printf("CASO ALEATORIO\n");
    return 0;
}

int ordena(int * vetor, int N){
    int i, j, x, cont = 0;
    for(i = 1; i < N; i++){
        x = vetor[i];
        j = i - 1;
        while(j >= 0 && vetor[j] > x){
            vetor[j + 1] = vetor[j];
            vetor[j] = x;
            j--;
            cont++;
            imprime(vetor, N);
        }
    }
    return cont;
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