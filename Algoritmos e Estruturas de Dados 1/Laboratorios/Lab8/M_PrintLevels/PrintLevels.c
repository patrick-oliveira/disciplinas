#include <stdio.h>
#include <stdlib.h>


typedef struct n {
    int chave;
    struct n * pai;
    struct n * esquerda;
    struct n * direita;
} Node;

typedef struct arv {
    struct n * raiz;
} Tree;

Node * criaNodo(int);
void insereNodo(Tree *, Node *);
int altura(Node *, int);
void imprimeNiveis(Node *, int, int);

int main(){
    Tree * Arvore = (Tree *)malloc(sizeof(Tree));
    Arvore -> raiz = NULL;
    int N, i, chave;
    
    scanf("%d", &N);
    for(i = 0; i < N; i++){
        scanf("%d", &chave);
        insereNodo(Arvore, criaNodo(chave));
    }
    
    int h = altura(Arvore -> raiz, 0);
    for(i = 0; i <= h; i++){
        imprimeNiveis(Arvore -> raiz, 0, i);
    }
    
    return 0;
}

void imprimeNiveis(Node * nodo, int nivelAtual, int h){
    if(nodo == NULL) return;
    else if(nivelAtual != h){
        imprimeNiveis(nodo -> esquerda, nivelAtual + 1, h);
        imprimeNiveis(nodo -> direita, nivelAtual + 1, h);
    } else {
        printf("%d\n", nodo -> chave);
    }
}

int altura(Node * Nodo, int h){
    if(Nodo == NULL){
        return h - 1;
    } else {
        int h_aux1 = altura(Nodo -> esquerda, h + 1);
        int h_aux2 = altura(Nodo -> direita, h + 1);
        if(h_aux1 > h_aux2) return h_aux1;
        else return h_aux2;
    }
}

Node * criaNodo(int chave){
    Node * temp = (Node *)malloc(sizeof(Node));
    if(temp != NULL){
        temp -> chave = chave;
        temp -> pai = NULL;
        temp -> esquerda = NULL;
        temp -> direita = NULL;
    }
    return temp;
}

void insereNodo(Tree * Arvore, Node * novo){
    if (Arvore -> raiz == NULL){
        Arvore -> raiz = novo;
    } else {
        Node * pai = NULL;
        Node * filho = Arvore -> raiz;
        while(filho != NULL){
            if(novo -> chave > filho -> chave){
                pai = filho;
                filho = filho -> direita;
            } else if (novo -> chave < filho -> chave){
                pai = filho;
                filho = filho -> esquerda;
            } else {
                free(novo);
                return;
            }
        }
        if(novo -> chave > pai -> chave){
            pai -> direita = novo;
        } else {
            pai -> esquerda = novo;
        }
        novo -> pai = pai;
    }
}


