#include <stdio.h>

int szukaj_max(int a, int b, int c, int d);

int main()
{
	int x, y, z, p, wynik;

	printf("\n Prosze podac cztery liczby ca�kowite ze znakiem: ");
	scanf_s("%d %d %d %d", &x, &y, &z, &p, 32);
	wynik = szukaj_max(x,y,z,p);

	printf("\n Spo�r�d podanych liczb %d, %d, %d, %d, liczba %d jest najwi�ksza \n", x, y, z, p, wynik);
	return 0;
}