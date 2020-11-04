#include <stdio.h>
#include <stdlib.h>
#define N 10

int soma_recursiva(int *, int);

void main(){
    int v[N];
    for(int i = 0; i < N; i++)
        scanf("%d", &v[i]);

    printf("%d\n", soma_recursiva(v, N));
}

int soma_recursiva(int *v, int n){
    if (n == 0)
      return 0;
    if (v[n - 1] >= 0) return v[n - 1] + soma_recursiva(v, n - 1);
    else return soma_recursiva(v, n - 1);
}
