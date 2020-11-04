#include <stdio.h>

int main(void){
    float H, P;
    float qtde_media;
    
    scanf("%f %f", &H, &P);
    
    qtde_media = H/P;
    
    printf("%.2f\n", qtde_media);
    
    return 0;
}