/*
compile as

gcc ising.c -lm -o ising

seems to require between 10^4 to 10^5 steps per atom (MCTS) to give good results
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
/*libraries*/

#define rand_range(n)   (rand()%(n))                                /*random integer in the 0 .. n-1 range*/
#define rand_spin()     (rand() & 1 ? 1 : -1)                       /*Rademacher variable*/
#define rand_try(p)     (((float) rand())/RAND_MAX < p ? 1 : 0)     /*result of an attempt that succeeds with probability p*/

/*crude but effective RNG*/

#define UP(i)    (((i) + N - W) % N)
#define DOWN(i)  (((i) + W) % N)
#define LEFT(i)  (((i)/W)*W + ((i) + W - 1) % W)
#define RIGHT(i) (((i)/W)*W + ((i) + 1) % W)
int W, N;

/*implicitly defines the geometry as a rectangular lattice using periodic boundary conditions and with width W, height H and N = W*H sites*/

#define ARG_L          argv[1]
#define ARG_STEPS      argv[2]
#define ARG_TEMP       argv[3]
#define ARG_OUT        argv[4]
#define ARG_SEED       argv[5]
#define ARGS           6

/*easy to remember args*/

int main(int argc, char *argv[]){
    int     *lattice;        /*the lattice spins*/
    int      magnetisation;  /*twice the magnetisation in spin units*/
    double   temperature;    /*temperature in a convenient unit (Tc = 2.2692)*/
    int      t, MCTS;
	FILE	*out;
	int      i, j;
	double   prob_delta_4, prob_delta_8;
	int      delta_E, flip;
    
    if(argc != ARGS){
        printf("Correct usage:\n[L (int)] [MCTS -- steps by atom (int)] [TEMPERATURE (float)] [OUTPUT (str)] [SEED (int)]\n\n\n");
		return 0;
    }
    W           = atoi(ARG_L);
    N           = W*W;
    lattice     = (int *) malloc (N*sizeof(int));
    MCTS        = atoi(ARG_STEPS);
	temperature = atof(ARG_TEMP);
	out  		= fopen(ARG_OUT, "w");
	srand(atoi(ARG_SEED));
	prob_delta_4 = exp(-4./temperature);
	prob_delta_8 = exp(-8./temperature);
	/*read and interpret the arguments*/
	
	for(i = 0; i < N; i ++)
	    lattice[i]     = rand_spin();
    /*the initial_condition*/

    for(magnetisation = 0, i = 0; i < N; i++)
        magnetisation += lattice[i];

    fprintf(out, "L=%d\tMCTS=%dT=%lf\nMagnetisation:\n\n%lf\n", W, MCTS, temperature, ((double) magnetisation)/N);
    for(t = 0; t < MCTS; t ++){
        for(j = 0; j < N; j ++){
            i       = rand_range(N);
            delta_E = 2*lattice[i]*(lattice[LEFT(i)] + lattice[RIGHT(i)] + lattice[UP(i)] + lattice[DOWN(i)]);
            if(delta_E <= 0){
                flip = 1;
            }
            else if(delta_E == 4){
                flip = rand_try(prob_delta_4);
            }
            else if(delta_E == 8){
                flip = rand_try(prob_delta_8);
            }
            if(flip){
                magnetisation -= 2*lattice[i];
                lattice[i]     = -lattice[i];
            }
        }
        fprintf(out, "%lf\n", ((double) magnetisation)/N);
    }
    fclose(out);
    free(lattice);
    return 0;
}

