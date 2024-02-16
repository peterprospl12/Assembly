#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#pragma warning(disable:4996)

long long* convert_to_array(char* tekst);
float srednia_harm(float* tablica, unsigned int n);
float nowy_exp(float x);
void sumuj(char*, char*, char*);
void int2float(int* calkowite, float* zmienno_przec);
void pm_jeden(float* tabl);
void dodawanie_SSE(float* a);
int main()
{
	float wyniki[4];
	dodawanie_SSE(wyniki);
	printf("\nWyniki = %f %f %f %f\n",
		wyniki[0], wyniki[1], wyniki[2], wyniki[3]);
	/*
	float tablica[4] = { 27.5,143.57,2100.0, -3.51 };
	printf("\n%f %f %f %f\n", tablica[0],
		tablica[1], tablica[2], tablica[3]);
	pm_jeden(tablica);
	printf("\n%f %f %f %f\n", tablica[0],
		tablica[1], tablica[2], tablica[3]);
	*/


	/*
	int a[2] = { -17, 24 };
	float r[4];
	// podany rozkaz zapisuje w pamięci od razu 128 bitów,
	// więc muszą być 4 elementy w tablicy
	int2float(a, r);
	printf("\nKonwersja = %f %f\n", r[0], r[1]);
	*/

	/*
	char liczby_A[16] = { -128, -127, -126, -125, -124, -123, -122,
						  -121, 120, 121, 122, 123, 124, 125, 126, 127 };


	char liczby_B[16] = { -3, -3, -3, -3, -3, -3, -3, -3,
		                   3, 3, 3, 3, 3, 3, 3, 3 };

	char wynik[16];
	sumuj(liczby_A, liczby_B, wynik);

	for(int i=0;i<16;i++)
	{
		printf("\n %d", wynik[i]);
	}

	printf("\n Zgodnie z regula arytmetki nasycenia (saturation),"
		" jezeli wynik operacji przekracza dopuszczalny zakres, to wynikiem jest"
		" najwieksza labo najmniejsza liczba, ktora moze byc przedstawiona w "
		" danym formacie\n\n\n\n");
	*/


	/*
	float n = 10.3;

	float wynik = nowy_exp(n);

	printf("Wynik asm %f", wynik);

	float wynik1 = 1.0;
	*/


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