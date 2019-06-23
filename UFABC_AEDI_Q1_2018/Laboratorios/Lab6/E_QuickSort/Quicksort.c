#include <stdio.h>
#include <stdlib.h>

void quicksort(int *, int, int, int);
int separa(int *, int, int, int);

void imprimeVetor(int * v, int N){
    int i;
    for(i = 0; i < N; i++)
        printf("%d%s", v[i], i < N - 1?" ":"\n");
}

int main(){
    int N, i;
    int *v;
    scanf("%d", &N);
    v = (int *)malloc(sizeof(int)*N);
    for(i = 0; i < N; i++) scanf("%d", &v[i]);

    imprimeVetor(v, N);
    quicksort(v, 0, N - 1, N);
    imprimeVetor(v, N);
    return 0;
}

void quicksort(int * v, int p, int r, int N){
    int j;
    if(p < r){
        j = separa(v, p, r, N);
        quicksort(v, p, j-1, N);
        quicksort(v, j+1, r, N);
    }
}

int separa(int * v, int p, int q, int N){
    int i = 0, j = q - 1, c = v[p], t;
    while(i <= j){
        imprimeVetor(v, N);
        if(v[i] <= c) i++;
        else if(v[j] > c) j--;
        else{
            t = v[i];
            v[i] = v[j];
            v[j] = t;
            if(p == j) p = i;
            i++;
            j--;
        }
    }
    v[p] = v[j];
    v[j] = c;
    return j;
}