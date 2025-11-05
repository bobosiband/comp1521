#include <stdio.h>
#include <ctype.h> // For isprint() function

int main(int argc, char *argv[]) {
    FILE *file = fopen(argv[1], "rb");
    int byte;
    long byte_count = 0;

    while ((byte = fgetc(file)) != EOF) {
        printf("byte %4ld: %3d 0x%02x", byte_count, byte, byte);
        if (isprint(byte)) {
            printf(" '%c'", byte); 
        }
        printf("\n"); 
        byte_count++;
    }

    fclose(file);

    return 0;
}