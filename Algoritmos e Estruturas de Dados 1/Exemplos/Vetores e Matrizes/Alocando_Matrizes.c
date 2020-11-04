#include <stdio.h>
#include <stdlib.h>

int main(){
  int **Mat, linhas, colunas, i, j, a = 0;

  scanf("%d %d", &linhas, &colunas);

  Mat = (int **)malloc(linhas*sizeof(int *));

  for(i = 0; i < linhas; i++){
    Mat[i] = (int *)malloc(colunas*sizeof(int));
  }

  for(i = 0; i < linhas; i++){
    for(j = 0; j < colunas; j++){
      Mat[i][j] = a++;
    }
  }

  for(i = 0; i < linhas; i++){
    for(j = 0; j < colunas; j++){
      printf("%d ", Mat[i][j]);
    }
    printf("\n");
  }
  return 0;
}
