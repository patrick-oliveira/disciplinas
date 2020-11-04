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
int contaFolhas(Node *);

int main(){
    Tree * Arvore = (Tree *)malloc(sizeof(Tree));
    Arvore -> raiz = NULL;
    int N, i, chave;
    
    scanf("%d", &N);
    for(i = 0; i < N; i++){
        scanf("%d", &chave);
        insereNodo(Arvore, criaNodo(chave));
    }

    printf("%d\n", contaFolhas(Arvore -> raiz));
}

int contaFolhas(Node * Nodo){
    if(Nodo -> esquerda == NULL && Nodo -> direita == NULL){
        return 1;
    } else {
        int qtde_e = 0, qtde_d = 0, qtde_t = 0;
        if(Nodo -> esquerda != NULL)
           qtde_e = contaFolhas(Nodo -> esquerda);
        if(Nodo -> direita != NULL)
           qtde_d = contaFolhas(Nodo -> direita);
        qtde_t = qtde_e + qtde_d;
        return qtde_t;
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


