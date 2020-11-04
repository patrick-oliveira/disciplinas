#include <stdio.h>
#include <stdlib.h>

typedef struct cel {
  int conteudo;
  struct cel * proximo;
} celula;


celula * head;

void criapilha(void);
void empilha(int );
int desempilha(void);


int main(){

  return 0;
}

void criapilha(void){
  head = (celula *)malloc(sizeof(ceula)); // cabeça da pilha
  head -> proximo = NULL;
}

void empilha(int y){
  celula * nova;
  nova = (celula *)malloc(sizeof(celula));
  nova -> conteudo = y;
  nova -> proximo = head -> proximo;
  head -> proximo = nova;
}

int desempilha(void){
  celula * p;
  p = head -> proximo;
  int x = p -> conteudo;
  head -> proximo = p -> proximo;
  free(p);
  return x;
}
