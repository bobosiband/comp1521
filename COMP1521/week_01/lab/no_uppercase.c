#include <stdio.h>
#include <ctype.h>
int main(void) {
	
	char c;
	// use getchar() to read input character by character
	while ((c = getchar()) != EOF) {
		if (c >= 'A' && c <= 'Z') {
			// convert uppercase to lowercase
			c = tolower(c);
		}
		// print the character
		putchar(c);
	}
	return 0;
}
