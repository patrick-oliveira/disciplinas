#include <stdio.h>
#include <stdlib.h>

typedef struct Node{
    int valor;
    struct Node * proximo;
} celula;

void cria_lista(int, celula *);
void imprime_lista(celula *);
void zera_lista(celula *);
struct Node * reverseList(struct Node *);

int main(){
    int Q, N, i, j, input;
    celula * head = (celula *)malloc(sizeof(celula));
    head -> proximo = NULL;
    
    
    scanf("%d", &Q);
    for(i = 0; i < Q; i++){
        scanf("%d", &N);
        for(j = 0; j < N; j++){
            scanf("%d", &input);
            cria_lista(input, head);
        }
        head -> proximo = reverseList(head);
        imprime_lista(head);
        zera_lista(head);
    }
    return 0;
}

struct Node * reverseList(struct Node * head){
    celula *p0, * p1, * p2;
    p0 = head -> proximo;
    if(p0 == NULL){
        return p0;
    } else {
        p1 = p0;
        p2 = p1 -> proximo;
        while(p2 != NULL){
            p0 -> proximo = p2 -> proximo;
            p2 -> proximo = p1;
            p1 = p2;
            p2 = p0 -> proximo;
        }
    }
    p0 -> proximo = NULL;
    return p1;
}

void cria_lista(int input, celula * head){
    celula * novo = (celula *)malloc(sizeof(celula));
    novo -> proximo = NULL;
    novo -> valor = input;
    celula * p = head;
    while (p -> proximo != NULL)
        p = p -> proximo;
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

void zera_lista(celula * head){
  celula * lixo;
  while(head -> proximo != NULL){
    lixo = head -> proximo;
    head -> proximo = lixo -> proximo;
    free(lixo);
  }
}