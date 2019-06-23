#include <stdio.h>
#include <stdlib.h>
#define M 3

int main(){
  int *v, n, i, c;

  scanf("%d", &n);
  c = n;
  v = (int *)malloc(n*sizeof(int));

  for(i = 0; i < n; i++)
    v[i] = i + 1;
  i = 0;
  while(c >= 2){
    if(i + M > n - 1){
      i = i + M - n;
      v[i] = 0;
      c--;
    } else {
      i = i + M;
      v[i] = 0;
      c--;
    }
  }

  for(i = 0; i < n; i++)
    if(v[i] != 0)
      printf("%d\n", i);


  return 0;
}
