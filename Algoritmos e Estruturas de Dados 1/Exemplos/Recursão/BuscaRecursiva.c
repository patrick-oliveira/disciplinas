#include <stdio.h>

int busca_linear_recursiva(int *, int, int);
int busca_binaria_recursiva(int *, int, int, int, int);

int main(){
  int V1[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  int V2[10] = {8, 7, 5, 9, 1, 2, 3, 11, 26, 87};

  int n = 10;
  int a = 5;

  return 0;
}

int busca_linear_recursiva(int *V, int n, int a){
  if(n == 0){
    return 0;
  } else {
    if(V[n - 1] == a){
      return 1;
    } else {
      return busca_linear_recursiva(V, n - 1, a);
    }
  }
}

int busca_binaria_recursiva(int *V, int min, int max, int a){
  if(max - min < 0){
    return 0;
  } else{
    int mid = (max + min)/2;
    if(V[mid] == a){
      return 1;
    } else {
      if(a < V[mid]){
        max  = mid;
      } else {
        min = mid;
      }
      return busca_binaria_recursiva(V, min, max, a);
    }
  }
}
