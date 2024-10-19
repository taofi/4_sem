#include <iostream>
#include "Combi.h"
#include <tchar.h>

using namespace std;

int _tmain(int argc, _TCHAR* argv[])
{
	setlocale(LC_ALL, "rus");
	char  AA[][2] = {"A", "B", "C", "D"};
	cout << "\n - Генератор множества всех подмножеств -";
	cout << "\nИсходное множество: ";
	cout << "{ ";

	for (int i = 0; i < sizeof(AA) / 2; i++)
		cout << AA[i] << ((i < sizeof(AA) / 2 - 1) ? ", " : " ");
	cout << "}\nГенерация всех подмножеств  ";


	combi::subset s1(sizeof(AA) / 2);    
	int  n = s1.getfirst(); 

	while (n >= 0)                 
	{
		cout << "\n{ ";
		for (int i = 0; i < n; i++)
			cout << AA[s1.ntx(i)] << ((i < n - 1) ? ", " : " ");
		cout << "}";
		n = s1.getnext();     
	};

	cout << "\nвсего: " << s1.count() << endl;
	system("pause");
	return 0;

}
