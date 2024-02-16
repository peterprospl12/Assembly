#include <stdio.h>
#include <stdlib.h>

extern int dot_product(int tab1[], int tab2[], int n);
extern int* merge(int tab1[], int tab2[], int n);
extern int* szukaj_elem_max(int tablica[], int n);
extern int odejmowanie(int** odjemna, int* odjemnik);
extern int get_minuty();
extern int funkcja(int e);
extern int szukaj_znak(wchar_t* tab, unsigned int znak);
int main()
{

	wchar_t tablica[5] = L"!界世界世";
	// { L'!', L'界' ,L'世', L'世', L'世'};
	unsigned int znak = L'世';
	unsigned int* wsk = &znak;

	int wynik = szukaj_znak(tablica, znak);

	int b = 0;



	/*
	int a;
	int b = 40;
	a = funkcja(b);
	
	for(int i=0;i<b;i++)
	{
		printf("%d ", *(int*)(a + i*4));  // Dostosowano sposób odczytu wartości
	}

	printf("\n");
	int h; int* i;
	i = (int*)malloc(b * sizeof(int));
	if (i == NULL) return -1;
	int* originalPointer = i;
	for(h=0;h<b;h++)
	{
		(*i) = 3 * h - 1;
		i++;
	}
	i = originalPointer;
	for (int z = 0; z < b; z++)
	{
		printf("%d ", i[z]);
	}
	*/








	/*
	 // --------------
	 // minuty
	 // ---------------
	 
	int minuty = get_minuty();

	printf("Aktualna liczba minut: %d", minuty);
	*/





	/*
	// --------------
	// odejmowanie
	// ----------------
	
	int a, b, * wsk, wynik;
	wsk = &a;
	a = -100;  // odjemna
	b = 300; // odjemnik

	wynik = odejmowanie(&wsk, &b);

	printf("WYNIK: %d ", wynik);
	*/


	/*
	 // --------------
	 // szukaj_elem_max
	 // ---------------
	 
	int pomiary[7] = { 1,5,400,2,3,11,12 };
	int * wsk;

	wsk = szukaj_elem_max(pomiary, 7);
	printf("\n Element maksymalny = %d\n", *wsk);*/


	/*

	// ----------------
	// dot_product
	// ---------------
	int n;
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

	/*
	// -----------
	// merge
	// ------------
	
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
	}*/

	return 0;
}