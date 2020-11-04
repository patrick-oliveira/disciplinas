#include <stdio.h>
#include <stdlib.h>

int separa(int *, int, int);
void imprimeVetor(int * v, int N){
    int i;
    for(i = 0; i < N; i++)
        printf("%d%s", v[i], i < N - 1?" ":"\n");
}


int main(){
    int i, N, pivo;
    int * v;

    scanf("%d", &N);
    v = (int *)malloc(sizeof(int)*N);

    
    srand(time(NULL));
    for(i = 0; i < N; i++) v[i] = rand()%100;
    

    //for(i = 0; i < N; i++) scanf("%d", &v[i]);

    imprimeVetor(v, N);
    pivo = separa(v, 0, N-1);
    printf("%d %d\n", pivo, v[pivo]);
    imprimeVetor(v, N);
    
    return 0;
}

int separa(int * v, int p, int r){
    int c = v[p], i = p + 1, j = r, t; // J está 'apontando' para o último elemento;
    
    while(i <= j){
        if(v[i] <= c) i++;
        else if(v[j] > c) i--;
        else {
            t = v[i];
            v[i++] = v[j];
            v[j--] = t;;
        }
    }
    v[p] = v[j];
    v[j] = c;
    
    return j;
}