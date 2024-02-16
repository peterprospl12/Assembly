#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#pragma warning(disable:4996)

long long* convert_to_array(char* tekst);
float srednia_harm(float* tablica, unsigned int n);
float nowy_exp(float x);
int main()
{
	float n = 10.134;

	float wynik = nowy_exp(n);

	printf("Wynik asm %f", wynik);

	float wynik1 = 1.0;



	/*
	scanf_s("%d", &n);

	float* tbl = malloc(n * sizeof(float));

	for(int i=0;i<n;i++)
	{
		scanf_s("%f", &tbl[i]);
	}


	float wynik = srednia_harm(tbl, n);

	printf("%f", wynik);
	*/
	return 0;
}