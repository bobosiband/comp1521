#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <filename> [byte_value1] [byte_value2] ...\n", argv[0]);
        return 1;
    }
    char *filename  = argv[1];
    FILE *f = fopen(filename, "wb");
    int i = 2;
    while (i < argc) {
        int byte_value = atoi(argv[i]);
        if (byte_value >= 0 && byte_value <= 255) {
            fputc(byte_value, f);
        } else {
            fprintf(stderr, "Error: Byte value %d is out of range (0-255) and will be skipped.\n", byte_value);
        }
        i++;
    }
    fclose(f);
    return 0;
} 