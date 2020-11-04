#include <stdio.h>
#include <stdlib.h>


void intercala1(int, int, int, int *);
void mergesort (int, int, int *);

int main(){
    int N, i;
    int * v;

    scanf("%d", &N);
    v = (int *)malloc(sizeof(int)*N);

    srand(time(NULL));
    for(i = 0; i < N; i++)
        v[i] = rand()%100;
    
    for(i = 0; i < N; i++) printf("%d%s", v[i], i < N-1?" ":"\n");

    mergesort(0, N, v);

    for(i = 0; i < N; i++) printf("%d%s", v[i], i < N - 1?" ":"\n");


    return 0;
}

void mergesort (int p, int r, int *v){
    if(p < r-1){
        int q = (p+r)/2;
        mergesort(p, q, v);
        mergesort(q, r, v);
        intercala1(p, q, r, v);
    }
}

void intercala1(int p, int q, int r, int * v){
    int i, j, k, *w;
    w = (int *)malloc(sizeof(int)*(r - p));
    i = p; j = q;
    k = 0;
    
    while(i < q && j < r){
        if(v[i] <= v[j]) w[k++] = v[i++];
        else w[k++] = v[j++];
    }
    
   while (i < q) w[k++] = v[i++];
   while (j < r) w[k++] = v[j++];
   for (i = p; i < r; ++i) v[i] = w[i - p];
   free(w);
}