#include <stdio.h> 
#include <stdlib.h>
#include <math.h>

int div_hash(int key, int m);
int mul_hash(int key, int m, float a);


void q1aq1b(int m){
	int Hk, i;
	for (i = 0; i < 101; i++){
		Hk = div_hash(i, 12);
		if(Hk == 3){
			printf("%d = 3*%d\n", i, i/3);
		}
	}
	printf("\n");
}

void q1c(int m){
	int * v = (int *)malloc(sizeof(int)*m);
	int i;

	for(i = 0; i < m; i++){
		v[i] = 0;
	}

	for(i = 0; i < 10001; i++){
		v[div_hash(i, m)]++;
	}

	FILE * arq = fopen("q1c_saida.csv", "w");
	for(i = 0; i < m; i++){
		fprintf(arq, "%d,%d\n", i, v[i]);
	}
	fclose(arq);
	free(v);
}

void q2a(int m, float A){
	int i;
	int * v = (int *)malloc(sizeof(int)*m);

	for(i = 0; i < m; i++){
		v[i] = 0;
	}

	for(i = 1; i < 500001; i++){
		v[mul_hash(i, m, A)]++;
	}

	FILE * arq = fopen("q2a_saida.csv", "w");
	for(i = 0; i < m; i++){
		fprintf(arq, "%d,%d\n", i, v[i]);
	}
	fclose(arq);
	free(v);
}

void q2b(int m, float A){
	int i;
	int * v = (int *)malloc(sizeof(int)*m);

	for(i = 0; i < m; i++){
		v[i] = 0;
	}

	for(i = 1; i < 500001; i++){
		v[mul_hash(i, m, A)]++;
	}

	FILE * arq = fopen("q2b_saida.csv", "w");
	for(i = 0; i < m; i++){
		fprintf(arq, "%d,%d\n", i, v[i]);
	}
	fclose(arq);
	free(v);
}

int main(void){
	q1aq1b(12);
	q1aq1b(11);
	q1c(97);
	q2a(200, 0.62);
	q2b(200, 0.61803398875);
	return 0;
}

int div_hash(int key, int m){
	return key%m;
}

int mul_hash(int key, int m, float A){
	int h; 
	h = floor(m * ( key*A - (int)(key*A) ) );
	return h;
}