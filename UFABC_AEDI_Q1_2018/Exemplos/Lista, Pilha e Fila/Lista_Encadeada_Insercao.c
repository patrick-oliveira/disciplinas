#include <stdio.h>
#include <stdlib.h>

typedef struct cel{
  int conteudo;
  struct cel * proximo;
} celula;

void insere_celula_no_final(int, celula *);
void insere_celula_no_inicio(int, celula *);
void insere_celula_no_meio(int, celula *);
void imprime_lista_com_cabeca(celula * );
celula * busca_recursiva(int, celula *);
celula * busca_adaptada(int, celula *);

int main(){
  celula * head;
  head = (celula *)malloc(sizeof(celula));
  head -> conteudo = -1;
  head -> proximo = NULL;

  int input = 0;
  while(input != -1){
    scanf("%d", &input);
    if(input != -1)
      insere_celula_no_final(input, head);
      //Check! insere_celula_no_inicio(input, head);
  }

  imprime_lista_com_cabeca(head);

  input = 0;
  int busca = 0;
  while(input != -1){
    scanf("%d %d", &busca, &input);
    if(input != -1){
      // Para inserir na frente - celula * p = busca_recursiva(busca, head);
      // Para inserir atrás
      celula * p = busca_adaptada(busca, head);
      if(p != NULL){
        insere_celula_no_meio(input, p);
        imprime_lista_com_cabeca(head);
      } else
        printf("Celula nao encontrada!\n");
    }
  }

  return 0;
}


void insere_celula_no_meio(int x, celula * p){
  celula * novo = (celula *)malloc(sizeof(celula));
  novo -> conteudo = x;
  novo -> proximo = p -> proximo;
  p -> proximo = novo;
}

void insere_celula_no_inicio(int x, celula * head){
  celula * novo;
  novo = (celula *)malloc(sizeof(celula));
  novo -> conteudo = x;
  novo -> proximo = head -> proximo;
  head -> proximo = novo;
}

void insere_celula_no_final(int x, celula * head){
  celula * p;
  for(p = head; p -> proximo != NULL; p = p -> proximo);

  celula * novo;
  novo = (celula *)malloc(sizeof(celula));
  novo -> conteudo = x;
  novo -> proximo = NULL;
  p -> proximo = novo;
}

void imprime_lista_com_cabeca(celula * p_c){
  celula *p;
  for(p = p_c -> proximo; p != NULL; p = p -> proximo){
    printf("%d ", p -> conteudo);
  }
  printf("\n");
}

celula * busca_recursiva(int x, celula * p){
  if(p == NULL || p -> conteudo == x){
    return p;
  } else
    return busca_recursiva(x, p -> proximo);
}

celula * busca_adaptada(int x, celula * p){
  while(p -> proximo != NULL){
    if (p -> proximo -> conteudo == x){
      return p;
    }
    p = p -> proximo;
  }
}
