#include <stdio.h>
#include <stdlib.h>
#define troca(A, B) { int t = A; A = B; B = t; }

typedef struct h {
    int * v;
    int qtdeElementos;
} heap;

int pai(int);
int filhoE(int);
int filhoD(int);
heap * inicializaHeap(void);
void construir_min(int *, int);
void peneirar_min(int *, int , int);
int menor(int *, int, int, int, int);
void adicionaElemento_min(heap *, int);
void construir_max(int *, int);
void peneirar_max(int *, int, int);
int maior(int *, int, int, int, int);
void adicionaElemento_max(heap *, int);
int removeElemento_min(heap *);
int removeElemento_max(heap *);


int main(){
    int N, i, input;
    float mediana = 0;
    heap * max_heap = inicializaHeap();
    heap * min_heap = inicializaHeap();
    
    scanf("%d", &N);
    for(i = 0; i < N; i++){
        scanf("%d", &input);
            if(i == 0){ // primeiro elemento a ser inserido
                mediana = input;
            } else if(i%2 == 0){ // ha um numero par de elementos ja adicionados
                if(input < mediana){
                    adicionaElemento_max(max_heap, input);
                    mediana = removeElemento_max(max_heap);
                } else {
                    adicionaElemento_min(min_heap, input);
                    mediana = removeElemento_min(min_heap);
                }
            } else if(i%2 != 0) { // ha um numero impar de elementos ja adicionados
                if(mediana > input){
                    adicionaElemento_max(max_heap, input);
                    adicionaElemento_min(min_heap, (int)mediana);
                } else {
                    adicionaElemento_max(max_heap, (int)mediana);
                    adicionaElemento_min(min_heap, input);
                }
                if(max_heap -> v[0] != 0)
                    mediana = ((float)max_heap -> v[0] + (float)min_heap -> v[0])/2;
                else{
                    mediana = removeElemento_min(min_heap);
                    i--;
                }
            }
        printf("%d : ", i + 1);
        printf("%d : ", max_heap -> v[0]);
        printf("%0.1f : ", mediana);
        printf("%d\n", min_heap -> v[0]);
    }
    
    return 0;
}

int pai(int ind){ if(ind != 0) return (ind - 1)/2; }
int filhoE(int ind){ return 2*ind + 1; }
int filhoD(int ind){ return 2*ind + 2; }

heap * inicializaHeap(void){
    heap * Temp = (heap *)malloc(sizeof(heap));
    Temp -> v = (int *)malloc(sizeof(int)*100000);
    Temp -> qtdeElementos = 0;
    return Temp;
}

void construir_min(int * v, int N){
    int i;
    for(i = (N / 2) - 1; i >= 0; i--){
        peneirar_min(v, N, i);
    }
}

void peneirar_min(int * v, int N, int pai){
    if(pai >= N/2){
        return;
    } else{
        int m = menor(v, N, pai, filhoE(pai), filhoD(pai));
        if (m != pai){  
            troca(v[pai], v[m]);
            peneirar_min(v, N, m);
        }
    }
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

void adicionaElemento_min(heap * Heap, int input){
    Heap -> qtdeElementos++;
    Heap -> v[(Heap -> qtdeElementos) - 1] = input;
    int i = Heap -> qtdeElementos - 1;
    while(i >= 1 && Heap -> v[i/2] > Heap -> v[i]){
        troca(Heap -> v[i/2], Heap -> v[i]);
        i = i/2;
    }
}

void construir_max(int * v, int N){
    int i;
    for(i = (N / 2) - 1; i >= 0; i--){
        peneirar_max(v, N, i);
    }
}

void peneirar_max(int * v, int N, int pai){
    if(pai >= N/2){
        return;
    } else {
        int m = maior(v, N, pai, filhoE(pai), filhoD(pai));
        if(m != pai){
            troca(v[pai], v[m]);
            peneirar_max(v, N, m);
        }
    }
}

int maior(int * v, int N, int pai, int filhoE, int filhoD){
    if(N%2 == 0 && pai == (N - 1)/2){ // o ultimo pai so tem um filho a esquerda
        if(v[filhoE] > v[pai]) return filhoE;
        else return pai;
    } else {
        int maior;
        if(v[filhoE] > v[filhoD]) maior = filhoE;
        else maior = filhoD;
        
        if(v[pai] > v[maior]) return pai;
        else return maior;
    }
}

void adicionaElemento_max(heap * Heap, int input){
    Heap -> qtdeElementos++;
    Heap -> v[(Heap -> qtdeElementos) - 1] = input;
    int i = Heap -> qtdeElementos - 1;
    while(i >= 1 && Heap -> v[i/2] < Heap -> v[i]){
        troca(Heap -> v[i/2], Heap -> v[i]);
        i = i/2;
    }
}

int removeElemento_min(heap * Heap){
    int temp = Heap -> v[0];
    troca(Heap -> v[0], Heap -> v[Heap -> qtdeElementos - 1]);
    Heap -> v[Heap -> qtdeElementos - 1] = 0;
    Heap -> qtdeElementos--;
    peneirar_min(Heap -> v, Heap -> qtdeElementos, 0);
    return temp;
}

int removeElemento_max(heap * Heap){
    int temp = Heap -> v[0];
    troca(Heap -> v[0], Heap -> v[Heap -> qtdeElementos - 1]);
    Heap -> v[Heap -> qtdeElementos - 1] = 0;
    Heap -> qtdeElementos--;
    peneirar_max(Heap -> v, Heap -> qtdeElementos, 0);
    return temp;
}