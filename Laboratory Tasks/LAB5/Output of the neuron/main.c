#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#pragma warning(disable:4996)

float* single_neuron(double* x, float* w, unsigned int n);

int main()
{
	double x[5] = { 0.5f, 1.5f, 1.5f, 10.0f, 2.5f };
	float w[5] = { 1.0f, 2.0f, 1.0f, 2.0f, 1.0f };
	unsigned int n= 5;
	float* wynik = single_neuron(x,w,n);
	printf("%f", *wynik);
	free(wynik);
	return 0;
}