#include <stdio.h>

int divisor(int, int);

int main(){
  int a, b, q, r;

  scanf("%d %d", &a, &b);
  q = divisor(a, b);
  r = a - q*b;
  printf("%d com resto %d\n", q, r);
}

int divisor(int a, int b){
  if(a < b){
    return 0;
  } else {
    return divisor(a - b, b) + 1;
  }
}
