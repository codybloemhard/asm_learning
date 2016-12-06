#include <iostream>
#include <ctime>
#include <stdlib.h>
#include <time.h>

using namespace std;

extern "C" int GetAsmX64(int* a, int* b);

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

int main() {
	std::clock_t startClock, endClock;
	//rand(time(NULL));
	
	int a = 3, b = 4;

	cout << a << " , " << b << endl;
	GetAsmX64(&a, &b);
	cout << a << " , " << b << endl;

	/*startClock = std::clock();
	for (int i = 0; i < 1; i++)GetAsmX64(a, b);
	endClock = std::clock();
	double durationASM = (endClock - startClock) / (double)CLOCKS_PER_SEC;
	cout << "Asm took: " << durationASM << endl;*/
	
	/*startClock = std::clock();
	for (int i = 0; i < 1; i++)GetCppX64(aa, bb);
	endClock = std::clock();
	double durationCPP = (endClock - startClock) / (double)CLOCKS_PER_SEC;
	cout << "Cpp took: " << durationCPP << endl;
	cout << "\nSpeedup: " << (durationCPP / durationASM) << endl;*/
	
	system("PAUSE");
	return 0;
}