#include <stdio.h>
#include <stdlib.h>

int separa(int *, int, int);
void imprimeVetor(int * v, int N){
    int i;
    for(i = 0; i < N; i++) printf("%d%s", v[i], i < N -1?" ":"\n");
}


int main(){
    int p, q, i, pivo;
    int * v;

    scanf("%d", &q);
    v = (int *)malloc(sizeof(int)*q);

    srand(time(NULL));
    p = rand()%q;
    for(i = 0; i < q; i++) v[i] = rand()%100;

    imprimeVetor(v, q);
    pivo = separa(v, q, p);
    printf("%d %d\n", p, pivo, v[pivo]);
    imprimeVetor(v, q);

    return 0;
}

int separa(int * v, int q, int p){
    int i = 0, j = q - 1, c = v[p], t;
    while(i <= j){
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