#include<errno.h>
#include<stdio.h>
#include<stdlib.h>

#include "util.h"
#include "ext_sort.h"

void merge_files(char* output, char* input1, char* input2, int page_size);

int main(int argc, char** argv) {
    char input_name[] = "./input.txt";
    int page_size = 4000;
    int num_pages = 12;
    int i;
    FILE *fd;

    srand(42);
    fd = open_file(input_name, "w");
    if(fd == NULL){
        exit(EXIT_FAILURE);
    }
    for(i = 0; i < page_size*num_pages; i++) {
        fprintf(fd, "%d\n", rand());
    }
    fclose(fd);

    create_runs(input_name, page_size);
    /*
     *  Teste da funcao merge_files
     */
    merge_files("output_teste.txt", "r0.txt", "r1.txt", page_size);

    return 0;
}


void merge_files(char* output, char* input1, char* input2, int page_size){
    FILE* input1_file = open_file(input1, "r");
    FILE* input2_file = open_file(input2, "r");
    FILE* output_file = open_file(output, "w");

    int* output_buffer = (int*)malloc(2*page_size*sizeof(int));

    int i;

    for(i = 0; i < page_size; i++){
        fscanf(input1_file, "%d\n", &output_buffer[i]);
    }
    for(; i < 2*page_size; i++){
        fscanf(input2_file, "%d\n", &output_buffer[i]);
    }

    merge(output_buffer, 0, page_size, 2*page_size);
    write_buffer(output_file, output_buffer, 2*page_size);
    free(input1_file); free(input2_file); free(output_file);
}
