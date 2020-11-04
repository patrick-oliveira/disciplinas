#include <stdio.h>
#include <stdlib.h>

typedef struct cel {
  int conteudo;
  struct cel * proximo;
} celula;

void gera_lista(int, celula *);
void zera_lista(celula *);
void remove_primeira_celula(celula *);
void remove_ultima_celula(celula *);
void remove_celula(celula *);
void imprime_lista_com_cabeca(celula *);
celula * busca_linear(int, celula *);

int main(){
  int i;
  celula * head = (celula *)malloc(sizeof(celula));
  head -> proximo = NULL;

  for(i = -10; i < 11; i++){
    gera_lista(i, head);
  }

  imprime_lista_com_cabeca(head);

  remove_celula(busca_linear(7, head));

  imprime_lista_com_cabeca(head);

  return 0;
}

celula * busca_linear(int x, celula * head){ // adaptado para retornar o valor anterior ao que eu quero deletar.
  celula * p;
  for(p = head; p -> proximo != NULL; p = p -> proximo){
    if(p -> proximo -> conteudo == x)
      return p;
  }
  return p;
}

// eu vou enviar para a função o endereço da célula ANTERIOR àquela que eu
// quero remover.
void remove_celula(celula * p){
  celula * lixo;
  lixo = p -> proximo;
  p -> proximo = lixo -> proximo;
  free(lixo);
}

void remove_ultima_celula(celula * head){
  celula * lixo, * p;
  if(head -> proximo == NULL){
    return;
  } else {
    lixo = head -> proximo;
    p = head;
    while(lixo -> proximo != NULL){
      lixo = lixo -> proximo;
      p = p -> proximo;
    }
    p -> proximo = NULL;
    free(lixo);
  }

}

void remove_primeira_celula(celula * head){
  celula * lixo;
  lixo = head -> proximo;
  head -> proximo = lixo -> proximo;
  free(lixo);
}

void zera_lista(celula * head){
  celula * lixo;
  while(head -> proximo != NULL){
    lixo = head -> proximo;
    head -> proximo = lixo -> proximo;
    free(lixo);
  }
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
