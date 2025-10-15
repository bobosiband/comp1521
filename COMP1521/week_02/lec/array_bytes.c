#include <stdio.h>

char a[] = {'a', 'b', 'c','d'};
int main(void) {
    int i;

loop_init:
    i = 0;
loop_cond:
    if (i >= sizeof(a)) goto loop_end;
loop_body:
    printf(" %c ",a[i]);
loop_step:
    i++;
    goto loop_cond;
loop_end:
    return 0;

}