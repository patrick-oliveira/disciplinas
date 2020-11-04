#include <stdio.h>
#include <stdlib.h>

int busca_linear(int *, int, int);

int main(){
    int N, *V, M, a, i;
    
    scanf("%d", &N);
    V = (int *)malloc(N*sizeof(int));
    
    for(i = 0; i < N; i++){
        scanf("%d", &V[i]);
    }
    
    scanf("%d", &M);
    
    for(i = 0; i < M; i++){
        scanf("%d", &a);
        if(busca_linear(V, N, a)){
            printf("ACHEI\n");
        } else {
            printf("NAO ACHEI\n");
        }
    }
    
    return 0;
}

int busca_linear(int *V, int N, int a){
    if(N == 0){
        return 0;
    } else {
        if(V[N - 1] == a){
            return 1;
        } else {
            return busca_linear(V, N-1, a);
        }
    }
}