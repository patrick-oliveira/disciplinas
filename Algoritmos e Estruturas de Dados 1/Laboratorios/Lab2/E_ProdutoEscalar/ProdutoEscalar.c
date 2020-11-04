#include <stdio.h>
#include <stdlib.h>

long int produto_escalar(int, int *, int *);

int main(){
    int n, *A, *B, i;
    
    scanf("%d", &n);
    
    A = (int *)malloc(n*sizeof(int));
    B = (int *)malloc(n*sizeof(int));
    
    for(i = 0; i < n; i++)
        scanf("%d", &A[i]);
    for(i = 0; i < n; i++)
        scanf("%d", &B[i]);
        
    printf("%ld\n", produto_escalar(n, A, B));

    
    return 0;
}

long int produto_escalar(int n, int * A, int * B){
    if(n == 0){
        return 0;
    } else {
        return produto_escalar(n - 1, A, B) + A[n - 1]*B[n - 1];
    }
}