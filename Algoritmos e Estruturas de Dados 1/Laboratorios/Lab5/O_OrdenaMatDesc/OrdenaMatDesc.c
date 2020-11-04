#include <stdio.h>
#include <stdlib.h>

int main(){
    int N, M, i, j, maior, aux;
    
    scanf("%d %d", &N, &M);
    
    int matriz[N][M];
    
    for(i = 0; i < N; i++){
        for(j = 0; j < M; j++){
            scanf("%d", &matriz[i][j]);
        }
    }
    
    int *p = *matriz;
    
    for(i = 0; i < N*M; i++){
        maior = i;
        for(j = i; j < N*M; j++)
            if(p[j] > p[maior])
                maior = j;
        aux = p[i];
        p[i] = p[maior];
        p[maior] = aux;
    }
    
    for(i = 0; i < N; i++){
        for(j = 0; j < M; j++){
            printf("%d ", matriz[i][j]);
        }
        printf("\n");
    }
    
    return 0;
}