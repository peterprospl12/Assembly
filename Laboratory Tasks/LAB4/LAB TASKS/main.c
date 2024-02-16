#include <stdio.h>
#include <stdlib.h>

#pragma warning(disable:4996)

long long* convert_to_array(char* tekst);

int main()
{
	char napis[256];
	fgets(napis, 256, stdin);

	long long* wynik = convert_to_array(napis);

	for(int i=0;i<4;i++)
	{
		printf("%lld ", wynik[i]);
	}
	free(wynik);
	return 0;
}