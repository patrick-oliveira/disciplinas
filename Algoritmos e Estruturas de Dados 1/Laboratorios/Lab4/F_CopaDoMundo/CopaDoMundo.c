#include <stdio.h>
#include <stdlib.h>

typedef struct t{
    char nome;
    struct t * proximo;
} compet;

void insere_elemento(compet *, char);
compet * tira_da_fila(compet *);
void imprime_fila(compet *);

int main(){   
    char c;
    int NA, NB, i;
    compet * head = (compet *)malloc(sizeof(compet));
    compet * aux;
    head -> proximo = NULL;
    
 
    
    for(c = 'A'; c <= 'P'; c++){
        insere_elemento(head, c);
    }
    
    imprime_fila(head);
    
    for(i = 0; i < 15; i++){
        scanf("%d %d", &NA, &NB);
        if(NA > NB){
            aux = tira_da_fila(head);
            insere_elemento(head, aux -> nome);
            free(aux);
            aux = tira_da_fila(head);
            free(aux);
        } else {
            aux = tira_da_fila(head);
            free(aux);
            aux = tira_da_fila(head);
            insere_elemento(head, aux -> nome);
            free(aux);
        }
    }
    imprime_fila(head);
    return 0;
}

void imprime_fila(compet * head){
    compet * p = head -> proximo;
    while(p != NULL){
        printf("%c ", p -> nome);
        p = p -> proximo;
    }
    printf("\n");
}

compet * tira_da_fila(compet * head){
    compet * p = head -> proximo;
    head -> proximo = p -> proximo;
    return p;
}

void insere_elemento(compet * head, char c){
    compet * p = head;
    while(p -> proximo != NULL) p = p -> proximo;
    
    compet * novo = (compet *)malloc(sizeof(novo));
    novo -> nome = c;
    p -> proximo = novo;
    novo -> proximo = NULL;
}
