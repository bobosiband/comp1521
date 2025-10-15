#include <unistd.h>
#include <stdio.h>

int main(void) {
    char bytes[13] = "Bongani\n";
    syscall(1,1, bytes, 12);
    write(1, bytes, 12);
    return 0;
}