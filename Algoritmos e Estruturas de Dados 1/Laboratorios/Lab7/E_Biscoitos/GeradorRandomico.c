#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv){
    int m = atoi(argv[1]), j, n = atoi(argv[2]), i;
    srand(time(NULL));
    printf("%d\n", n);
    for(j = 0; j < m; j++){
        for(i = 0; i < n; i++){
            printf("%d%s", rand()%100, i < n-1?" ":"\n");
        }
    }
    return 0;
}
