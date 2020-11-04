#ifndef RB_TREE_H_INCLUDED
#define RB_TREE_H_INCLUDED

#include <stdio.h>
#include <stdlib.h>


typedef enum {RED, BLACK} Color;

typedef struct Node{
    int          key;
    Color         color;
    struct Node *left;
    struct Node *right;
    struct Node *parent;
} Node;

/* Valor de sentinela, indica que chegamos em alguma folha ou entao
 a raiz da arvore */
Node NIL_NODE;

/* Ponteiro para o valor de sentinela */
Node *NIL_PTR = &NIL_NODE;




#endif // RB_TREE_H_INCLUDED
