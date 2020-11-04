#include <stdio.h>
#include <stdlib.h>

int main(){
    int N, i;
    int *v;
    
    scanf("%d", &N);
    
    v = (int *)malloc(N*sizeof(int));
    
    for(i = 0; i < N; i++)
        scanf("%d", &v[i]);
    
    for(i = N - 1; i >= 0; i--)
        if(i == 0){
            printf("%d\n", v[i]);
        }else{
            printf("%d ", v[i]);
        };
    
    return 0;
}