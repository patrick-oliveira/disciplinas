#include <stdio.h>
#include <stdlib.h>

int main(void){
    int N, i, dir = 0; 
    char * p;
    
    scanf("%d", &N);
    
    char * comandos = (char *)malloc((N+1)*sizeof(int));
    p = comandos;
    
    scanf("%s", comandos);
    
    for(i = 0; i < N; i++){
        if(*p == 'D'){
            dir += 1;
        } else if (*p == 'E'){
            dir -= 1;
        }
        p++;
    }
    
    dir = dir%4;
    
    if(dir == 0){
        printf("N\n");
    } else if (dir == -1 || dir == 3){
        printf("O\n");
    } else if (dir == -2 || dir == 2){
        printf("S\n");
    } else if (dir == -3 || dir == 1){
        printf("L\n");
    }
    
    return 0;
}