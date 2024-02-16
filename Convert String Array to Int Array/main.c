#include <stdio.h>
#include <stdlib.h>

#pragma warning(disable:4996)

extern unsigned int* convert_to_array(char tekst);

int main()
{
	char str1[255];
	scanf_s("%254[^\n]", str1, 254);
	str1[254] = '\0';
	unsigned int* tab1 = convert_to_array(str1);


	for(int i=0;i<5;i++)
	{
		printf("%d ", tab1[i]);
	}

	return 0;
}