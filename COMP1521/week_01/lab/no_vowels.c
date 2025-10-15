#include <stdio.h>

int is_vowel(char c);
int main(void) {
	char c;
	while (scanf("%c", &c) != -1) {
		if (!is_vowel(c)) {
			printf("%c", c);
		}
	}
	return 0;
}
int is_vowel(char c) {
	if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
	    c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U') {
		return 1;
	} else {
		return 0;
	}
}