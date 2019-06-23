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
void removeNodo(Tree *, int);
Node * Antecessor(Node *);
void PreOrdem(Node *);

int main(){
    Tree * Arvore = (Tree *)malloc(sizeof(Tree));
    Arvore -> raiz = NULL;
    int N, i, chave;
    
    scanf("%d", &N);
    for(i = 0; i < N; i++){
        scanf("%d", &chave);
        insereNodo(Arvore, criaNodo(chave));
    }
    scanf("%d", &N);
    for(i = 0; i < N; i++){
        scanf("%d", &chave);
        removeNodo(Arvore, chave);
    }
    PreOrdem(Arvore -> raiz);
}

void PreOrdem(Node * raiz){
    if(raiz != NULL){
        printf("%d\n", raiz -> chave);
        PreOrdem(raiz -> esquerda);
        PreOrdem(raiz -> direita);
    }
}

void removeFolha(Node * pai, Node * filho, Tree * Arvore){
    if(pai != NULL){
        if(filho -> chave > pai -> chave){
            pai -> direita = NULL;
        } else {
            pai -> esquerda = NULL;
        }
    } else {
        Arvore -> raiz = NULL;
    }
    free(filho);
}

void removePai_UmFilho(Node * pai, Node * filho, Node * neto, Tree * Arvore){
    if(pai != NULL){
        if(filho -> chave > pai -> chave){
            pai -> direita = neto;
        } else {
            pai -> esquerda = neto;
        }
    } else {
        Arvore -> raiz = neto;
    }
    neto -> pai = pai;
    free(filho);
}

void removePai_DoisFilhos(Node * pai, Node * filho, Node * sucessor, Tree * Arvore){
    
    sucessor -> pai = pai;
    sucessor -> esquerda = filho -> esquerda;
    filho -> esquerda -> pai = sucessor;
    
    if(filho -> direita != sucessor){
        sucessor -> direita = filho -> direita;
        filho -> direita -> pai = sucessor;
    }    
    if(pai != NULL){
        if(filho -> chave > pai -> chave){
            pai -> direita = sucessor;
        } else {
            pai -> esquerda = sucessor;
        }
    } else {
       Arvore -> raiz = sucessor;
    }
    free(filho);
    
}

Node * Sucessor(Node * Nodo){
    Node * sucessor, * pt = Nodo;
    while(pt != NULL){ // procura o menor elemento da arvore da direita;
        sucessor = pt;
        pt = pt -> esquerda;
    } // ao fim do loop, sucessor esta com o endereço do nodo correto
    if(sucessor -> direita!= NULL){
        if(sucessor -> chave > sucessor -> pai -> chave){ // sucessor é um filho da direita
            if(sucessor != Nodo){
                sucessor -> pai -> direita = sucessor -> direita;
                sucessor -> direita -> pai = sucessor -> pai;
            }
        } else { // sucessor é um filho da esquerda
            if(sucessor != Nodo){
                sucessor -> pai -> esquerda = sucessor -> direita;
                sucessor -> direita-> pai = sucessor -> pai;
            }
        }
    } else { // antecessor não tem filhos
        if(sucessor -> chave > sucessor -> pai -> chave){
            if(sucessor != Nodo)
                sucessor -> pai -> direita = NULL;
        } else {
            if(sucessor != Nodo)
                sucessor -> pai -> esquerda = NULL;
        }
    }
    return sucessor;
}

void removeNodo(Tree * Arvore, int chave){
    if(Arvore -> raiz != NULL){
        Node * pai = NULL;
        Node * filho = Arvore -> raiz;
        
        while(filho != NULL && filho -> chave != chave){
            if(chave > filho -> chave){
                pai = filho;
                filho = filho -> direita;
            } else {
                pai = filho;
                filho = filho -> esquerda;
            }
        }
        
        if(filho != NULL){
            if(filho -> esquerda == NULL && filho -> direita == NULL){ // Folha
               removeFolha(pai, filho, Arvore);
            } else if(filho -> esquerda == NULL && filho -> direita != NULL){
               removePai_UmFilho(pai, filho, filho -> direita, Arvore);
            } else if(filho -> direita == NULL && filho -> esquerda != NULL){
               removePai_UmFilho(pai, filho, filho -> esquerda, Arvore);
            } else {
                removePai_DoisFilhos(pai, filho, Sucessor(filho -> direita), Arvore); // nesse ponto o antecessor é um nodo solto, resta inseri-lo
            }
        }
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


