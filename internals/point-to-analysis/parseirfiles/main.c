#include<stdio.h>
#include<stdlib.h>

int main() { 
    int* p,a,*q,**r;
    p = &a;
    p = q;
    p = *r;
    *p = &a;
    *p = q;
    *p = *r;
    return 0;
}