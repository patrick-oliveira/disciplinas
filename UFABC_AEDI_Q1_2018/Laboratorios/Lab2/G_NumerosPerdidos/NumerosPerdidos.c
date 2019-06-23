#include <stdio.h>
#include <stdlib.h>

struct numeros{
    int n;
    int check;
};

void ordena_vetor(int *, int);

int main(){
    struct numeros *B;
    int *A, N, M, i, j, c1, c2;
    int *perdidos, *p, c3 = 0;
    
    scanf("%d", &N);
    A = (int *)malloc(N*sizeof(int));
    for(i = 0; i < N; i++){
        scanf("%d", &A[i]);
    }
    
    scanf("%d", &M);
    B = (struct numeros *)malloc(M*sizeof(struct numeros));
    for(i = 0; i < M; i++){
        scanf("%d", &B[i].n);
        B[i].check = 0;
    }
    
    perdidos = (int *)malloc((M-N)*sizeof(int));
    
    for(i = 0; i < M - 1; i++){
        c1 = 0;
        c2 = 0;
        if(B[i].check == 0){
            for(j = i; j < M; j++){
                if(B[i].n == B[j].n){
                    c1++;
                    B[j].check = 1;
                }
            }
            for(j = 0; j < N; j++){
                if(B[i].n == A[j])
                    c2++;
            }
            if(c1 != c2){
                perdidos[c3] = B[i].n;
                c3++;
            }
        }
    }
    ordena_vetor(perdidos, c3);
    for(i = 0; i < c3; i++){
        if(i == c3 - 1){
            printf("%d\n", perdidos[i]);
        } else {
            printf("%d ", perdidos[i]);
        }
        
    }
    
    return 0;
}

void ordena_vetor(int *perdidos, int c3){
    int i, j, a;
    for (i = 0; i < c3; ++i){
        for (j = i + 1; j < c3; ++j){
            if (perdidos[i] > perdidos[j]) {
                a =  perdidos[i];
                perdidos[i] = perdidos[j];
                perdidos[j] = a;
            }
        }
    }
}