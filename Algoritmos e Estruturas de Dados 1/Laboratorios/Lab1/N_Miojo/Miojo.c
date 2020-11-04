#include <stdio.h>

int main(void){
    int T, A, B, x = 0, y = 0;
    
    scanf("%d %d %d", &T, &A, &B);
    
    while(1){
        if((x*A - T)%B == 0){
            y = (T - x*A)/B;
            A = abs(x*A);
            B = abs(y*B);
            if(A > B){
                printf("%d\n", A);
            } else{
                printf("%d\n", B);
            }
            break;
        } else{
            x++;
        }
        if((y*A - T)%B == 0){
            x = (T - y*A)/B;
            A = abs(y*A);
            B = abs(x*B);
            if(A > B){
                printf("%d\n", A);
            } else{
                printf("%d\n", B);
            }
            break;
        } else{
            y--;
        }
    }
    
    return 0;
}