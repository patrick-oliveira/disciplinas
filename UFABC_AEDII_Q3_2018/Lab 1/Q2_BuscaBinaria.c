






p0-78#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int binary_search(int [], int, int);
int * gera_vetor_inteiros(int); /* gera um vetor de inteiros aleatorios */
void imprime_vetor(int *, int);
void quicksort(int *, int, int, int);
int separa(int *, int, int, int);

int main(int argc, char **argv){
    int array_size, key, *array;
    int i, testes;
    clock_t t_inicio, t_fim;
    double delta;
    srand(time(NULL));

    printf("O tempo de ordenacao nao eh contabilizado.\n");

    printf("Quantidade de testes: ");
    scanf("%d", testes);
    while(testes >= 0){
        printf("Tamanho do vetor: ");
        scanf("%d", &array_size);
        array = gera_vetor_inteiros(array_size);
        t_inicio = clock();
        quicksort(array, 0, array_size - 1, array_size);
        t_fim = clock();
        delta = 1e6*(double)(t_fim - t_inicio)/CLOCKS_PER_SEC;
        printf("Tempo de ordenacao: %.2lf\n", delta);

        if((rand()%100)%2 == 0){    // gera uma chave para ser encontrada
            key =  array[rand()%array_size];
        } else {                    // gera uma chave improvavel de ser encontrada
            key = rand()%10000;
        }
        printf("Chave: %d\n", key);


        t_inicio = clock();
        i = binary_search(array, array_size, key);
        t_fim = clock();
        delta = 1e6*(double)(t_fim - t_inicio)/CLOCKS_PER_SEC;


        if(i != -1){
            printf("Indice: %d\t Tempo: %.2lf\n", i, delta);
        } else {
            printf("Nao encontrado.\t Tempo: %.2lf\n", delta);
        }

        printf("\n");
        testes--;
    }
    return 0;
}

int * gera_vetor_inteiros(int tamanho){
    int * v = (int *)malloc(sizeof(int)*tamanho);
    int i;
    for(i = 0; i < tamanho; i++){
        v[i] = rand()%1000;
    }
    return v;
}

void imprime_vetor(int * v, int tamanho){
    int i;
    for(i = 0; i < tamanho; i++){
        printf("%d ", v[i]);
    }
    printf("\n");
}

void quicksort(int * v, int p, int r, int N){
    int j;
    if(p < r){
        j = separa(v, p, r, N);
        quicksort(v, p, j-1, N);
        quicksort(v, j+1, r, N);
    }
}

int separa(int *v, int p, int r, int N){
    int c = v[p], i = p+1, j = r, t;
    while(i <= j){
        if (v[i] <= c) ++i;
        else if (c < v[j]) --j;
        else {
            t = v[i], v[i] = v[j], v[j] = t;
            ++i; --j;
        }
    }
    v[p] = v[j], v[j] = c;
    return j;
}


int binary_search(int array[], int array_size, int key){
    int pi = 0, pj = array_size - 1, k;
    k = (pi + pj)/2;
    while(pi <= pj){
        if(array[k] == key){
            return k;
        } else {
            if(array[k] < key){
                pi = k + 1;
            } else {
                pj = k - 1;
            }
            k = (pi + pj)/2;
        }
    }
    return -1;
}
