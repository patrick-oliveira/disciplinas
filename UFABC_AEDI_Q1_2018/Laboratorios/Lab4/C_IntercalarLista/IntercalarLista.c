#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int valor;
    struct Node * proximo;
} celula;

void inserir_elemento(int, celula *);
void imprime_lista(celula *);
void zerar_lista(celula *);
struct Node * mergeLists(struct Node *, struct Node *);

int main(){
    int Q, NA, NB, i, j, input;
    celula * head1 = (celula *)malloc(sizeof(celula));
    celula * head2 = (celula *)malloc(sizeof(celula));
    celula * head_intercalada;
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
        head_intercalada = mergeLists(head1, head2);
        imprime_lista(head_intercalada);
        zerar_lista(head1);
        zerar_lista(head2);
        zerar_lista(head_intercalada);
        free(head_intercalada);
    }
    
}

struct Node * mergeLists(struct Node * head1, struct Node * head2){
    celula * p;
    celula * head_novo = (celula *)malloc(sizeof(celula));
    head_novo -> proximo = NULL;
    for(p = head1 -> proximo; p != NULL; p = p -> proximo){
        inserir_elemento(p -> valor, head_novo);
    }
    for(p = head2 -> proximo; p != NULL; p = p -> proximo){
        inserir_elemento(p -> valor, head_novo);
    }
    return head_novo;
}

void inserir_elemento(int x, celula * head){
      celula *p1, *p2;
      p1 = head;
      p2 = p1 -> proximo;
      while(p2 != NULL && p2 -> valor < x){
        p1 = p2;
        p2 = p2 -> proximo;
      }
    
      celula * novo = (celula *)malloc(sizeof(celula));
      novo -> valor = x;
      novo -> proximo = p2;
      p1 -> proximo = novo;
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