#include <stdio.h>
#include <stdlib.h>

int * intercala(int *, int *, int, int);

int main(){
    int q1, q2, i;
    int * v1, * v2, * v3;
    
    scanf("%d %d", &q1, &q2);
    
    v1 = (int *)malloc(sizeof(int)*q1);
    v2 = (int *)malloc(sizeof(int)*q2);
    
    for(i = 0; i < q1; i++) scanf("%d", &v1[i]);
    for(i = 0; i < q2; i++) scanf("%d", &v2[i]);
    
    v3 = intercala(v1, v2, q1, q2);
    
    for(i = 0; i < (q1 + q2); i++)
        printf("%d\n", v3[i]);

    return 0;
}

int * intercala(int *v1, int *v2, int q1, int q2){
    int * w = (int *)malloc(sizeof(int)*(q1+q2));
    int i = 0, j = 0, k = 0;
    
    while(i < q1 && j < q2){
        if(v1[i] <= v2[j]) w[k++] = v1[i++];
        else w[k++] = v2[j++];
    }
    
    while(i < q1) w[k++] = v1[i++];
    while(j < q2) w[k++] = v2[j++];
    
    return w;
}