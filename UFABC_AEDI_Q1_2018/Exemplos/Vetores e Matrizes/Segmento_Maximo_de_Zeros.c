#include <stdio.h>
#include <stdlib.h>

int main(){
  int *v, n, i, c = 0, seg = 0;

  scanf("%d", &n);

  v = (int *)malloc(n*sizeof(int));

  for(i = 0; i < n; i++)
    scanf("%d", &v[i]);

  for(i = 0; i < n; i++){
    if(v[i] != 0){
      if(seg < c)
        seg = c;
      c = 0;
    } else
        c++;
  }
  if(seg < c)
    seg = c;
  printf("%d\n", seg);
  return 0;
}
