#include <stdio.h>
#include <stdlib.h>

typedef enum {RED, BLACK} Cor;

typedef struct Nodo{
    int          key;
    Cor          cor;
    struct Node* pai;
    struct Node* esquerda;
    struct Node* direita;
} Nodo;
typedef struct Arvore{
    struct Node* raiz;
} Arvore;

/* Sentinela e ponteiro para sentinela, indicam que chegamos em alguma folha ou a     */
/* raiz de uma arvore. */
/* Entende-se que todos os nodos com chaves sao nodos internos da arvore, e as folhas */
/* sao o ponteiro para NIL. */
Nodo NIL_NODE;
Nodo* NIL_PTR = &NIL_NODE;

/* Aloca memoria e devolve o endereco de uma nova estrutura de Arvore RN.
   O ponteiro para a raiz é inicializado para NULL.*/
Arvore* nova_arvore();
/* ALoca e devolve o endereço de um novo nodo da árvore RN.
   Recebe um valor (chave) a ser atribuído ao nodo. Os ponteiros para o pai e filhos são
   inicialziados como NULL. A cor é definida como vermelho. */
Nodo* novo_nodo(int);
/* É feita uma inserção de um novo nodo (chave) na árvore RN.

   Parâmetros: uma árvore RB "T", uma chave "key" a ser inserida.
   Devolve: o endereço do nodo inserido, se o procedimento foi bem executado; NULL, caso contrário. */
Nodo* inserir_nodo(Arvore* T, int key);
/* Realiza uma rotação simples para a esquerda.

   Parâmetros: Uma árvore RB "T", um nodo "x" em torno do qual será feita a rotação.*/
void rotacao_esquerda(Arvore* T, Nodo* x);
/* Realiza uma rotação simples para a direita.

   Parâmetros: Uma árvore RB "T", um nodoo "x" em torno do qual será feita a rotação.*/
void rotacao_direita(Arvore* T, Nodo* x);
/* Realiza a troca de cor de alguns nós, sob certas condições.

   Parâmetros: Uma árvore RB "T", um nodo "x" a partir do qual será feita a recoloração.*/
void troca_cor(Arvore* T, Nodo* x);






int main(void){

    return 0;
}

Arvore* nova_arvore(){
    Arvore* T = (Arvore*)malloc(sizeof(Arvore));
    T->raiz = NULL;
    return T;
}
Nodo* novo_nodo(int key){
    Nodo* novo_nodo = (Nodo*)malloc(sizeof(Nodo));
    novo_nodo->key = key;
    novo_nodo->cor = RED;
    novo_nodo->pai = NULL;
    novo_nodo->esquerda = NULL;
    novo_nodo->direita  = NULL;
}
void rotacao_esquerda(Arvore* T, Nodo* x){
    Nodo* y = x->direita;
    x->direita = y->esquerda;
    if(y->esquerda != NULL){
        (y->esquerda)->pai = x;
    }
    y->pai = x->pai;
    if(x->pai == NULL){                            /* X é a raiz da árvore      */
        Arvore->raiz = y;
    } else if( (x->key) > (x->pai)->key ){         /* x é um filho da direta    */
        (x->pai)->direita  = y;
    } else {                                       /* x é um filho da esquerda  */
        (x->pai)->esquerda = y;
    }
    y->esquerda = x;
    x->pai = y;
}
void rotacao_direita(Arvore* T, Nodo* x){
    Nodo* y = x->esquerda;
    x->esquerda = y->direita;
    if(y->direita != NULL){
        (y->direita)->pai = x;
    }
    y->pai = x->pai;
    if(x->pai == NULL){                           /* x é a raiz da árvore       */
        Arvore->raiz = y;
    } else if ( (x->key) > (x->pai)->key ){       /* x é um filho da direita    */
        (x->pai)->direita  = y;
    } else {                                      /* x é um filho da esquerda   */
        (x->pai)->esquerda = y;
    }
    y->direita = x;
    x->pai = y;
}
void troca_cor(Arvore* T, Nodo* x){
    if( (x->cor) == RED) {
        if ( (x->pai)!= NULL && (x->pai)->cor == RED ){
            if( (x->pai)->key > ((x->pai)->pai)->key ){
                if( (((x->pai)->pai)->esquerda) != NULL && (((x->pai)->pai)->esquerda)->cor == RED){
                    (x->pai)->cor = BLACK
                    (((x->pai)->pai)->esquerda)->cor = BLACK
                    ((x->pai)->pai)->cor = RED
                }
            } else {
                if( (((x->pai)->pai)->direita)  != NULL && (((x->pai)->pai)->direita)->cor == RED){
                    (x->pai)->cor = BLACK
                    (((x->pai)->pai)->direita)->cor = BLACK
                    ((x->pai)->pai)->cor = RED
                }
            }
        }
    }
}
