#include <stdio.h>
#include <stdlib.h>

int particiona(int *, int, int);

void imprimeVetor(int * v, int N){
    int i;
    for(i = 0; i < N; i++) printf("%d%s", v[i], i < N - 1?" ":"\n");
}

void quicksort(int *, int, int, int);

int main(){
    int N, i;
    int * v;
    
    scanf("%d", &N);
    v = (int *)malloc(sizeof(int)*N);
    for(i = 0; i < N; i++){
        scanf("%d", &v[i]);
    }
    imprimeVetor(v, N);
    quicksort(v, 0, N - 1, N);
    imprimeVetor(v, N);
    return 0;
}

void quicksort(int * v, int a, int b, int N){
    int p;
    if(a < b){
        p = particiona(v, a, b);
        printf("%d : ", p);
        imprimeVetor(v, N);
        quicksort(v, a, p - 1, N);
        quicksort(v, p + 1, b, N);
    }
}

int particiona(int * v, int a, int b){
    int i, pm = a - 1;
    for(i = a; i < b; i++){
        if(v[i] <= v[b]){
            int aux = v[++pm];
            v[pm] = v[i];
            v[i] = aux;
        }
    }
    int aux = v[++pm];
    v[pm] = v[b];
    v[b] = aux;
    return pm;
}