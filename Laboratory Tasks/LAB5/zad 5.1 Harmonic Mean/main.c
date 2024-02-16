#include <stdio.h>
#include <stdlib.h>

#pragma warning(disable:4996)

long long* convert_to_array(char* tekst);
float srednia_harm(float* tablica, unsigned int n);

int main()
{
	int n=0;

	scanf_s("%d", &n);

	float* tbl = malloc(n * sizeof(float));

	for(int i=0;i<n;i++)
	{
		scanf_s("%f", &tbl[i]);
	}


	float wynik = srednia_harm(tbl, n);

	printf("%f", wynik);

	return 0;
}