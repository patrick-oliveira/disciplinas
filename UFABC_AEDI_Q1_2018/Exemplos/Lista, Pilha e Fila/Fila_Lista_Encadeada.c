#include <stdio.h>
#include <stdlib.h>

typedef struct cel {
  int conteudo;
  struct cel * proxima;
} celula;

celula * colocanafila(int, celula *);

int main(){
  /*
    Estrutura proposta: uma fila com cabeça e circular. A fila está vazia se
    a cabeá apontar para si própria. A cabeça sempre aponta para a primeira
    célula, e a última sempre aponta para a cabeça.
  */

  celula * head;
  head = (celula*)malloc(sizeof(celula));
  head -> proxima = head;

  return 0;
}

// Coloca um novo elemento com conteudo y na fila; Devolve o endereço da
// cabeça da fila resultante.

celula * colocanafila(int y, celula * head){
  celula * nova_head;
  nova_head = (celula *)malloc(sizeof(celula));
  nova_head -> proxima = head -> proxima;
  head -> proxima = nova;
  head -> conteudo = y;
  return nova;
}

int tiradafila(celula * head){
  celula * p;
  p = head -> proximo;
  int x = p -> conteudo;
  head -> proximo = p -> proximo;
  free(p);
  return x;
}
