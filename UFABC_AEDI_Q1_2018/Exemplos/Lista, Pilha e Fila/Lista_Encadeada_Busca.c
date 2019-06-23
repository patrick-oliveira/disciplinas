#include <stdio.h>
#include <stdlib.h>

typedef struct cel{
  int conteudo;
  struct cel * proximo;
} celula;

void insere_celula_no_final(int x, celula * head);
void imprime_lista_com_cabeca(celula * p_c);
celula * busca_linear(int, celula *);
celula * busca_recursiva(int, celula *);

int main(){
  celula * head = (celula *)malloc(sizeof(celula));
  head -> proximo = NULL;
  head -> conteudo = -1;

  int input = 0;
  while(input != -1){
    scanf("%d", &input);
    if(input != -1)
      insere_celula_no_final(input, head);
  }
  imprime_lista_com_cabeca(head);

  input = 0;
  while(input != -1){
    scanf("%d", &input);
    if(input != -1){
      // Check! celula * p = busca_linear(input, head);
      celula * p = busca_recursiva(input, head -> proximo);
      if(p != NULL)
        printf("Encontrei! %d\n", p -> conteudo);
      else
        printf("Nao encontrei!\n");
    }
  }

  return 0;
}

celula * busca_recursiva(int x, celula * p){
  if(p == NULL || p -> conteudo == x){
    return p;
  } else
    return busca_recursiva(x, p -> proximo);
}

celula * busca_linear(int x, celula * head){
  celula * p;
  for(p = head -> proximo; p != NULL; p = p -> proximo){
    if(p -> conteudo == x)
      return p;
  }
  return p;
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
