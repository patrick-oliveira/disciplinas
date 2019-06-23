#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct cel{
    char chave;
    struct cel * proximo;
} celula;

struct pilha{
    celula * head;
    int quantidade;
};

void empilha(char);
char desempilha(void);
int checa_chaves(char *);

struct pilha Pilha;

int main(){
    char input, operacao;
    int N, i, ok;
    
    Pilha.head = (celula *)malloc(sizeof(celula));
    Pilha.head -> proximo = NULL;
    
    
    scanf("%d", &N);
    char * s = (char *)malloc(101*sizeof(char));
    for(i = 0; i < N; i++){
        __fpurge(stdin);
        fgets(s, 101, stdin);
        if(checa_chaves(s)){
            ok = 1;
        }
    }
    
    if(Pilha.quantidade != 0 || ok == 1){
        printf("NAO\n");
    } else{
        printf("SIM\n");
    }
    return 0;
}

int checa_chaves(char * s){
    int i;
    for(i = 0; s[i] != '\0'; i++){
        if(s[i] == '{'){
            empilha(s[i]);
        }
        else if(s[i] == '}'){
            char c = desempilha();
            if(c != '{'){
                return 1;
            }
        }
    }
    return 0;
}

char desempilha(void){
    celula * lixo = Pilha.head -> proximo;
    char c = -1;
    if(lixo != NULL){
        Pilha.head -> proximo = lixo -> proximo;
        c = lixo -> chave;
        free(lixo);
    }
    Pilha.quantidade--;
    return c;
}

void empilha(char input){
    celula * nova = (celula *)malloc(sizeof(celula));
    nova -> chave = input;
    nova -> proximo = Pilha.head -> proximo;
    Pilha.head -> proximo = nova;
    Pilha.quantidade++;
}

