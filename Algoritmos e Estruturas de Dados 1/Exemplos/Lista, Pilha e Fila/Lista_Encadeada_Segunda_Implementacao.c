#include <stdio.h>
#include <stdlib.h>

typedef struct cel{
  int conteudo;
  struct cel *proximo, *anterior;
} celula;

struct l{
  struct cel *primeiro, *ultimo;
  int quantidade;
};

struct l * inicializa_lista(void);
void adiciona_elemento(int, struct l *);
void imprime_lista(struct l *);
celula * remove_elemento(int, struct l *);


int main(){
  struct l * Lista;
  int n;
  char operacao;

  Lista = inicializa_lista();

  while(scanf("\n%c", &operacao) != EOF){
    if(operacao == 'I'){
      scanf("%d", &n);
      adiciona_elemento(n, Lista);
    } else if (operacao == 'R'){
      scanf("%d", &n);
      celula * cel = remove_elemento(n, Lista);
      if(cel != NULL){
        free(cel);
      }
    } else{
      imprime_lista(Lista);
    }
  }


  return 0;
}

celula * remove_elemento(int input, struct l * Lista){
  celula * p = Lista -> primeiro;
  while(p != NULL && p -> conteudo != input)
    p = p -> proximo;
  if(p == NULL)
    return NULL;
  else{
    if(p -> anterior == NULL){
      p -> proximo -> anterior = NULL;
      Lista -> primeiro = p -> proximo;
      p -> proximo == NULL;
      return p;
    } else if(p -> proximo == NULL){
      p -> anterior -> proximo = NULL;
      Lista -> ultimo = p -> anterior;
      p -> anterior = NULL;
      return p;
    } else {
      p -> anterior -> proximo = p -> proximo;
      p -> proximo -> anterior = p -> anterior;
      p -> anterior = NULL;
      p -> proximo = NULL;
    }
    return p;
  }
}

void imprime_lista(struct l * Lista){
  celula * p = Lista -> primeiro;
  while(p != NULL){
    printf("%d ", p -> conteudo);
    p = p -> proximo;
  }
  printf("\n");
}

void adiciona_elemento(int input, struct l * Lista){
  celula * novo = (celula *)malloc(sizeof(celula));
  novo -> conteudo = input;
  celula * p;

  if(Lista -> quantidade == 0){
    Lista -> primeiro = novo;
    Lista -> ultimo = novo;
    novo -> proximo = NULL;
    novo -> anterior = NULL;
    Lista -> quantidade++;
  } else {
    p = Lista -> primeiro;
    while(p -> proximo != NULL && p -> conteudo <= input){
      if(p -> conteudo == input){
        free(novo);
      }
      p = p -> proximo;
    }
    if(p -> conteudo > input){
      if (p -> anterior == NULL){
        p -> anterior = novo;
        novo -> proximo = p;
        novo -> anterior = NULL;
        Lista -> primeiro = novo;
      } else {
        p -> anterior -> proximo = novo;
        novo -> anterior = p -> anterior;
        novo -> proximo = p;
        p -> anterior = novo;
      }
    } else {
      p -> proximo = novo;
      novo -> proximo = NULL;
      novo -> anterior = p;
      Lista -> ultimo = novo;
    }
    Lista -> quantidade++;
  }
}

struct l * inicializa_lista(void){
  struct l * lista;
  lista = (struct l *)malloc(sizeof(struct l));
  lista -> primeiro = NULL;
  lista -> ultimo = NULL;
  lista -> quantidade = 0;

  return lista;
}
