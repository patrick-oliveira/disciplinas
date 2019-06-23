#include <stdio.h>
#include <stdlib.h>

void MinMaxRecursivo(int, int *, int *, int *);

int main(){
  int *v, n, max, min, i;

  scanf("%d", &n);
  v = (int *)malloc(n*sizeof(int));

  for(i = 0; i < n; i++){
    scanf("%d", &v[i]);
  }

  max = *v;
  min = *v;
  MinMaxRecursivo(n, v, &max, &min);

  printf("Max: %d Min: %d\n", max, min);
}

void MinMaxRecursivo(int n, int *v, int *max, int *min){
  if(n == 1){
    if(*v > *max)
      *max = *v;
    if(*v < *min)
      *min = *v;
  } else {
    if (*max < v[n - 1])
      *max = v[n - 1];
    if (*min > v[n - 1])
      *min = v[n - 1];
    MinMaxRecursivo(n - 1, v, max, min);
  }

}
