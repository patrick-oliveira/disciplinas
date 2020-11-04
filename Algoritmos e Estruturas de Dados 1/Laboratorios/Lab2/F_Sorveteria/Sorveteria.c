#include <stdio.h>
#include <stdlib.h>

struct sabores{
    int ID;
    int Ci;
};

void buscar_sabores(struct sabores *, int *, int *, int, int);

int main(){
    int T, M, N, i, j;
    int s1, s2;
    struct sabores *Sabores;
    
    scanf("%d", &T);
    
    for(i = 0; i < T; i++){
        scanf("%d", &M);
        scanf("%d", &N);
        Sabores = (struct sabores *)malloc(N*sizeof(struct sabores));
        for(j = 0; j < N; j++){
            Sabores[j].ID = j + 1;
            scanf("%d", &Sabores[j].Ci);
        }
        buscar_sabores(Sabores, &s1, &s2, N, M);
        printf("%d %d\n", s1, s2);
    }
    
    
    return 0;
}

void buscar_sabores(struct sabores *Sabores, int *s1, int *s2, int N, int M){
    int i, j;
    for(i = 0; i < N; i++){
        *s1 = Sabores[i].ID;
        for(j = i + 1; j < N; j++){
            *s2 = Sabores[j].ID;
            if(Sabores[i].Ci + Sabores[j].Ci == M){
                return;
            }
        }
    }
    
}