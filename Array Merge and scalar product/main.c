#include <stdio.h>
#include <stdlib.h>

extern int dot_product(int tab1[], int tab2[], int n);
extern int* merge(int tab1[], int tab2[], int n);
int main()
{
	/*int n;
	printf("Podaj n: ");
	scanf_s("%d", &n, 12);
	int* tab1;
	tab1 = (int*) malloc(n * sizeof(int));
	int* tab2;
	tab2 = (int*) malloc(n * sizeof(int));

	printf("Podaj wartosci pierwszego wektora: ");
	for(int i=0; i<n; i++)
	{
		scanf_s("%d", &tab1[i], 12);
	}
	printf("Podaj wartosci drugiego wektora: ");
	for (int i = 0; i < n; i++)
	{
		scanf_s("%d", &tab2[i]);
	}
	int wynik = dot_product(tab1, tab2, n);

	printf("Wynik: %d\n", wynik);
	free(tab1);
	free(tab2);*/

	int n;
	printf("Podaj n: ");
	scanf_s("%d", &n, 12);
	int* tab1;
	tab1 = (int*)malloc(n * sizeof(int));
	int* tab2;
	tab2 = (int*)malloc(n * sizeof(int));

	printf("Podaj wartosci pierwzej tablicy: ");
	for (int i = 0; i < n; i++)
	{
		scanf_s("%d", &tab1[i]);
	}
	printf("Podaj wartosci drugiej tablicy: ");
	for (int i = 0; i < n; i++)
	{
		scanf_s("%d", &tab2[i]);
	}




	int* wynik = merge(tab1, tab2, n);

	for(int i=0;i< n*2;i++)
	{
		printf("%d ", wynik[i]);
	}

	return 0;
}