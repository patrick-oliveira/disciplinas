#include <stdio.h>
#include <stdlib.h>

int particiona(int * v, int q, int p){
    int i, j, t;
    t = v[q-1];
    v[q-1] = v[p];
    v[p] = t;
    p = q - 1;
    i = 0; j = i - 1;
    while(i < q - 1){
        if(v[i] <= v[p]){
            t = v[++j];
            v[j] = v[i];
            v[i++] = t;
        } else {
            i++;
        }
    }
    t = v[++j];
    v[j] = v[p];
    v[p] = t;
    return j;
}

void imprimeVetor(int * v, int q){
    int i;
    for(i = 0; i < q; i++) printf("%d%s", v[i], i < q -1?" ":"\n");
}

int main(){
    int q, p, i, pivo;
    int *v;

    scanf("%d %d", &q, &p);
    v = (int *)malloc(q*sizeof(int));

    for(i = 0; i < q; i++) scanf("%d", &v[i]);

    imprimeVetor(v, q);
    pivo = particiona(v, q, p);
    imprimeVetor(v, q);
    return 0;
}