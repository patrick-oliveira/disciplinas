#include <stdio.h>
#include <stdlib.h>

typedef struct cel{
  int valor;
  struct cel * proximo;
  struct cel * anterior;
} celula;

typedef struct lista {
  int quantidade;
  struct cel * cabeca;
  struct cel * rabo;
} lst;

struct lista * inicializa_lista(void);
void insere_elemento(int, lst *);
void remove_elemento(int, lst *);
celula * busca_elemento(int, lst *);
void imprime_lista(lst *, char);

int main(){
  lst * Lista;
  Lista = inicializa_lista();

  int input;
  char operacao;
  while(scanf("\n%c", &operacao) != EOF){
    if(operacao == 'I'){
      scanf("%d", &input);
      insere_elemento(input, Lista);
    } else if(operacao == 'E'){
      scanf("%d", &input);
      remove_elemento(input, Lista);
    } else {
      imprime_lista(Lista, operacao);
      printf("\n");
    }
  }
  return 0;
}

void remove_elemento(int input, lst * Lista){
  celula * p = Lista -> cabeca -> proximo;
  while(p != Lista -> rabo){
    if (p -> valor == input){
      p -> anterior -> proximo = p -> proximo;
      p -> proximo -> anterior = p -> anterior;
      free(p);
      Lista -> quantidade--;
      return;
    }
    p = p -> proximo;
  }
}

void insere_elemento(int input, lst * Lista){
  celula * novo = (celula *)malloc(sizeof(celula));
  novo -> valor = input;

  celula * p1 = Lista -> cabeca;
  celula * p2 = p1 -> proximo;
  while(p2 != Lista -> rabo && p2 -> valor <= input){
    if(p2 -> valor == input){
      free(novo);
      return;
    }
    p2 = p2 -> proximo;
    p1 = p1 -> proximo;
  }
  novo -> proximo = p2;
  novo -> anterior = p1;
  p1 -> proximo = novo;
  p2 -> anterior = novo;
  Lista -> quantidade++;
}

void imprime_lista(lst * Lista, char operacao){
  if(operacao == 'M'){
    celula * p = Lista -> cabeca -> proximo;
    while(p != Lista -> rabo){
      if(p -> proximo == Lista -> rabo) printf("%d\n", p -> valor);
      else                              printf("%d ", p -> valor);
      p = p -> proximo;
    }
  } else {
    celula * p = Lista -> rabo -> anterior;
    while(p != Lista -> cabeca){
      if(p -> anterior == Lista -> cabeca) printf("%d\n", p -> valor);
      else                                 printf("%d ", p -> valor);
      p = p -> anterior;
    }
  }
}

struct lista * inicializa_lista(void){
  lst * Lista = (lst *)malloc(sizeof(lst));
  celula * cabeca = (celula *)malloc(sizeof(celula));
  celula * rabo = (celula *)malloc(sizeof(celula));
  Lista -> quantidade = 0;
  cabeca -> anterior = NULL;
  rabo -> proximo = NULL;
  cabeca -> proximo = rabo;
  rabo -> anterior = cabeca;
  Lista -> cabeca = cabeca;
  Lista -> rabo = rabo;
  return Lista;
}
