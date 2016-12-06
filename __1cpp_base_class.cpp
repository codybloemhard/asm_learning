#include <iostream>
#include <ctime>

using namespace std;

extern "C" int GetAsmX64();

extern "C" void PrintInt(int a) {
	cout << "[ASM]: " << a << endl;
}

extern "C" void PrintString(char* str) {
	cout << "[ASM]: " << str << endl;
}

int main() {
	std::clock_t startClock, endClock;

	startClock = std::clock();
	int asmReturned = GetAsmX64();
	endClock = std::clock();

	double durationASM = (endClock - startClock) / (double)CLOCKS_PER_SEC;
	cout << "x64 says: " << asmReturned << endl;
	cout << "Asm took: " << durationASM << endl;
	system("PAUSE");
	return 0;
}