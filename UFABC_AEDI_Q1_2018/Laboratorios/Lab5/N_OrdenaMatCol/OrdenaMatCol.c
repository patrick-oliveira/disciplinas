#include <stdio.h>
#include <stdlib.h>

int main(){
    int N, M, i, j, k, menor, aux;
    int ** matriz;
    
    scanf("%d %d", &N, &M);
    matriz = (int **)malloc(N*sizeof(int *));
    for(i = 0; i < N; i++){
        matriz[i] = (int *)malloc(sizeof(int)*M);
        for(j = 0; j < M; j++){
            scanf("%d", &matriz[i][j]);
        }
    }
    
    for(j = 0; j < M; j++){ // Define em qual coluna estou
    
        for(i = 0; i < N; i++){ // Aqui começa a ordenação de fato
            menor = i;
            for(k = i; k < N; k++)
                if(matriz[k][j] < matriz[menor][j])
                    menor = k;
            aux = matriz[i][j];
            matriz[i][j] = matriz[menor][j];
            matriz[menor][j] = aux;
        }
        
    }
        
    
    for(i = 0; i < N; i++){
        for(j = 0; j < M; j++){
            printf("%d ", matriz[i][j]);
        }
        printf("\n");
    }
    
    
    return 0;
}