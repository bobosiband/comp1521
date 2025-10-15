#include <stdio.h>
#include <stdlib.h>

int collatz(int n);

int main(int argc, char *argv[]) {
	if (argc < 2) {
		printf("Usage: ./collatz NUMBER\n");
		return 1;
	}
	int num  = atoi(argv[1]);
	collatz(num);
	return 0;
}

int collatz(int n) {
	printf("%d\n", n);
	if (n == 1) {
		return 0;
	}
	if (n % 2 == 0) {
		return collatz(n / 2);
	} else {
		return collatz(3 * n + 1);
	}
}