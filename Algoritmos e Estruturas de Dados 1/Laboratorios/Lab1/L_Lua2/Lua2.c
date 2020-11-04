#include <stdio.h>
#include <stdlib.h>

int main(void){
    int N, M1, M2, i;
    
    scanf("%d", &N);
    
    int * vetor_medidas = (int *)malloc(2*N*sizeof(int));
    int * p = vetor_medidas;
    
    for(i = 0; i < N; i++){
        scanf("%d %d", p, p + 1);
        p += 2;
    }
    
    p = vetor_medidas;
    
    for(i = 0; i < N; i++){
        if(*p > *(p + 1)){
            if(*(p + 1) >= 3 && *(p + 1) <= 96){
                printf("Minguante\n");
            } else if (*(p + 1) >= 0 && *(p + 1) <= 2){
                printf("Nova\n");
            } else{
                printf("Cheia\n");
            }
        } else {
            if(*(p + 1) >= 3 && *(p + 1) <= 96){
                printf("Crescente\n");
            } else if (*(p + 1) >= 0 && *(p + 1) <= 2){
                printf("Nova\n");
            } else {
                printf("Cheia\n");
            }
        }
        p += 2;
    }

    
    return 0;
}