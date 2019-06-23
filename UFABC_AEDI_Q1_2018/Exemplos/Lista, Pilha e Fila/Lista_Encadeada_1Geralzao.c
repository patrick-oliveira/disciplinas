#include <stdio.h>
#include <stdlib.h>

typedef struct celula{
  int n;
  struct celula * proxima_celula;
} celula;

/*
  Declarações alternativas:

  typedef struct reg celula;
  struct reg{
    int conteudo;
    celula proxima_celula;
  };
*/

void imprime_recursivo(celula *);
void imprime_iterativo(celula *);
void imprime_lista_com_cabeca(celula *);
void insere_celula(int, celula *);
void remove_celula(celula *);
void busca_e_insere (int, int, celula *);

int contador_de_celulas_recursivo(celula *);
int contador_de_celulas_iterativo(celula *);
celula * busca_iterativa(int, celula *);
celula * busca_recursiva(int, celula *);
celula * busca_em_lista_crescente_iterativa(int, celula *);
celula * busca_em_lista_crescente_recursiva(int, celula *);
celula * busca_elemento_minimo_iterativa(celula *);
void busca_elemento_minimo_recursivo(celula *, celula *);
int verifica_crescimento(celula *);


int main(){
  int i, input = 0;
  celula * head, * p; // A cabeça é uma célula dummie que aponta para a o início
                 // da lista.
  head = (celula *)malloc(sizeof(celula));
  head -> proxima_celula = NULL;
                 // A lista estará vazia se head -> proximo == NULL;

  // gera uma lista
  while(input != -1){
    scanf("%d", &input);
    if(input != -1){
      p = head;
      while(p -> proxima_celula != NULL) p = p -> proxima_celula;
      insere_celula(input, p);
    }
  }

  // teste das funções de impressão
  imprime_lista_com_cabeca(head);
  imprime_recursivo(head -> proxima_celula);
  printf("\n");
  imprime_iterativo(head -> proxima_celula);

  // adiciona valores na lista antes de um valor especificado
  // a nova célula é adicionada sempre antes da célula identificada, e a
  // busca não verifica duplicidade de células
  input = 0;
  int input2 = 0;
  while(input != -1){
    scanf("%d %d", &input, &input2);
    busca_e_insere(input, input2, head);
    imprime_lista_com_cabeca(head);
  }

  while(head -> proxima_celula != NULL){
    remove_celula(head);
    imprime_lista_com_cabeca(head);
  }
  return 0;
}

void insere_celula(int x, celula * p_c){
  celula * nova;
  nova = (celula *)malloc(sizeof(celula));
  nova -> n = x;
  nova -> proxima_celula = p_c -> proxima_celula;
  p_c -> proxima_celula = nova;
}

void imprime_lista_com_cabeca(celula * p_c){
  celula *p;
  for(p = p_c -> proxima_celula; p != NULL; p = p -> proxima_celula){
    printf("%d ", p -> n);
  }
  printf("\n");
}

void imprime_recursivo(celula * p_c){
  if (p_c != NULL){
    printf("%d ", p_c -> n);
    imprime_recursivo(p_c -> proxima_celula);
  }
}

void imprime_iterativo(celula *p_c){
  celula *p;
  for(p = p_c; p != NULL; p = p -> proxima_celula)
    printf("%d ", p -> n);
  printf("\n");
}

void busca_e_insere(int x, int y, celula *p_c){
  celula *p, *q, *nova;
  nova = (celula*)malloc(sizeof(celula));
  nova -> n = x;
  p = p_c;
  q = p_c -> proxima_celula;
  while(q != NULL && q -> n != y){
    p = q;
    q = p -> proxima_celula;
  }
  nova -> proxima_celula = q;
  p -> proxima_celula = nova;
}

void remove_celula(celula * p_c){
  celula * lixo;
  lixo = p_c -> proxima_celula;
  p_c -> proxima_celula = lixo -> proxima_celula;
  free(lixo);
}

/*
  Quando eu dou malloc dentro de uma função o endereço permanece alocado,
  e só será desacolado se eu der free.
  */

/*
celula * busca_iterativa(int x, celula * p_c){
  celula *p = p_c;
  while(p != NULL && p -> n != x)
      p = p -> proxima_celula;
  return p;
}

celula * busca_recursiva(int x, celula * p_c){
  if(p_c == NULL)
    return NULL;
  if (p_c -> n == x)
    return p_c;
  busca_recursiva(x, p_c -> proxima_celula);
}

int contador_de_celulas_recursivo(celula * p_c){
  if(p_c == NULL)
    return 0;
  else
    return 1 + contador_de_celulas_recursivo(p_c -> proxima_celula);
}

int contador_de_celulas_iterativo(celula * p_c){
  celula * p_aux;
  int cont = 0;
  for(p_aux = p_c; p_aux != NULL; p_aux = p_aux -> proxima_celula)
    cont++;
  return cont;
}
*/
/*
  Uma função que calcula a altura de uma célula é precisamente a função
  anterior, com a diferença de que a entrada não é a cabeça da lista mais a
  célula cuja altura será calculada.
  A função que calcula a profundidade será equivalente à função acima, com
  a diferença de que a condição de parada é o ponteiro ser igual ao endereço
  da célula cuja profundidade está sendo calculada.
*/
/*
int verifica_crescimento(celula * p_c){
  celula * p;
  crescente = 1;

  for(p = p_c; p -> proxima_celula != NULL; p = p -> proxima_celula){
    if(p -> n > p -> proxima_celula -> n)
      crescente = 0;
  }

  return crescente;
}

celula * busca_em_lista_crescente_iterativa(int x, celula * p_c){
  celula * p;

  for(p = p_c; p != NULL; p = p -> proxima_celula){
    if(p -> n == x)
      return p;
    else if(p -> n > x)
      return NULL;
  }
  return NULL;
}

celula * busca_em_lista_crescente_recursiva(int x, celula * p_c){
  if(p_c == NULL || p_c -> n > x)
    return NULL;
  else if (p_c -> n == x)
    return p_c;
  return busca_em_lista_crescente_recursiva(x, p_c -> proxima_celula);
}

celula * busca_elemento_minimo_iterativa(celula * p_c){
  celula * minimo = p_c;
  celula * p;
  for(p = p_c; p != NULL; p = p -> proxima_celula){
    if(minimo -> n > p -> n)
      minimo = p;
  }

  return minimo;
}

void busca_elemento_minimo_recursivo(celula * p_c, celula * minimo){
  if(p_c == NULL){
    return;
  }
  if(minimo -> n > p_c -> n)
    minimo = p_c;
  return busca_elemento_minimo_recursivo(minimo, p_c -> proxima_celula);
}
*/
