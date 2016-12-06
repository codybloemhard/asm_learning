#include <iostream>

using namespace std;

extern "C" int GetAsmX64();

extern "C" void PrintInt(int a) {
	cout << "[ASM]: " << a << endl;
}

extern "C" void PrintString(char* str) {
	cout << "[ASM]: " << str << endl;
}

int main() {
	cout << "x64 says: " << GetAsmX64() << endl;
	system("PAUSE");
	return 0;
}