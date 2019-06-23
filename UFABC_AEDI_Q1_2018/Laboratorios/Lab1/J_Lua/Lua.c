#include <stdio.h>

int main(void){
    int M1, M2;
    
    scanf("%d %d", &M1, &M2);
    
    if(M1 > M2){
        if(M2 >= 3 && M2 <= 96){
            printf("Minguante\n");
        } else if (M2 >= 0 && M2 <= 2){
            printf("Nova\n");
        } else{
            printf("Cheia\n");
        }
    } else {
        if(M2 >= 3 && M2 <= 96){
            printf("Crescente\n");
        } else if (M2 >= 0 && M2 <= 2){
            printf("Nova\n");
        } else {
            printf("Cheia\n");
        }
    }
    
    return 0;
}