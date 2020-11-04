#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N 100
int t;

// Esta função recebe uma expressão infixa inf
// e devolve a correspondente expressão posfixa.

char * infixaParaPosfixa (char *inf){
  int n = strlen(inf);
  char *posf;
  posf = (char *)((n+1)*sizeof(char));
  criapilha();
  empilha(inf[0]); //empilha '('

  int j = 0;
  for(int i = 1; inf[i] != '\0'; ++1){
    switch(inf[i]){
      char x;
      case '(': empilha(inf[i]);
                break;
      case ')': x = desempilha();
                    while(x != '('){
                      posf[j++] = x;
                      x = desempilha();
                    }
                break;
      case '+': // ???? //
      case '-': x = desempilha();
                while(x != '('){
                  posf[j++] = x;
                  x = desempilha();
                }
                empilha(x);
                empilha(inf[i]);
                break;
      case '*':
      case '/': x = desempilha();
                while(x != '(' && x != '+' && x != '-'){
                  posf[j++] = x;
                  x = desempilha();
                }
                empilha(x);
                empilha(inf[i]);
                break;
      default: posf[j++] = inf[i];
    }
  }
  posf[j] = '\0';
  return posf;
}
