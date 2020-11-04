#include <stdio.h>
#include <math.h>

int main(void){
    double a, b, c, x1, x2;
    
    scanf("%lf %lf %lf", &a, &b, &c);
    
    x1 = (-b + sqrt(pow(b,2.0) - 4*a*c))/(2*a);
    x2 = (-b - sqrt(pow(b,2.0) - 4*a*c))/(2*a);
    
    printf("%.4lf %.4lf\n", x1, x2);
    
    return 0;
}