#include <stdio.h>
#include <stdlib.h>

typedef struct cel {
  int conteudo;
  struct cel * proximo;
} celula;

void gera_lista(int, celula *);
void imprime_lista_com_cabeca(celula *);

int main(){
  celula * head = (celula *)malloc(sizeof(celula));
  head -> proximo = NULL;
  head -> conteudo = -9999;

  int input = 0;
  while(input != -1){
    scanf("%d", &input);
    if(input != -1){
      gera_lista(input, head);
      imprime_lista_com_cabeca(head);
    }
  }

  return 0;
}

void gera_lista(int x, celula * head){
  celula *p1, *p2;
  p1 = head;
  p2 = p1 -> proximo;
  while(p2 != NULL && p2 -> conteudo < x){
    p1 = p2;
    p2 = p2 -> proximo;
  }

  celula * novo = (celula *)malloc(sizeof(celula));
  novo -> conteudo = x;
  novo -> proximo = p2;
  p1 -> proximo = novo;
}

void imprime_lista_com_cabeca(celula * p_c){
  celula *p;
  for(p = p_c -> proximo; p != NULL; p = p -> proximo){
    printf("%d ", p -> conteudo);
  }
  printf("\n");
}
