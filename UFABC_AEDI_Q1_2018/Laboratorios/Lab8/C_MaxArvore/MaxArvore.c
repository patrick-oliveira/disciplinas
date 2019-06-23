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
int achaMaior(Tree *);

int main(){
    Tree * Arvore = (Tree *)malloc(sizeof(Tree));
    Arvore -> raiz = NULL;
    int N, i, chave;
    
    scanf("%d", &N);
    for(i = 0; i < N; i++){
        scanf("%d", &chave);
        insereNodo(Arvore, criaNodo(chave));
    }
    
    printf("%d\n", achaMaior(Arvore));
    
    return 0;
}

int achaMaior(Tree * Arvore){
    Node * buscador = Arvore -> raiz;
    while(buscador -> direita != NULL){
        buscador = buscador -> direita;
    }
    return buscador -> chave;
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
            } else {
                pai = filho;
                filho = filho -> esquerda;
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


