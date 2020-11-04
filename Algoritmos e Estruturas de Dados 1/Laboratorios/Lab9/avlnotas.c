#include <stdio.h>
#include <stdlib.h>

typedef struct al {
    int RA;
    int nota;
} aluno;

typedef struct noh {
    struct al Aluno;
    struct noh * pai;
    struct noh * esquerda;
    struct noh * direita;
} Node;

typedef struct tr{
    struct noh * raiz;
} Tree;


Tree * iniciaArvore(void);
Node * criaNodo(int, int);
void insereNodo(Tree *, Node *);
void posOrdem(Node *);
Node * buscaNodo(Tree *, int);
void removeNodo(Tree *, Node *);
void aux_removeFolha(Tree *, Node *);
void aux_remove1Filho(Tree *, Node *);
void aux_remove2Filhos(Tree *, Node *, Node *);
Node * Sucessor(Node *);
int altura(Node *, int);
void rotacionaEsquerda(Tree *, Node *);
void rotacionaDireita(Tree *, Node *);
void Balanceia(Tree *, Node *);

int comparacoes;
int aux_balanceia;

int main(){
    Tree * Arv = iniciaArvore();
    char operacao;
    int RA, nota;
    
    while(1){
        scanf("\n%c", &operacao);
        if(operacao == 'I'){
           scanf("%d %d", &RA, &nota);
           insereNodo(Arv, criaNodo(RA, nota));
        } else if (operacao == 'R'){
            scanf("%d", &RA);
            removeNodo(Arv, buscaNodo(Arv, RA));
        } else if (operacao == 'B'){
            scanf("%d", &RA);
            comparacoes = 0;
            Node * aux = buscaNodo(Arv, RA);
            if(aux != NULL){
                printf("C=%d Nota=%d\n", comparacoes, aux -> Aluno.nota);
            }
        } else if (operacao == 'A'){
            printf("A=%d\n", altura(Arv -> raiz, 0));
        } else { // operacao == 'P'
            printf("[");
            posOrdem(Arv -> raiz);
            printf("]\n");
            free(Arv);
            return 0;
        }
    }
    
    return 0;
}

Tree * iniciaArvore(void){
    Tree * temp = (Tree*)malloc(sizeof(Tree));
    temp -> raiz = NULL;
    return temp;
}

Node * criaNodo(int RA, int nota){
    Node * temp = (Node *)malloc(sizeof(Node));
    temp -> Aluno.RA = RA;
    temp -> Aluno.nota = nota;
    temp -> pai = NULL;
    temp -> esquerda = NULL;
    temp -> direita = NULL;
    return temp;
}

void insereNodo(Tree * Arvore, Node * NovoNodo){
    if(Arvore -> raiz == NULL){
        Arvore -> raiz = NovoNodo;
        printf("[Ja esta balanceado]\n");
    } else {
        Node * pai = NULL;
        Node * filho = Arvore -> raiz;
        while(filho != NULL){
            if(NovoNodo -> Aluno.RA > filho -> Aluno.RA){
                pai = filho;
                filho = filho -> direita;
            } else if(NovoNodo -> Aluno.RA < filho -> Aluno.RA){
                pai = filho;
                filho = filho -> esquerda;
            } else { // encontrou um nodo com RA igual: atualiza a nova
                filho -> Aluno.nota = NovoNodo -> Aluno.nota;
                free(NovoNodo);
                return;
            }
        }
        if(NovoNodo -> Aluno.RA > pai -> Aluno.RA){ // novo filho da direita
            pai -> direita = NovoNodo;
        } else { // novo filho da esquerda
            pai -> esquerda = NovoNodo;
        }
        NovoNodo -> pai = pai;
        aux_balanceia = 0;
        Balanceia(Arvore, pai);
        if(aux_balanceia == 0)
            printf("[Ja esta balanceado]\n");
    }
}

void posOrdem(Node * raiz){
    if(raiz != NULL){
        posOrdem(raiz -> esquerda);
        posOrdem(raiz -> direita);
        printf("%d ", raiz -> Aluno.RA);
    }
}

