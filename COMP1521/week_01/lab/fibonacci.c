#include <stdio.h>
#include <stdlib.h>

#define SERIES_MAX 30
int fib(int n);
int main(void) {
    int n;
    while (scanf("%d", &n) != -1) {
        printf("%d\n", fib(n));
    }

    return 0;
}
int fib(int n) {
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    }
    
    return fib(n - 1) + fib(n - 2);
    
}