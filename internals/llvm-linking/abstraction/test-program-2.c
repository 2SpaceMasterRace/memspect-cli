#include <stdio.h>

int sum_of_square(int a, int b){
  int c = a*a + b*b;
  printf("%d\n",c);
}

int main(int argc, char *argv[])
{
  return sum_of_square(4,3);
}
