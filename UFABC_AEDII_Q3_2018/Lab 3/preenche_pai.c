#include <stdio.h>
#include <stdlib.h>
#include "abb.h"

void erd_modificada (no *r) {
    if (r != NULL) {
        erd_modificada(r->esq);
        printf("Nodo: %d \t Pai: %d\n", r->conteudo, r->pai->conteudo);
        erd_modificada(r->dir);
    }
}

int main(int argc, char *argv[])
{
    int i;
    int v[] = {-1,10,20,30,40,50,60,70,80,90,100};
    int n = sizeof(v)/sizeof(v[0]); /* numero de elementos de v */
    no *(pv[n]);

    // criacao dos nos/vertices
    for (i=0; i<n; i++) {
        no* celula = (no *)malloc(sizeof(no));
        celula->conteudo = v[i];
        celula->esq = NULL;
        celula->dir = NULL;
        celula->pai = NULL;
        pv[i] = celula;
    }

    // cricao da arvore (no modo heap)
    for (i=1; i<=n/2; i++) {
        no* celula = pv[i];
        if (2*i<n)
            celula->esq = pv[2*i];
        if (2*i+1<n)
            celula->dir = pv[2*i+1];
    }

    // raiz da arvore eh o elemento na posicao 1 do vetor de ponteiros
    no *raiz = pv[1];

    // Varredura e-r-d da árvore
    printf("\nVarredura e-r-d:\n");
    erd(raiz);

    // Imprimir as folhas
    printf("\nFolhas da arvore:\n");
    imprimir_folhas(raiz);

    // Altura da arvore
    printf("\nAltura da arvore:%d\n", altura(raiz));


    preenche_pai(raiz);
    erd_modificada(raiz);
    no* ultimo = ultimo_erd(raiz);
    printf("\nUltimo no e-r-d:\n%d", ultimo -> conteudo);
    printf("\nPai do ultimo no e-r-d:\n%d", ultimo->pai->conteudo);
}



void preenche_pai(no * raiz){
    if (raiz -> esq != NULL){
        raiz -> esq -> pai = raiz;
        preenche_pai(raiz -> esq);
    }
    if (raiz -> dir != NULL){
        raiz -> dir -> pai = raiz;
        preenche_pai(raiz -> dir);
    }
    if(raiz -> pai == NULL){
        raiz -> pai = raiz;
    }
}
