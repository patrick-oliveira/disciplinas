#include <stdio.h>
#include <stdlib.h>

typedef enum {RED, BLACK} Color;
typedef struct Nodo{
    int   key;
    Color cor;
    struct Nodo* pai;
    struct Nodo* esquerda;
    struct Nodo* direita;
} Nodo;
typedef struct Arvore{
    struct Nodo* raiz;
} Arvore;

Arvore* cria_arvore();
Nodo* novo_nodo(int key);
Nodo* inserir_nodo(Arvore* T, Nodo* z);
void corrige_insercao(Arvore* T, Nodo *x);
void rotacao_esquerda(Arvore* T, Nodo* x);
void rotacao_direita (Arvore* T, Nodo* x);
void troca_cor(Arvore* T, Nodo* x, Nodo* tio);
void PreOrder(Nodo* raiz);
int altura(Nodo * Nodo, int h);





int main(void){
    int key;
    Arvore* T = cria_arvore();
    while( scanf("%d", &key) != EOF ){
        inserir_nodo(T, novo_nodo(key));
        PreOrder(T->raiz);
    }



}

Arvore* cria_arvore(){
    Arvore* nova_arvore = (Arvore*)malloc(sizeof(Arvore));
    nova_arvore->raiz = NULL;
    return nova_arvore;
}
Nodo* novo_nodo(int key){
    Nodo* novo_nodo = (Nodo*)malloc(sizeof(Nodo));
    if (novo_nodo == NULL) return NULL;
    novo_nodo->key = key;
    novo_nodo->cor = RED;
    novo_nodo->pai = NULL;
    novo_nodo->esquerda = NULL;
    novo_nodo->direita  = NULL;
    return novo_nodo;
}
void rotacao_esquerda(Arvore* T, Nodo* x){
    Nodo* y = x->direita;
    x->direita = y->esquerda;
    if (y->esquerda != NULL){
        (y->esquerda)->pai = x;
    }
    y->pai = x->pai;
    if( (x->pai) == NULL){
        T->raiz = y;
    } else if (x == (x->pai)->esquerda){
        (x->pai)->esquerda = y;
    } else {
        (x->pai)->direita  = y;
    }
    y->esquerda = x;
    x->pai = y;
}
void rotacao_direita (Arvore* T, Nodo* x){
    Nodo* y = x->esquerda;
    x->esquerda = y->direita;
    if (y->direita != NULL){
        (y->direita)->pai = x;
    }
    y->pai = x->pai;
    if ( (x->pai) == NULL ){
        T->raiz = y;
    } else if (x == (x->pai)->esquerda){
        (x->pai)->esquerda = y;
    } else {
        (x->pai)->direita = y;
    }
    y->direita = x;
    x->pai = y;
}
Nodo* inserir_nodo(Arvore* T, Nodo* z){
    Nodo* x = T->raiz;
    Nodo* y = NULL;
    while (x != NULL){
        y = x;
        if(y->key > z-> key){
            x = x->esquerda;
        } else {
            x = x->direita;
        }
    }                                  /* At the end of the loop, y will point to the right father of z. */
    if (y == NULL){                    /* The tree is empty.                                             */
        T->raiz = z;
        z->cor = BLACK;
    } else {
        if(y->key > z-> key){
            y->esquerda = z;
        } else {
            y->direita  = z;
        }
    }
    z->pai = y;
    corrige_insercao(T, z);
    return z;
}
void troca_cor(Arvore* T, Nodo* x, Nodo* tio){
    (x->pai)->cor = BLACK;
    tio->cor      = BLACK;
    ((x->pai)->pai)->cor = RED;
}
void corrige_insercao(Arvore* T, Nodo *z){
    Nodo* y;
    if(z->pai == NULL){       /*
                                 By recursion, the function is at the root, which is red by this point;
                                 What needs to be done is recoloring the root to Black.
                              */
        z -> cor = BLACK;
        return;
    }
    while( (z->pai) != NULL && (z->pai)->cor == RED ){

        if(z->pai == ((z->pai)->pai)->esquerda){
            y = ((z->pai)->pai)->direita;
            if (y != NULL && y->cor == RED){
                troca_cor(T, z, y);
                z = (z->pai)->pai;
                corrige_insercao(T, z);
            } else {
                if(z == (z->pai)->direita){
                    z = z->pai;
                    rotacao_esquerda(T, z);
                }
                (z->pai)->cor = BLACK;
                ((z->pai)->pai)->cor = RED;
                rotacao_direita(T, (z->pai)->pai);
            }
        } else {
            y = ((z->pai)->pai)->esquerda;
            if (y != NULL && y->cor == RED){
                troca_cor(T, z, y);
                z = (z->pai)->pai;
                corrige_insercao(T, z);
            } else {
                if(z == (z->pai)->esquerda){
                    z = z->pai;
                    rotacao_direita(T, z);
                }
                (z->pai)->cor = BLACK;
                ((z->pai)->pai)->cor = RED;
                rotacao_esquerda(T, (z->pai)->pai);
            }
        }

    }
}
void PreOrder(Nodo* raiz){
    if(raiz != NULL){
        printf("%d ", raiz->key);
        PreOrder(raiz -> esquerda);
        PreOrder(raiz -> direita);
    }
}
int altura(Nodo * Nodo, int h){
    if(Nodo == NULL){
        return h - 1;
    } else {
        int h_aux1 = altura(Nodo -> esquerda, h + 1);
        int h_aux2 = altura(Nodo -> direita, h + 1);
        if(h_aux1 > h_aux2) return h_aux1;
        else return h_aux2;
    }
}

