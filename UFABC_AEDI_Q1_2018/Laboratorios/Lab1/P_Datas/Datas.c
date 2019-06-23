#include <stdio.h>

int bissexto(int);
void data_validacao(int, int, int);

int main(void){
    int N, d, m, a, i;
    
    scanf("%d", &N);
    for(i = 0; i < N; i++){
        scanf("%d %d %d", &d, &m, &a);
        data_validacao(d, m, a);
    }
    
    return 0;
}

void data_validacao(int d, int m, int a){
    if(a < 0){
        printf("DATA INVALIDA\n");
    }
    
    if (m == 2){
        if(bissexto(a)){
            if(d >= 1 && d <= 29){
                printf("DATA VALIDA\n");
            } else {
                printf("DATA INVALIDA\n");
            }
        } else {
            if(d >= 1 && d <= 28){
                printf("DATA VALIDA\n");
            } else {
                printf("DATA INVALIDA\n");
            }
        }
    } else if(m >= 1 && m <= 12){
        switch(m){
            case 1:
                if(d >= 1 && d <= 31){
                    printf("DATA VALIDA\n");
                } else {
                    printf("DATA INVALIDA\n");
                }
                break;
            case 3:
                if(d >= 1 && d <= 31){
                    printf("DATA VALIDA\n");
                } else {
                    printf("DATA INVALIDA\n");
                }
                break;
            case 4:
                if(d >= 1 && d <= 30){
                    printf("DATA VALIDA\n");
                } else {
                    printf("DATA INVALIDA\n");
                }
                break;
            case 5:
                if(d >= 1 && d <= 31){
                    printf("DATA VALIDA\n");
                } else {
                    printf("DATA INVALIDA\n");
                }
                break;
            case 6:
                if(d >= 1 && d <= 30){
                    printf("DATA VALIDA\n");
                } else {
                    printf("DATA INVALIDA\n");
                }
                break;
            case 7:
                if(d >= 1 && d <= 31){
                    printf("DATA VALIDA\n");
                } else {
                    printf("DATA INVALIDA\n");
                }
                break;
            case 8:
                if(d >= 1 && d <= 31){
                    printf("DATA VALIDA\n");
                } else {
                    printf("DATA INVALIDA\n");
                }
                break;
            case 9:
                if(d >= 1 && d <= 30){
                    printf("DATA VALIDA\n");
                } else {
                    printf("DATA INVALIDA\n");
                }
                break;
            case 10:
                if(d >= 1 && d <= 31){
                    printf("DATA VALIDA\n");
                } else {
                    printf("DATA INVALIDA\n");
                }
                break;
            case 11:
                if(d >= 1 && d <= 30){
                    printf("DATA VALIDA\n");
                } else {
                    printf("DATA INVALIDA\n");
                }
                break;
            case 12:
                if(d >= 1 && d <= 31){
                    printf("DATA VALIDA\n");
                } else {
                    printf("DATA INVALIDA\n");
                }
                break;
        }  
    } else {
        printf("DATA INVALIDA\n");
    }
}

int bissexto(int ano){
    if(ano%400 == 0){
        return 1;
    } else if (ano%4 == 0){
        if (ano%100 == 0){
            return 0;
        } else {
            return 1;
        }
    } else {
        return 0;
    }
}