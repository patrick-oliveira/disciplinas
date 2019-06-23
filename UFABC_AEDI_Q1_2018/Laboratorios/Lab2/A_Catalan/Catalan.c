#include <stdio.h>

int serie_catalan(int);

int main(){
    int n;
    
    do{
        scanf("%d", &n);
        if(n != -1){
            printf("%d\n", serie_catalan(n));
        }
    }while(n != -1);
    
    return 0;
}

int serie_catalan(int n){
    if(n == 0){
        return 1;
    } else{
        return (serie_catalan(n - 1)*(4*n - 2))/(n + 1);
    }
}