Node * buscaNodo(Tree * Arvore, int RA){
    Node * buscador = Arvore -> raiz;
    while(buscador != NULL){
        comparacoes++;
        if(RA > buscador -> Aluno.RA){
            buscador = buscador -> direita;
        } else if (RA < buscador -> Aluno.RA) {
            buscador = buscador -> esquerda;
        } else { // encontrou
            return buscador;
        }
    }
    return buscador; // se chegar aqui, retorna NULL
}

void removeNodo(Tree * Arvore, Node * Descarte){
    if(Descarte != NULL){
        if(Descarte -> direita == NULL && Descarte -> esquerda == NULL){        // noh folha
            aux_removeFolha(Arvore, Descarte);
        } else if(Descarte -> direita != NULL && Descarte -> esquerda != NULL){ // dois filhos
            aux_remove2Filhos(Arvore, Descarte, Sucessor(Descarte -> direita));
        } else {                                                                // 1 filho
            aux_remove1Filho(Arvore, Descarte);
        }
    }
}

void aux_removeFolha(Tree * Arvore, Node * Descarte){
    Node * pai = Descarte -> pai;
    if(pai == NULL){ // eh a raiz da arvore
        Arvore -> raiz = NULL;
    } else { 
        if(Descarte -> Aluno.RA > pai -> Aluno.RA){ // eh filho da direita
            pai -> direita = NULL;
        } else {                                    // eh filho da esquerda
            pai -> esquerda = NULL;
        }
    }
    free(Descarte);
    aux_balanceia = 0;
    Balanceia(Arvore, pai);
    if(aux_balanceia == 0)
            printf("[Ja esta balanceado]\n");
}

void aux_remove1Filho(Tree * Arvore, Node * Descarte){
    Node * pai = Descarte -> pai;
    if(Descarte -> direita != NULL && Descarte -> esquerda == NULL){ // tem um filho na direita
        if(pai == NULL){ // eh raiz
            Arvore -> raiz = Descarte -> direita;
        } else {
            if(Descarte -> Aluno.RA > pai -> Aluno.RA){
                pai -> direita = Descarte -> direita;
            } else {
                pai -> esquerda = Descarte -> direita;
            }
        }
        Descarte -> direita -> pai = pai;
    } else { // tem um filho na esquerda
        if(pai == NULL){ // eh raiz
            Arvore -> raiz = Descarte -> esquerda;
        } else {
            if(Descarte -> Aluno.RA > pai -> Aluno.RA){
                pai -> direita = Descarte -> esquerda;
            } else {
                pai -> esquerda = Descarte -> esquerda;
            }
        }
        Descarte -> esquerda -> pai = pai; 
    }
    free(Descarte);
    aux_balanceia = 0;
    Balanceia(Arvore, pai);
    if(aux_balanceia == 0)
            printf("[Ja esta balanceado]\n");
}

void aux_remove2Filhos(Tree * Arvore, Node * Descarte, Node * sucessor){
    Node * pai_aux = Descarte -> pai;
    sucessor -> pai = pai_aux;
    sucessor -> esquerda = Descarte -> esquerda;
    Descarte -> esquerda -> pai = sucessor;
    if(sucessor != Descarte -> direita){
        sucessor -> direita = Descarte -> direita;
        Descarte -> direita -> pai = sucessor;
    }
    
    if(pai_aux == NULL){
        Arvore -> raiz = sucessor;
    } else {
        if(Descarte -> Aluno.RA > pai_aux -> Aluno.RA){
            pai_aux -> direita = sucessor;
        } else {
            pai_aux -> esquerda = sucessor;
        }
    }
    free(Descarte);
    aux_balanceia = 0;
    Balanceia(Arvore, sucessor);
    if(aux_balanceia == 0)
            printf("[Ja esta balanceado]\n");
}

