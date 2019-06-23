#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int seq_search(int array[], int array_size, int key);
int * gera_vetor_inteiros(int); /* gera um vetor de inteiros aleatorios */
void imprime_vetor(int *, int);

int main(int argc, char **argv){
    int array_size, key, *array;
    int i, testes;
    clock_t t_inicio, t_fim;
    srand(time(NULL));

    printf("Quantidade de testes: ");
    scanf("%d", testes);
    while(testes >= 0){
        printf("Tamanho do vetor: ");
        scanf("%d", &array_size);
        array = gera_vetor_inteiros(array_size);


        if((rand()%100)%2 == 0){    // gera uma chave para ser encontrada
            key =  array[rand()%array_size];
        } else {                    // gera uma chave improvavel de ser encontrada
            key = rand()%10000;
        }
        printf("Chave: %d\n", key);


        t_inicio = clock();
        i = seq_search(array, array_size, key);
        t_fim = clock();
        double delta = 1e6*(double)(t_fim - t_inicio)/CLOCKS_PER_SEC;


        if(i != -1){
            printf("Indice: %d\t Tempo: %.2lf\n", i, delta);
        } else {
            printf("Nao encontrado.\t Tempo: %.2lf\n", delta);
        }

        testes--;
    }
    return 0;
}

int seq_search(int array[], int array_size, int key){
    int i;
    for(i = 0; i < array_size; i++){
        if(array[i] == key){
            return i;
        }
    }

    return -1;
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
