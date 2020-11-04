#include <stdio.h>

int main(){
    char palavra[101];
    char *p;
    int i = 0;
    
    while(scanf("%s", palavra) != EOF){
        p = palavra;
        i = 0;
        while(*p != '\0'){
            p++;
            i++;
        }
        p--;
        i--;
        while(i >= 0){
            if(i == 0){
                printf("%c\n", *p);
                p--;
                i--;
            } else {
                printf("%c", *p);
                p--;
                i--;
            }
        }
    }
    
    return 0;
}