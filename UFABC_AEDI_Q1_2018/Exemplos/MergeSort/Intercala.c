#include <stdio.h>
#include <stdlib.h>

void intercala1(int, int, int, int *);
void intercala2(int, int, int, int *);

int main(){
    int q1, q2, i;
    int * v;

    scanf("%d %d", &q1, &q2);
    v = (int *)malloc(sizeof(int)*(q1 + q2));

    for(i = 0; i < q1 + q2; i++)
        scanf("%d", &v[i]);

    intercala1(0, q1, q1 + q2, v);
    
    for(i = 0; i < (q1 + q2); i++)
        printf("%d%s", v[i], i < (q1+q2)-1?" ":"\n");

    return 0;
}

void intercala1(int p, int q, int r, int * v){
    // esse código é mais geral
    // nele eu posso enviar partes do meu vetor para ser intercalado.
    // suponha um subvetor qualquer, p denota o inicio do primeiro sub-subvetor
    // q denota o inicio do segundo sub-subvetor
    // r denota o tamanho do subvetor
    int i, j, k, *w; // Preciso criar um vetor auxiliar
    w = (int *)malloc(sizeof(int)*(r - p)); // r - p será 0 quando eu enviar o vetor inteiro, pois p = 0
    i = p; j = q;
    k = 0;
    while(i < q && j < r){
        if(v[i] <= v[j]) w[k++] = v[i++];
        else w[k++] = v[j++];
    }
    /*
        Nessa parte do código o loop comparará dois a dois cada
        elemento dos sub-subvetores, os alocando ordenadamente no
        vetor w.
        O loop parará quando um dos dois sub-subvetores for completamente
        alocado no vetor w.
    */
   while (i < q) w[k++] = v[i++];
   while (j < r) w[k++] = v[j++];
   /*
        Uma vez que o loop anterior termina quando um dos dois
        sub-subvetores foi completamente alocado, estes dois loops
        acima farão o trabalho de alocar o restante dos elementos, já
        ordenados.
   */
   for (i = p; i < r; ++i) v[i] = w[i - p];
   free(w);
}

void intercala2(int p, int q, int r, int * v){
    int i, j, k, *w;
    w = (int *)malloc(sizeof(int)*(r - p));

    for(i = p; i < q; ++i) w[i - p] = v[i];
    for(j = q; j < r; ++j) w[r-p+q-j-1] = v[j];
    i = 0; j = r - p - 1;
    // um 'ponteiro' no início de w, outro no final;
    for(k = p; k < r; ++k)
        if(w[i] <= w[j]) v[k] = w[i++];
        else v[k] = w[j--];
    /*
        k percorrerá o vetor v[] inteiro, comparando os termos
        dos subvetores de w. Mesmo processo anterior.
        Qual a vantagem? Evita a verificação dos limites dos sub
        vetores de v[] (variáveis i e j); Nesse caso há apenas
        uma seleção do menor valor em w[] para ser encaixado em v[]
        ordenadamente.
    */
    free(w);
}