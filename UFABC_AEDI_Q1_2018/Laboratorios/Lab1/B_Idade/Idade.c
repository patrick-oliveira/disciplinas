#include <stdio.h>

int main(void){
    int ano_atual, d_nascimento, idade;
    char nome[100];
    
    scanf("%d %s %d", &ano_atual, nome,  &d_nascimento);
    idade = ano_atual - d_nascimento;
    
    printf("%s, voce completa %d anos de idade neste ano.\n", nome, idade);
    
    return 0;
}