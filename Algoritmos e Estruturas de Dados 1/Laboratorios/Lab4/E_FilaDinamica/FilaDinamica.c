#include <stdio.h>
#include <stdlib.h>

typedef struct cel{
    int valor;
    struct cel * proximo;
} celula;

celula * inserir_na_fila(int, celula *);
int excluir_da_fila(celula *);
void imprimir_lista(celula *);

int main(){
    int input;
    char operacao;
    celula * head = (celula *)malloc(sizeof(celula));
    head -> proximo = head;
    
    while(scanf("\n%c", &operacao) != EOF){
        if(operacao == 'E'){
            scanf("%d", &input);
            head = inserir_na_fila(input, head);
        } else if(operacao == 'D'){
            int x = excluir_da_fila(head);
            if(x != -1)
                printf("<%d>\n", x);
        } else {
            imprimir_lista(head);
        }
    }
    return 0;
}

void imprimir_lista(celula * head){
    celula * p = head -> proximo;
    while(p != head){
        if(p -> proximo == head)
            printf("%d\n", p -> valor);
        else
            printf("%d ", p -> valor);
        p = p -> proximo;
    }
}

int excluir_da_fila(celula * head){
    int x = -1;
    if(head -> proximo != head){
        celula * lixo = head -> proximo;
        x = lixo -> valor;
        head -> proximo = lixo -> proximo;
        free(lixo);
    }
    return x;
}

celula * inserir_na_fila(int input, celula * head){
    celula * nova_head = (celula *)malloc(sizeof(celula));
    head -> valor = input;
    nova_head -> proximo = head -> proximo;
    head -> proximo = nova_head;
    return nova_head;
}