#define N 100
int fila[N];
int p, u;
int dist[N];

void criafila(void){
  p = 0; u = 0;
}

int filavazia(void){
  return p >= u;
}

int tiradafila(void){
  return fila[p++];
}

void colocanafila(int y){
  fila[u++] = y;
}

/*

  Esta função recebe uma matriz A que representa as interligações entre
  cidades 0...N -1 e preenche o vetor dist de modo que dist[i] seja a distäncia
  da cidade c à cidade i, para cada i.

*/

void distancias (int A[][N], int c){
  for (int j = 0; j < N; ++J) dist[J] = N; // inicializa o vetor dist
  dist[c] = 0;
  criafila();
  colocanafila(c);

  while(!filavazia()){
    int i = tiradafila();
    for(int j = 0; j < N; ++j)
      if(A[i][j] == 1 && dist[j] >= N){
        dist[j] = dist[i] + 1;
        colocanafila(j);
      }
  }
}
