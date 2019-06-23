#include <stdio.h>
#include <string.h>

int main(void){
    char paciente[3], doador[3];
    
    scanf("%s %s", paciente, doador);

    if(strcmp(paciente, "A") == 0){
        if(strcmp(doador, "A") == 0) printf("transfusao compativel\n");
        else if (strcmp(doador, "B") == 0) printf("transfusao incompativel\n");
        else if (strcmp(doador, "O") == 0) printf("transfusao compativel\n");
        else printf("transfusao incompativel\n");
    } else if(strcmp(paciente, "B") == 0) {
        if(strcmp(doador, "A") == 0) printf("transfusao incompativel\n");
        else if (strcmp(doador, "B") == 0) printf("transfusao compativel\n");
        else if (strcmp(doador, "O") == 0) printf("transfusao compativel\n");
        else printf("transfusao incompativel\n");
    } else if(strcmp(paciente, "O") == 0){
        if(strcmp(doador, "A") == 0) printf("transfusao incompativel\n");
        else if (strcmp(doador, "B") == 0) printf("transfusao incompativel\n");
        else if (strcmp(doador, "O") == 0) printf("transfusao compativel\n");
        else printf("transfusao incompativel\n");
    } else {
        if(strcmp(doador, "A") == 0) printf("transfusao compativel\n");
        else if (strcmp(doador, "B") == 0) printf("transfusao compativel\n");
        else if (strcmp(doador, "O") == 0) printf("transfusao compativel\n");
        else printf("transfusao compativel\n");
    }

    return 0;
}