#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void gera_vetor_inteiros(int, int);

int main(){
    int quantidade, tamanho, opc;
    printf("1 - Gerar vetores de inteiros.\n");
    printf("Digite a opcao desejada: ");
    scanf("%d", &opc);
    if(opc == 1){
        scanf("%d %d", &quantidade, & tamanho);
        gera_vetor_inteiros(quantidade, tamanho);
    }
    return 0;
}

void gera_vetor_inteiros(int quantidade, int tamanho){
    int * vetor = (int *)malloc(tamanho*sizeof(int));
    int i, j;
    srand(time(NULL));
    FILE *file = fopen("vetores_teste.txt", "w");
    fprintf(file, "%d %d\n", quantidade, tamanho);
    for(i = 0; i < quantidade; i++){
        for(j = 0; j < tamanho; j++){
            fprintf(file, "%d ", rand()%1000);
        }
        fprintf(file, "\n");
    }
    fclose(file);
}
