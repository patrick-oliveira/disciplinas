#include <stdio.h>
#include <stdlib.h>

typedef struct cel {
    int valor;
    struct cel * proximo;
} celula;

void inserir(int);
void imprimir(void);
void remover(int);
celula * buscar(int);

celula * head;

int main(){
    int input;
    char operacao;
    head = (celula *)malloc(sizeof(celula));
    head -> proximo = NULL;
    
    while(scanf("\n%c", &operacao) != EOF){
        if(operacao == 'I'){
            scanf("%d", &input);
            inserir(input);
        } else if (operacao == 'R') {
            scanf("%d", &input);
            remover(input);
        } else if (operacao == 'B') {
            scanf("%d", &input);
            if(buscar(input) -> proximo != NULL)
                printf("SIM\n");
            else
                printf("NAO\n");
        } else {
            imprimir();
        }
    }
    return 0;
}

void remover(int input){
    celula * p = buscar(input);
    celula * lixo = p -> proximo;
    if(lixo != NULL){
        p -> proximo = lixo -> proximo;
        free(lixo);
    }
}

celula * buscar(int input){
    celula * p = head;
    while(p -> proximo != NULL){
        if(p -> proximo -> valor == input)
            return p;
        p = p -> proximo;
    }
    return p;
}

void inserir(int input){
    celula * p1, * p2;
    p1 = head;
    p2 = head -> proximo;
    while(p2 != NULL && p2 -> valor <= input){
        if(p2 -> valor == input)
            return;
        p1 = p2;
        p2 = p2 -> proximo;
    }
    celula * nova = (celula *)malloc(sizeof(celula));
    nova -> valor = input;
    p1 -> proximo = nova;
    nova -> proximo = p2;
}

void imprimir(void){
    celula * p = head -> proximo;
    
    while(p != NULL){
        if(p -> proximo == NULL)
            printf("%d\n", p -> valor);
        else
            printf("%d ", p -> valor);
        p = p -> proximo;
    }
}