#include <stdio.h>
#include <stdlib.h>

int t;

int main(){
    char ** pilha;
    int N, i;
    char operacao, string[200];
    
    scanf("%d", &N);
    pilha = (char **)malloc(N*sizeof(char *));
    t = 0;
    
    while(scanf("\n%c", &operacao) != EOF){
        if(operacao == 'E'){
            if(t < N){
                pilha[t] = (char *)malloc(200*sizeof(char));
                scanf("%s", pilha[t]);
                t++;
            }
        } else if(operacao == 'D'){
            if(t > 0)
                t--;
        } else if(operacao == 'T'){
            if(t > 0)
                printf("%s\n", pilha[t - 1]);
        } else if(operacao == 'X'){
            for(i = t - 1; i >= 0; i--){
                printf("%s ", pilha[i]);
            }
            printf("\n");
        } else {
            for(i = 0; i < t; i++){
                printf("%s ", pilha[i]);
            }
            printf("\n");
        }
    }
}