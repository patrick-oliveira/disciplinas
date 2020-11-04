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
void mostrarFolhas(Node *);

int main(){
    Tree * Arvore = (Tree *)malloc(sizeof(Tree));
    Arvore -> raiz = NULL;
    int N, i, chave;
    
    scanf("%d", &N);
    for(i = 0; i < N; i++){
        scanf("%d", &chave);
        insereNodo(Arvore, criaNodo(chave));
    }
    
    mostrarFolhas(Arvore -> raiz);
}

void mostrarFolhas(Node * Nodo){
    if(Nodo -> esquerda == NULL && Nodo -> direita == NULL){
        printf("%d\n", Nodo -> chave);
    } else {
        if(Nodo -> esquerda != NULL)
            mostrarFolhas(Nodo -> esquerda);
        if(Nodo -> direita != NULL)
            mostrarFolhas(Nodo -> direita);
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


