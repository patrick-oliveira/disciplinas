#include <stdio.h>
#include <stdlib.h>

typedef struct nodo{
    int chave;
    char * palavra;
    struct nodo * direita;
    struct nodo * esquerda;
    struct nodo * pai;
} Node;

typedef struct arv{
    struct nodo * raiz;
} Tree;

int comparaString(char *, char *);
Tree * iniciaArvore(void);
void PreOrder(Node *);
void PostOrder(Node *);
void InOrder(Node *);
void InsereNodo(Tree *, Node *);
Node * CriaNodo(char *);
Node * RemoveNodo(Tree *, Node *);
Node * EncontraNodo(Tree *, int);
void removeFolha(Node *, Node *, Tree *);
void removePai_UmFilho(Node *, Node *, Node *, Tree *);
void removePai_DoisFilhos(Node *, Node *, Node *, Tree *);
Node * Sucessor(Node *);

int main(){
    Tree * Arvore = iniciaArvore();
    char comando[11];
    char palavra[100];
    
    while(1){
        scanf("%s", comando);
        if(comparaString(comando, "insert")){
            scanf("%s", &palavra);
            InsereNodo(Arvore, CriaNodo(palavra));
        } else if(comparaString(comando, "delete")){
            scanf("%s", &palavra);
            Node * lixo = RemoveNodo(Arvore, EncontraNodo(Arvore, valor));
            free(lixo);
        } else if(comparaString(comando, "pre-order")){
            PreOrder(Arvore -> raiz); printf("\n");
        } else if(comparaString(comando, "in-order")){
            InOrder(Arvore -> raiz); printf("\n");
        } else if(comparaString(comando, "post-order")){
            PostOrder(Arvore -> raiz); printf("\n");
        }
    }
    return 0;
}

Node * EncontraNodo(Tree * Arvore, char chave){
    Node * pt = Arvore -> raiz;
    while(pt != NULL){
        if(chave > pt -> chave){
            pt = pt -> direita;
        } else if (chave < pt -> chave){
            pt = pt -> esquerda;
        } else{
            return pt;
        }
    }
    return NULL;
}

void removeFolha(Node * pai, Node * filho, Tree * Arvore){
    if(pai != NULL){
        if(filho -> chave >= pai -> chave){
            pai -> direita = NULL;
        } else {
            pai -> esquerda = NULL;
        }
    } else {
        Arvore -> raiz = NULL;
    }
}

void removePai_UmFilho(Node * pai, Node * filho, Node * neto, Tree * Arvore){
    if(pai != NULL){
        if(filho -> chave >= pai -> chave){
            pai -> direita = neto;
        } else {
            pai -> esquerda = neto;
        }
        neto -> pai = pai;
    } else {
        Arvore -> raiz = neto;
        neto -> pai = NULL;
    }
}

void removePai_DoisFilhos(Node * pai, Node * filho, Node * sucessor, Tree * Arvore){
    sucessor -> pai = pai;
    sucessor -> esquerda = filho -> esquerda;
    filho -> esquerda -> pai = sucessor;
    if(sucessor != filho -> direita){
        sucessor -> direita = filho -> direita;
        filho -> direita -> pai = sucessor;
    }
    if(pai != NULL){
        if(sucessor -> chave >= pai -> chave){
            pai -> direita = sucessor;
        } else {
            pai -> esquerda = sucessor;
        }
    } else {
        Arvore -> raiz = sucessor;
    }
}

Node * Sucessor(Node * Nodo){
    Node * suces;
    Node * pt = Nodo;
    
    while(pt != NULL){
        suces = pt;
        pt = pt -> esquerda;
    }
    
    if(suces -> direita != NULL){
        if(suces -> chave >= suces -> pai -> chave){
            if(suces != Nodo){
                suces -> pai -> direita = suces -> direita;
                suces -> direita -> pai = suces -> pai;
            }
        } else{
            if(suces != Nodo){
                suces -> pai -> esquerda = suces -> esquerda;
                suces -> esquerda -> pai = suces -> pai;
            }
        }
    } else {
        if(suces -> chave >= suces -> pai -> chave){
            if(Nodo != suces)
                suces -> pai -> direita = NULL;
        } else {
            if(Nodo != suces)
                suces -> pai -> esquerda = NULL;
        }
    }
    
    return suces;
}

Node * RemoveNodo(Tree * Arvore, Node * rmNodo){
    if(rmNodo != NULL){
        Node * pai = rmNodo -> pai;
        if(rmNodo -> esquerda == NULL && rmNodo -> direita == NULL){
            removeFolha(pai, rmNodo, Arvore);
        } else if (rmNodo -> esquerda != NULL && rmNodo -> direita == NULL){
            removePai_UmFilho(pai, rmNodo, rmNodo -> esquerda, Arvore);        
        } else if (rmNodo -> direita != NULL && rmNodo -> esquerda == NULL){
            removePai_UmFilho(pai, rmNodo, rmNodo -> direita, Arvore);
        } else {
            removePai_DoisFilhos(pai, rmNodo, Sucessor(rmNodo -> direita), Arvore);
        }
        return rmNodo;
    } else {
        return NULL;
    }
}

void InsereNodo(Tree * Arvore, Node * NovoNodo){
    if(Arvore -> raiz == NULL){
        Arvore -> raiz = NovoNodo;
    } else {
        Node * pai = NULL;
        Node * filho = Arvore -> raiz;
        while(filho != NULL){
            pai = filho;
            if(NovoNodo -> chave >= filho -> chave){
                filho = filho -> direita;
            } else {
                filho = filho -> esquerda;
            }
        }
        if(NovoNodo -> chave >= pai -> chave){
            pai -> direita = NovoNodo;
        } else {
            pai -> esquerda = NovoNodo;
        }
        NovoNodo -> pai = pai;
    }
}

Node * CriaNodo(char palavra[]){
    char * c = palavra;
    int chave = 0, qtde_letras = 0, i;
    while(c != '\0'){
        chave = chave + c++;
        qtde_letras++;
    }
    Node * temp = (Node*)malloc(sizeof(Node));
    char * p_temp = (char *)malloc(sizeof(char)*(qtde_letras+1));
    
    temp -> chave = chave;
    temp -> pai = NULL;
    temp -> direita = NULL;
    temp -> esquerda = NULL;
    return temp;
}

void PreOrder(Node * raiz){
    if(raiz != NULL){
        printf("[%d]%s ", raiz->chave, raiz -> palavra);
        PreOrder(raiz -> esquerda);
        PreOrder(raiz -> direita);
    }
}

void PostOrder(Node * raiz){
    if(raiz != NULL){
        PostOrder(raiz -> esquerda);
        PostOrder(raiz -> direita);
        printf("[%d]%s ", raiz->chave, raiz -> palavra);
    }
}

void InOrder(Node * raiz){
    if(raiz != NULL){
        InOrder(raiz -> esquerda);
        printf("[%d]%s ", raiz->chave, raiz -> palavra);
        InOrder(raiz -> direita);
    }
}

int comparaString(char s1[], char s2[]){
    char * c1 = s1;
    char * c2 = s2;
    while(*c1 != '\0' && *c2 != '\0'){
        if(*c1 != *c2){
            return 0;
        }
        c1++; c2++;
    }
    if(*c1 != *c2){
        return 0;
    } else {
        return 1;
    }
}

Tree * iniciaArvore(void){
    Tree * Arv = (Tree *)malloc(sizeof(Tree));
    Arv -> raiz = NULL;
    return Arv;
}