#include <iostream>
#include <iomanip> 
#include "Combi.h"
#include <tchar.h>
#include <ctime>
#define MM 5
#define NN 8
#define SPACE(n) setw(n)<<" "
using namespace std;

void fillArrayWithRandomValues(int* weights, int sizeOfArray, int min, int max) {

    std::srand(static_cast<unsigned int>(std::time(nullptr)));
    for (int i = 0; i < sizeOfArray; i++)
    {
        weights[i] = min + (rand() % (max - min + 1));
    }

}

int _tmain(int argc, _TCHAR* argv[])
{
    setlocale(LC_ALL, "rus");
    int v[NN];
    int c[NN];
    int minv[MM];
    int maxv[MM];

    fillArrayWithRandomValues(v, NN, 100, 200);
    fillArrayWithRandomValues(c, NN, 10, 100);
    fillArrayWithRandomValues(minv, MM, 50, 120);
    fillArrayWithRandomValues(maxv, MM, 150, 850);

    short r[MM];
    clock_t t1, t2;

    t1 = clock();
    int cc = combi::boat_�(MM, minv, maxv, NN, v, c, r);
    t2 = clock();
    cout << "\n- ������ � ���������� ����������� �� ����� -";
    cout << "\n- ����� ���������� �����������   : " << NN;
    cout << "\n- ���������� ���� ��� �����������  : " << MM;
    cout << "\n- �����������  ��� ����������  : ";
    for (int i = 0; i < MM; i++) cout << setw(3) << minv[i] << " ";
    cout << "\n- ������������ ��� ����������  : ";
    for (int i = 0; i < MM; i++) cout << setw(3) << maxv[i] << " ";
    cout << "\n- ��� �����������      : ";
    for (int i = 0; i < NN; i++) cout << setw(3) << v[i] << " ";
    cout << "\n- ����� �� ���������     : ";
    for (int i = 0; i < NN; i++) cout << setw(3) << c[i] << " ";
    cout << "\n- ������� ���������� (0,1,...,m-1) : ";
    for (int i = 0; i < MM; i++) cout << r[i] << " ";
    cout << "\n- ����� �� ���������     : " << cc << endl;
    cout << "�����" << (t2 - t1) << endl;
    system("pause");


    //cout << "\n-- ������ � ���������� ����������� -- ";
    //cout << "\n-- ����� �����������: " << NN;
    //cout << "\n-- ���������� ------ ����������������� -- ";
    //cout << "\n      ����                ����������  ";
    //for (int i = 4; i <= NN; i++) {
    //    t1 = clock();
    //    combi::boat_�(i, minv, maxv, NN, v, c, r);
    //    t2 = clock();
    //    cout << endl << SPACE(7) << setw(2) << i
    //        << SPACE(15) << setw(6) << (t2 - t1);
    //}
    //cout << endl; system("pause");
    return 0;
}
