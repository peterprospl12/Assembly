#include <stdio.h>

extern void liczba_przeciwna(int* a);

int main()
{	
	int m;
	scanf_s("%d", &m, 32);

	liczba_przeciwna(&m);

	printf("\n m  = %d\n", m);
	return 0;
}