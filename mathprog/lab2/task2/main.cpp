#include <iostream>
#include "Combi.h"
#include <tchar.h>
using namespace std;
int _tmain(int argc, _TCHAR* argv[])
{
    setlocale(LC_ALL, "rus");
    char  AA[][2] = { "A", "B", "C", "D", "E" };
    cout << "\n --- Генератор сочетаний ---";
    cout << "\nИсходное множество: ";
    cout << "{ ";
    for (int i = 0; i < sizeof(AA) / 2; i++)
        cout << AA[i] << ((i < sizeof(AA) / 2 - 1) ? ", " : " ");
    cout << "}";
    cout << "\nГенерация сочетаний ";
    combi::xcombination xc(sizeof(AA) / 2, 3);
    cout << "из " << xc.n << " по " << xc.m;
    int  n = xc.getfirst();
    while (n >= 0)
    {
        cout << endl << xc.nc << ": { ";
        for (int i = 0; i < n; i++)
            cout << AA[xc.ntx(i)] << ((i < n - 1) ? ", " : " ");
        cout << "}";

        n = xc.getnext();
    };
    cout << "\nвсего: " << xc.count() << endl;
    system("pause");
    return 0;
}