#include <stdio.h>
#include <stdlib.h>
#define troca(A, B) { int t = A; A = B; B = t; };


struct heap{
    int *v;
    int qtdeElementos;
};

void construir(int *, int);
void imprimirVetor(int *, int);
struct heap * inicializaHeap(void);
void adicionaElemento(struct heap *, int);
void removeElemento(struct heap *, int);
void peneirar(int *, int, int);

int main(){
    int Q, comando, input, i;
    
    struct heap * Heap = inicializaHeap();
    
    scanf("%d", &Q);
    for(i = 0; i < Q; i++){
        scanf("%d", &comando);
        if(comando == 1){
            scanf("%d", &input);
            adicionaElemento(Heap, input);
        } else if (comando == 2){
            scanf("%d", &input);
            removeElemento(Heap, input);
        } else {
            if (Heap -> qtdeElementos != 0) printf("%d\n", Heap -> v[0]);
        }
    }
    
    
    return 0;
}

void removeElemento(struct heap * Heap, int input){
    int i = 0;
    while(Heap -> v[i] != input){
        i++;
    }
        
    troca(Heap -> v[i], Heap -> v[Heap -> qtdeElementos - 1]);
    Heap -> qtdeElementos--;
    peneirar(Heap -> v, Heap -> qtdeElementos, i);
    //  construir(Heap -> v, Heap -> qtdeElementos);
}

void adicionaElemento(struct heap * Heap, int input){
    Heap -> qtdeElementos++;
    Heap -> v[(Heap -> qtdeElementos) - 1] = input;
    int i = Heap -> qtdeElementos - 1;
    while(i >= 1 && Heap -> v[i/2] > Heap -> v[i]){
        troca(Heap -> v[i/2], Heap -> v[i]);
        i = i/2;
    }
}

struct heap * inicializaHeap(void){
    struct heap * Temp = (struct heap *)malloc(sizeof(struct heap));
    Temp -> v = (int *)malloc(sizeof(int)*100000);
    Temp -> qtdeElementos = 0;
    return Temp;
}

int filhoE(int ind){
    return 2*ind + 1;
}

int filhoD(int ind){
    return 2*ind + 2;
}

int Pai(int ind){
    if(ind != 0) return (ind - 1)/2;
}

int menor(int * v, int N, int pai, int filhoE, int filhoD){
    if(N%2 == 0 && pai == (N - 1)/2){
        if(v[filhoE] > v[pai]) return pai;
        else return filhoE;
    } else {
        int menor;
        if(v[filhoE] > v[filhoD]) menor = filhoD;
        else menor = filhoE;
        
        if(v[pai] > v[menor]) return menor;
        else return pai;        
    }
}

void peneirar(int * v, int N, int pai){
    if(pai >= N/2){
        return;
    } else{
        int m = menor(v, N, pai, filhoE(pai), filhoD(pai));
        if (m != pai){  
            troca(v[pai], v[m]);
            peneirar(v, N, m);
        }
    }
}

void construir(int * v, int N){
    int i;
    for(i = (N / 2) - 1; i >= 0; i--){
        peneirar(v, N, i);
    }
}

void imprimirVetor(int * v, int N){
    int i;
    for(i = 0; i < N; i++) printf("%d%s", v[i], i < N - 1?" ":"\n");
}