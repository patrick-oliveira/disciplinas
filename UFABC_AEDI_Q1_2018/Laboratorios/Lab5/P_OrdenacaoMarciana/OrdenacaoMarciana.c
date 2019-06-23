#include <stdio.h>
#include <stdlib.h>

int decodifica_troca(int);
int decodifica(int);
void bubblesort(int *, int);

int main(){
    int N, i, teste1, teste2;
    int * v;
    
    scanf("%d", &N);
    v = (int *)malloc(sizeof(int)*N);
    
    for(i = 0; i < N; i++){
        scanf("%d", &v[i]);
        v[i] = decodifica(v[i]);
    }
    bubblesort(v, N);
    for(i = 0; i < N; i++){
        v[i] = codifica(v[i]);
        printf("%d%s", v[i], i < N - 1?" ":"\n");
    }
    return 0;
}

void bubblesort(int * v, int n){
    int i, j, aux;
    for(i = 0; i < n - 1; i++){
        for(j = 0; j < n - 1 - i; j++){
            if(v[j] > v[j + 1]){
                aux = v[j];
                v[j] = v[j+1];
                v[j+1] = aux;
            }
        }
    }
}

int decodifica(int N){
    int temp = 0, digito, i;
    for(i = 0; N > 0; i++){
        digito = N%10;
        digito = decodifica_troca(digito);
        temp = temp + digito*pot(10, i);
        N = N/10;
    }
    return temp;
}

int codifica(int N){
    int temp = 0, digito, i;
    for(i = 0; N > 0; i++){
        digito = N%10;
        digito = codifica_troca(digito);
        temp = temp + digito*pot(10, i);
        N = N/10;
    }
    return temp;
}

int decodifica_troca(int N){
    int temp = N;
    switch(temp){
        case 0: temp = 0; break;
        case 5: temp = 1; break;
        case 6: temp = 2; break;
        case 4: temp = 3; break;
        case 8: temp = 4; break;
        case 9: temp = 5; break;
        case 7: temp = 6; break;
        case 3: temp = 7; break;
        case 1: temp = 8; break;
        case 2: temp = 9; break;
        default: break;
    }
    return temp;
}

int codifica_troca(int N){
    int temp = N;
    switch(temp){
        case 0: temp = 0; break;
        case 1: temp = 5; break;
        case 2: temp = 6; break;
        case 3: temp = 4; break;
        case 4: temp = 8; break;
        case 5: temp = 9; break;
        case 6: temp = 7; break;
        case 7: temp = 3; break;
        case 8: temp = 1; break;
        case 9: temp = 2; break;
        default: break;
    }
    return temp;
}

int pot(int N, int potencia){
    int i, temp = 1;
    for(i = 0; i < potencia; i++){
        temp = N*temp;
    }
    return temp;
}

