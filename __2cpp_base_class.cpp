#include <iostream>
#include <ctime>
#include <stdlib.h>
#include <time.h>

using namespace std;

extern "C" int GetAsmX64(int* a, int* b, int len);

extern "C" void PrintInt(int a) {
	cout << "[ASM]: " << a << endl;
}

extern "C" void PrintString(char* str) {
	cout << "[ASM]: " << str << endl;
}

void GetCppX64(int arr[], int length) {
	int j, temp;
	for (int i = 0; i < length; i++) {
		j = i;
		while (j > 0 && arr[j] < arr[j - 1]) {
			temp = arr[j];
			arr[j] = arr[j - 1];
			arr[j - 1] = temp;
			j--;
		}
	}
}

void GetCppX64(int a[], int b[], int length) {
	int aa = 0, bb = 0, zz = 0;
	for (int i = 0; i < length; i++) {
		if (a[i] > b[i])
			aa++;
		else if (a[i] < b[i])
			bb++;
		else
			zz++;
	}
}

int main() {
	std::clock_t startClock, endClock;
	
	srand(time(NULL));
	const int lenght = 1000000;
	int* a = new int[lenght];
	int* b = new int[lenght];
	for (int i = 0; i < lenght; i++) {
		a[i] = rand() % 10000;
		b[i] = rand() % 10000;
	}

	startClock = std::clock();
	for (int i = 0; i < 1000; i++)GetAsmX64(a, b, lenght);
	endClock = std::clock();
	double durationASM = (endClock - startClock) / (double)CLOCKS_PER_SEC;
	cout << "Asm took: " << durationASM << endl;
	
	startClock = std::clock();
	for (int i = 0; i < 1000; i++)GetCppX64(a, b, lenght);
	endClock = std::clock();
	double durationCPP = (endClock - startClock) / (double)CLOCKS_PER_SEC;
	cout << "Cpp took: " << durationCPP << endl;

	cout << "\nSpeedup: " << (durationCPP / durationASM) << endl;

	delete[] a, b;
	
	system("PAUSE");
	return 0;
}