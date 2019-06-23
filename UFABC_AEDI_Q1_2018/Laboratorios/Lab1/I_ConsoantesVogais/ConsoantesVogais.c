#include <stdio.h>

int main(void){
    char c;
    
    scanf("%c", &c);
    
    if(c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
     c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U'){
         printf("vogal\n");
     } else {
         printf("consoante\n");
    }
     
     return 0;
}