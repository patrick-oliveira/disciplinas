/*
compile as

gcc bayes.c -lm -o bayes
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define rand_range(n)   (rand()%(n))                                /*random integer in the 0 .. n-1 range*/
#define rand_try(p)     (((float) rand())/RAND_MAX < p ? 1 : 0)     /*result of an attempt that succeeds with probability p*/
#define uniform()       (((double) rand())/RAND_MAX)

#define ARG_INPUT      argv[1]
#define ARG_STEPS      argv[2]
#define ARG_LAMB       argv[3]
#define ARG_OUT        argv[4]
#define ARG_SEED       argv[5]
#define ARGS           6

#define STEP_SIGMA     0.05     /*size of the steps of the random walk (sigma for the n_mu and n_sigma)*/

double n_mu, n_sigma;   /*steps*/

int    N;
double x_av, x_sig;     /*data variables*/

double lambda;          /*prior parameter*/

void update_normals(){
    double x, y, s;
    
    do{
        x = 2*uniform()-1;
        y = 2*uniform()-1;
        s = x*x + y*y;
    } while(s > 1);
    s       = sqrt(-2*log(s)/s);
    n_mu    = x*s;
    n_sigma = y*s;
} /*Marsaglia's Polar Method for drawing Normal Variables*/

double rho_param(double mu, double sigma){
    return lambda*exp(-lambda*sigma-mu*mu/2)/sqrt(2*M_PI);
}

double rho_data(double mu, double sigma, int N){
    return pow(exp(-0.5*(x_sig*x_sig+(mu-x_av)*(mu-x_av))/(sigma*sigma))/(sigma*sqrt(2*M_PI)), N);
}

double A(double mu_, double sigma_, double mu, double sigma, int N){
    double A_;
    
    A_ = rho_param(mu_, sigma_)*rho_data(mu_, sigma_, N)/(rho_param(mu, sigma)*rho_data(mu, sigma, N));
    return (A_ > 1 ? 1 : A_);
} /*the acceptance probability*/

int main(int argc, char *argv[]){
    FILE  *in, *out;
    int    steps;
    int    i;
    double aux_float, sum_x, sum_x2;
    double mu, sigma, mu_, sigma_;
    double sum_mu, sum_sig;
    
    if(argc != ARGS){
        printf("Correct usage:\n[INPUT FILE (str)] [steps (int)] [lambda prior (float)] [OUTPUT (str)] [SEED (int)]\n\n");
        printf("INPUT FORMAT:\n[N (int)]\n[data (float * N)]\n\n\n");
		return 0;
    }
    in     = fopen(ARG_INPUT, "r");
    steps  = atoi(ARG_STEPS);
    lambda = atof(ARG_LAMB);
	out    = fopen(ARG_OUT, "w");
	srand(atoi(ARG_SEED));
	/*read and interpret the arguments*/
	fscanf(in, "%d", &N);
	sum_x = sum_x2 = 0;
	for(i = 0; i < N && !feof(in); i ++){
	    fscanf(in, "%lf", &aux_float);
	    sum_x  += aux_float;
	    sum_x2 += aux_float*aux_float;
	}
	if(i != N){
	    printf("Premature end to the input file. Run without arguments for instructions.\n\n");
	    fclose(in);
	    fclose(out);
	    return 0;
	}
	x_av  = sum_x/N;
	x_sig = sqrt(sum_x2/N - x_av*x_av);
	printf("%lf\t%lf\n", x_av, x_sig);
	fclose(in);
	/*read the input file with the data to be used*/
	
	sum_mu  = 0;
	sum_sig = 0;
	mu      = 0;
	sigma   = 1;
	
	for(i = 0; i < steps; i ++){
	    do{
	        update_normals();
    	    mu_      = mu    + n_mu*STEP_SIGMA;
    	    sigma_   = sigma + n_sigma*STEP_SIGMA;
	    } while(sigma_ <= 0);    /*the prior is zero for sigma_ <= 0, so we can't propose it*/
	    if(rand_try(A(mu_, sigma_, mu, sigma, N))){
	        mu    = mu_;
	        sigma = sigma_;
	    }
	    sum_mu  += mu;
	    sum_sig += sigma;
	    fprintf(out, "%lf\t%lf\n", mu, sigma);
	}
	printf("%lf\t%lf\n", sum_mu/steps, sum_sig/steps);
	fclose(out);
    
    return 0;
}

