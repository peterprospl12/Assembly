#include <stdio.h>
#include <stdlib.h>

extern int* tablica_nieparzystych(int tablica[], unsigned int* n);

int main()
{
	int tablica[5] = { 1,13,2,15,5,};
	int* n = 5;

	int* newTab = tablica_nieparzystych(tablica, &n);
	int z = n;
	for(int i=0;i<5-z;i++)
	{
		printf("%d ", newTab[i]);
	}

	printf("\nParzyste %d", n);
	return 0;
}