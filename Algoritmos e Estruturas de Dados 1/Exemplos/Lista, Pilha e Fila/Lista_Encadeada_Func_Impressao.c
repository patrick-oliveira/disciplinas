#include <stdio.h>
#include <stdlib.h>

typedef struct cel{
  int conteudo;
  struct cel * proximo;
} celula;

void insere_na_lista(int, celula *); // insere no final da lista (Use essa funcao na fila)
void imprime_iterativo(celula *);
void imprime_recursivo(celula *);
void imprime_lista_com_cabeca(celula *);

int main(){
  celula * head;
  head = (celula *)malloc(sizeof(celula));
  head -> proximo = 0;

  int input = 0;
  while(input != -1){
    scanf("%d", &input);
    if(input != -1)
      insere_na_lista(input, head);
  }


  return 0;
}

void insere_na_lista(int x, celula * head){
  celula * nova;
  nova = (celula *)malloc(sizeof(celula));
  nova -> conteudo = x;
  nova -> proximo = NULL;

  celula * p = head;
  while(p -> proximo != NULL)
    p = p -> proximo;
  p -> proximo = nova;
}

void imprime_lista_com_cabeca(celula * head){
  celula * p;
  for(p = head -> proximo; p != NULL; p = p -> proximo)
    printf("%d ", p -> conteudo);
  printf("\n");
}

void imprime_iterativo(celula * primeira_celula){
  celula * p = primeira_celula;
  for(p = primeira_celula; p != NULL; p = p -> proximo)
    printf("%d ", p -> conteudo);
  printf("\n");
}

void imprime_recursivo(celula * p){
  if(p == NULL){
    return;
  } else {
    printf("%d ", p -> conteudo);
    imprime_recursivo(p -> proximo);
  }
}
