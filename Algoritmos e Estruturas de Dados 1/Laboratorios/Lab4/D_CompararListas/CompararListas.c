#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int valor;
    struct Node * proximo;
} celula;

void inserir_elemento(int, celula *);
void imprime_lista(celula *);
void zerar_lista(celula *);
int compareLists(struct Node *, struct Node *);

int main(){
    int Q, NA, NB, i, j, input;
    celula * head1 = (celula *)malloc(sizeof(celula));
    celula * head2 = (celula *)malloc(sizeof(celula));
    head1 -> proximo = NULL;
    head2 -> proximo = NULL;
    
    scanf("%d", &Q);
    for(i = 0; i < Q; i++){
        scanf("%d", &NA);
        for(j = 0; j < NA; j++){
            scanf("%d", &input);
            inserir_elemento(input, head1);
        }
        scanf("%d", &NB);
        for(j = 0; j < NB; j++){
            scanf("%d", &input);
            inserir_elemento(input, head2);
        }
        printf("%d\n", compareLists(head1, head2));
        zerar_lista(head1);
        zerar_lista(head2);
    }
    
}

int compareLists(struct Node * head1, struct Node * head2){
    celula * p1 = head1 -> proximo;
    celula * p2 = head2 -> proximo;
    
    while(p1 != NULL || p2 != NULL){
        if((p1 == NULL && p2 != NULL) || (p1 != NULL && p2 == NULL))
            return 0;
        if(p1 -> valor != p2 -> valor)
            return 0;
        p1 = p1 -> proximo;
        p2 = p2 -> proximo;
    }
    return 1;
}

void inserir_elemento(int x, celula * head){
    celula * p;
    for(p = head; p -> proximo != NULL; p = p -> proximo);

    celula * novo;
    novo = (celula *)malloc(sizeof(celula));
    novo -> valor = x;
    novo -> proximo = NULL;
    p -> proximo = novo;
}

void imprime_lista(celula * head){
    celula * p = head -> proximo;
    while(p != NULL){
        if(p -> proximo == NULL)
            printf("%d\n", p -> valor);
        else
            printf("%d ", p -> valor);
        p = p -> proximo;
    }
}

void zerar_lista(celula * head){
    celula * lixo;
    while(head -> proximo != NULL){
        lixo = head -> proximo;
        head -> proximo = lixo -> proximo;
        free(lixo);
    }
}