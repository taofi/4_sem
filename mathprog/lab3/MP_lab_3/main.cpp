#include <iostream>
#include <iomanip> 
#include "Salesman.h"

#define CITY 5
#define N 4

using namespace std;

int main()
{
	setlocale(LC_ALL, "rus");

	int d[CITY][CITY] = {
				  {   INF,     2 * N,      21 + N,     INF,    N},
				  {   N,       INF,    15 + N,     68 - N,     84 - N},
				  {   2 + N,       3 * N,      INF,    86,     49 + N},
				  {   17 + N,      58 - N,     4 * N,      INF,    3 * N},
				  {   93 - N,      66 + N,     52,     13 + N,     INF}
	};

	int r[CITY];

	int s = salesman(
		CITY,       // [in]  количество городов 
		(int*)d,    // [in]  массив [n*n] расстояний 
		r           // [out] массив [n] маршрут 0 x x x x  
	);

	for (int i = 0; i < CITY; i++)
		cout << r[i] + 1 << " -> ";
	cout << 1;
	cout << endl << "Итоговый маршрут:" << s;
	cout << endl;

	system("pause");
	return 0;
}