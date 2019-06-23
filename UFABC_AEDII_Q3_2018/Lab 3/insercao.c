#include "abb.h"

no * criar_no(int valor){
    no * novo = (no *)malloc(sizeof(no));
    novo -> conteudo = valor;
    novo -> esq = NULL;
    novo -> dir = NULL;
    novo -> pai = NULL;
    return novo;
}

void imprime_arvore(no * raiz){
    if(raiz != NULL){
        imprime_arvore(raiz -> esq);
        imprime_arvore(raiz -> dir);
        printf("%d ", raiz -> conteudo);
    }
}

int main(int argc, char *argv[])
{
    int i, valor;
    int n = atoi(argv[1]);
    no *raiz = NULL;

    for (i=0; i<n; i++) {
        scanf("%d", &valor);
        raiz = inserir_no_na_arvore(raiz, valor);
        printf("\nEstado atual da arvore: ");
        imprime_arvore(raiz);
        printf("\n");
    }

    // Altura da arvore

    printf("\nAltura da arvore:%d", altura(raiz));

}

no* inserir_no_na_arvore(no* r, int valor){
    if (r == NULL){
        no * novo = criar_no(valor);
        novo -> pai = novo;
        return novo;
    } else {
        no * pai_temp = NULL;
        no * filho_temp = r;
        while(filho_temp != NULL){
            if(valor > filho_temp -> conteudo){
                pai_temp = filho_temp;
                filho_temp = filho_temp -> dir;
            } else if (valor < filho_temp -> conteudo){
                pai_temp = filho_temp;
                filho_temp = filho_temp -> esq;
            } else {
                return r;
            }
        }
        no * novo = criar_no(valor);
        novo -> pai = pai_temp;
        if(valor > pai_temp -> conteudo){
            pai_temp -> dir = novo;
        } else {
            pai_temp -> esq = novo;
        }
        return r;
    }
}
