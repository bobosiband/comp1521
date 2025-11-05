#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    // get the name from the command line 
    char *filename = argv[1];
    // open the file 
    FILE *f = fopen(filename, "w");
    int num1 = atoi(argv[2]);
    int num2 = atoi(argv[3]);

    while (num1 <= num2) {
        fprintf(f, "%d\n", num1);
        num1++;
    }
    fclose(f);
    return 0;
}