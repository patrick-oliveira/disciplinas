#include <stdio.h>
#include <stdlib.h>

typedef struct cel{
    int valor;
    struct cel * proximo;
} celula;

celula * head;

void empilha(int);
int desempilha(void);
void imprime(void);

int main(){
    int input;
    char operacao;
    head = malloc(sizeof(celula));
    head -> proximo = NULL;
    
    while(scanf("\n%c", &operacao) != EOF){
        if(operacao == 'E'){
            scanf("%d", &input);
            empilha(input);
        } else if(operacao == 'D'){
            int x = desempilha();
            if(x != -1)
                printf("[%d]\n", x);
        } else {
            imprime();
        }
    }    
    
    return 0;
}

void imprime(void){
    celula * p = head -> proximo;
    while(p != NULL){
        if(p -> proximo == NULL)
            printf("%d\n", p -> valor);
        else
            printf("%d ", p -> valor);
        p = p -> proximo;
    }
}

int desempilha(void){
    celula * lixo = head -> proximo;
    int x = -1;
    if(lixo != NULL){
        head -> proximo = lixo -> proximo;
        x = lixo -> valor;
        free(lixo);
    }
    return x;
}

void empilha(int input){
    celula * nova = (celula *)malloc(sizeof(celula));
    nova -> valor = input;
    nova -> proximo = head -> proximo;
    head -> proximo = nova;
}

