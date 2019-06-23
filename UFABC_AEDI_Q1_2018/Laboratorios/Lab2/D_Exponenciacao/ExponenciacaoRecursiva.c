#include <stdio.h>
#include <math.h>

double exponenciacao(int, int);

int main(){
    int A, N;
    scanf("%d %d", &A, &N);
    
    printf("%0.lf\n", exponenciacao(A, N));
    
    return 0;
}

double exponenciacao(int A, int N){
    if(N == 0){
        return 1;
    } else {
        return A*exponenciacao(A, N - 1);
    }
}