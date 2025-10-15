#include <stdio.h>
#include <string.h>
#define MAX 1024
int main(void) {
	char line[MAX];

	// read a line of input until EOF
	while (fgets(line, MAX, stdin) != NULL) {
		// check if the no of characters in the line is even
		if ((strlen(line)) % 2 == 0) {
			// print the line if it is even
			fputs(line, stdout);
		}
	}
	return 0;
}
