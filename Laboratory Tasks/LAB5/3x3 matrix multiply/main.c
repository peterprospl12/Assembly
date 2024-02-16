#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#pragma warning(disable:4996)

float* Matmul(double* A, float* B, unsigned int k, unsigned int l, unsigned int m);

int main()
{
	double A[2][3] = { {2,1, 3}, {-1,2,4}};
	float B[3][2] = { {1,3}, {2,-2}, {-1,4} };
	unsigned int k = 2;
	unsigned int l = 3;
	unsigned int m = 2;

	float* wynik = Matmul(A, B, k, l, m);
	// k = wiersze A
	// l = kolumny A
	// l = wiersze B
	// m = kolumny B 
	for(int i=0;i<3;i++)
	{
		for(int j=0;j<3;j++)
		{
			printf("%f ", wynik[i*3 + j]);
		}
		printf("\n");
	}

	return 0;
}