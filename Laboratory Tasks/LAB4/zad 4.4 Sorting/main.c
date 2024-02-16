#include <stdio.h>
#include <stdlib.h>

extern void liczba_przeciwna(int* a);

extern void odejmij_jeden(int** a);

extern void przestaw(int tabl[], int n);

int main()
{
	int n;
	int* tbl;

	printf("\Proszê podac rozmiar tablicy: ");
	scanf_s("%d",& n, 12);
	
	tbl = (int*)malloc(n * sizeof(int));
	printf("\Proszê podac %d liczb: ", n);
	for (int i = 0; i < n; i++)
	{
		scanf_s("%d", &tbl[i]);
	}

	for (int i = 0; i < n-1; i++)
	{
		przestaw(tbl, n-i);
	}

	printf("\n");

	for(int i=0;i<n;i++)
	{
		printf("%d ", tbl[i]);
	}

	free(tbl);
	return 0;
}