#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
	int Min;
	int Max;
	int sum = 0;
	int prod = 1;
	int mean;
	if (argc < 2) {
		printf("Usage: ./arg_stats NUMBER [NUMBER ...]\n");
		return 1;
	}
	Min = atoi(argv[1]);
	Max = atoi(argv[1]);
	for (int i = 1; i < argc; i++) {
		int num = atoi(argv[i]);
		sum += num;
		prod *= num;
		if (num < Min) {
			Min = num;
		} else if (num > Max) {
			Max = num;
		}
	}
	mean = sum / (argc - 1);
	printf("MIN:  %d\n", Min);
	printf("MAX:  %d\n", Max);
	printf("SUM:  %d\n", sum);
	printf("PROD: %d\n", prod);
	printf("MEAN: %d\n", mean);
	return 0;
}
