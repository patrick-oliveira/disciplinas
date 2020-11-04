#include <stdio.h>
#define N 10

int tirazeros(int *, int *);
int tirazeros_recursivo(int, int *);

void main(){
    int v[N];

    for(int i = 0; i < N; i++)
      scanf("%d", &v[i]);
}

int tirazeros(int *n, int *v){
  int i = 0;
  for (int j = 0; j < n; j++)
    if (v[j] != 0)
      v[i++] = v[j];  /* equivalente a v[i] = v[j]; i += 1 */
  *n--;
  return i;
}

int tirazeros_recursivo(int n, int *v){
  if (n == 0) return 0;
  int m = tirazeros_recursivo(n - 1, v);
  if (v[n - 1] == 0) return m;
  v[m] = v[n - 1];
  return m + 1;
}
