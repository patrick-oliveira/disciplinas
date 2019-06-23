#include <stdio.h>

int main(void){
    int original, i = 0;
    int invertido[4];
    
    
    scanf("%d", &original);
    
    do{
        invertido[i] = original%10;
        i++;
        original = (original - original%10)/10;
    }while(original != 0);
    
    for(i = 0; i < 4; i++){
        printf("%d", invertido[i]);
    }
    printf("\n");
    
    return 0;
}