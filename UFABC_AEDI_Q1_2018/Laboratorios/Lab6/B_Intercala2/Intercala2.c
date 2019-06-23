#include <stdio.h>
#include <stdlib.h>

void intercala(int, int, int, int *);

int main(){
    int q1, q2, i;
    int * v;

    scanf("%d %d", &q1, &q2);
    v = (int *)malloc(sizeof(int)*(q1 + q2));

    for(i = 0; i < q1 + q2; i++)
        scanf("%d", &v[i]);

    intercala(0, q1, q1 + q2, v);
    
    for(i = 0; i < (q1 + q2); i++)
        printf("%d\n", v[i]);

    return 0;
}

void intercala(int p, int q, int r, int * v){
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