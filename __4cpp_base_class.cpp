#include <iostream>
#include <ctime>
#include <stdlib.h>
#include <time.h>

using namespace std;

extern "C" int GetAsmX64(int a, int* arr);

extern "C" void PrintInt(int a) {
	cout << "[ASM]: " << a << endl;
}

extern "C" void PrintString(char* str) {
	cout << "[ASM]: " << str << endl;
}

extern "C" void Notify() {
	cout << "[NOTIFICATION]" << endl;
}

extern "C" void PrintArr(int len, int* arr) {
	for (int i = 0; i < len; i++)
		cout << arr[i] << ",";
	cout << endl;
}

void GetCppX64(int len, int a[]) {
	for (int i = 1; i < len; i++) {
		for (int j = 0; j < len - i; j++) {
			if (a[j] > a[j + 1]){
				int temp = a[j];
				a[j] = a[j + 1];
				a[j + 1] = temp;
			} 
		}
	}
}

int main() {
	std::clock_t startClock, endClock;
	srand(time(NULL));
	
	int z[10] = {13, 54, 1, 34, 95, 4, 1, 76, 39, 12};

	for (int i = 0; i < 10; i++)
		cout << z[i] << ",";
	cout << endl;

	GetAsmX64(10, z);

	for (int i = 0; i < 10; i++)
		cout << z[i] << ",";
	cout << endl;

	const int SIZE = 1024 * 32;
	int* a = new int[SIZE];
	int* b = new int[SIZE];

	for (int i = 0; i < SIZE; i++) {
		int x = rand();
		a[i] = x;
		b[i] = x;
	}

	startClock = std::clock();
	GetAsmX64(SIZE, a);
	endClock = std::clock();
	double durationASM = (endClock - startClock) / (double)CLOCKS_PER_SEC;
	cout << "Asm took: " << durationASM << endl;

	startClock = std::clock();
	for (int i = 0; i < 1; i++)GetCppX64(SIZE, b);
	endClock = std::clock();
	double durationCPP = (endClock - startClock) / (double)CLOCKS_PER_SEC;
	cout << "Cpp took: " << durationCPP << endl;

	cout << "\nSpeedup: " << (durationCPP / durationASM) << endl;

	system("PAUSE");
	return 0;
}