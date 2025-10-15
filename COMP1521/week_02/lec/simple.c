#include <stdio.h>

int main(void) {
    int sum = 0;
    goto name;
    name:
        printf("Bongani");
        goto stupid;
    stupid:
        printf("  SIBANDA\n");
        sum++;
        if (sum > 10) {
            goto end;
        }
        goto name;
    end:
    return 0;

}
