#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#pragma warning(disable:4996)

float progowanie_sredniej_kroczacej(float* tablica, unsigned int k, unsigned int m);

int main()
{
	float tablica[4] = { 1.9, 2.0, 2.1, 2.2 };
	// 123 234 345 456 567
	unsigned int k = 4;
	unsigned int m = 2;

	float wynik = progowanie_sredniej_kroczacej(tablica, k, m);
	printf("%f", wynik);
	
	return 0;
}