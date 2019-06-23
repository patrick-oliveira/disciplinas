#include <stdio.h>

int main(void){
    int x, y, z, resto;
    
    scanf("%d %d", &x, &y);
    z = x/y;
    resto = x%y;
    
    printf("%d %d\n", z, resto);
    return 0;
}