Node * Sucessor(Node * Nodo){
    Node * sucessor, * aux = Nodo;
    while(aux != NULL){
        sucessor = aux;
        aux = aux -> esquerda;
    }
    if(sucessor != Nodo)
        if(sucessor -> direita == NULL){
            sucessor -> pai -> esquerda = NULL;
        } else {
            sucessor -> direita -> pai = sucessor -> pai;
            sucessor -> pai -> esquerda = sucessor -> direita;
        }
    return sucessor;
}

int altura(Node * raiz, int h){
    if(raiz == NULL){
        return h - 1;
    } else {
        int h_esquerda = altura(raiz -> esquerda, h + 1);
        int h_direita = altura(raiz -> direita, h + 1);
        if(h_esquerda > h_direita){
            return h_esquerda;
        } else {
            return h_direita;
        }
    }
}

void rotacionaEsquerda(Tree * Arvore, Node * X){
    Node * Y = X -> direita;
    Node * pai = X -> pai;
    Y -> pai = pai;
    
    X -> direita = Y -> esquerda;
    if(Y -> esquerda != NULL)
        Y -> esquerda -> pai = X;
    if(pai == NULL){
        Arvore -> raiz = Y;
    } else {
        if(X -> Aluno.RA > pai -> Aluno.RA){
            pai -> direita = Y;
        } else {
            pai -> esquerda = Y;
        }
    }
    X -> pai = Y;
    Y -> esquerda = X;
}

void rotacionaDireita(Tree * Arvore, Node * X){
    Node * Y = X -> esquerda;
    Node * pai = X -> pai;
    Y -> pai = pai;
    
    X -> esquerda = Y -> direita;
    if(Y -> direita != NULL)
        Y -> direita -> pai = X;
    if(pai == NULL){
        Arvore -> raiz = Y;
    } else {
        if(X -> Aluno.RA > pai -> Aluno.RA){
            pai -> direita = Y;
        } else {
            pai -> esquerda = Y;
        }
    }
    X -> pai = Y;
    Y -> direita = X;
}

void Balanceia(Tree * Arvore, Node * raiz){
    if(raiz != NULL){
        int fator = altura(raiz -> esquerda, 0) - altura(raiz -> direita, 0);
        if(fator < -1 || fator > 1){
            aux_balanceia = 1;
            printf("[No desbalanceado: %d]\n", raiz -> Aluno.RA);
            if(fator == 2){
                int fatorE = altura(raiz -> esquerda -> esquerda, 0) - altura(raiz -> esquerda -> direita, 0);
                if(fatorE >= 0){
                    printf("[Rotacao: SD]\n");
                    printf("[x=%d y=%d z=%d]\n", raiz -> esquerda -> esquerda -> Aluno.RA, raiz -> esquerda -> Aluno.RA, raiz -> Aluno.RA);;
                    rotacionaDireita(Arvore, raiz);
                } else {
                    printf("[Rotacao: DD]\n");
                    printf("[x=%d y=%d z=%d]\n", raiz -> esquerda -> Aluno.RA, raiz -> esquerda -> direita -> Aluno.RA, raiz -> Aluno.RA);
                    rotacionaEsquerda(Arvore, raiz -> esquerda);
                    rotacionaDireita(Arvore, raiz);
                }
            } else { // fator == -2
                int fatorD = altura(raiz -> direita -> esquerda, 0) - altura(raiz -> direita -> direita, 0);
                if(fatorD <= 0){
                    printf("[Rotacao: SE]\n");
                    printf("[x=%d y=%d z=%d]\n", raiz->Aluno.RA, raiz->direita->Aluno.RA, raiz->direita->direita->Aluno.RA);
                    rotacionaEsquerda(Arvore, raiz);
                } else {
                    printf("[Rotacao: DE]\n");
                    printf("[x=%d y=%d z=%d]\n", raiz -> Aluno.RA, raiz -> direita -> esquerda -> Aluno.RA, raiz -> direita -> Aluno.RA);
                    rotacionaDireita(Arvore, raiz -> direita);
                    rotacionaEsquerda(Arvore, raiz);
                }
            }
        }
        Balanceia(Arvore, raiz -> pai);
    }
}