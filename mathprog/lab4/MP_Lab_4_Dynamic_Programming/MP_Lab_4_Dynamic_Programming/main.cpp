#include "strGenerate.h"
#include "Levenshtein.h"
#include "MultiMatrix.h"
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <algorithm>
#include <iomanip>
using namespace std;
//
#define LEN_S1 300
#define LEN_S2 200
#define K (1./20.)
#define LEN_PREFIX_S1 (int)(LEN_S1 * (double)K)
#define LEN_PREFIX_S2 (int)(LEN_S2 * (double)K)

int main()
{
	srand((unsigned)time(NULL));
	setlocale(0, "ru");
	const char* S1, * S2;
	S1 = strGenerate::strGenerate(LEN_S1);
	S2 = strGenerate::strGenerate(LEN_S2);

	cout << "-----------------------Строка 1-----------------------" <<endl<< S1 << endl;
	cout << "-----------------------Строка 2-----------------------" <<endl<< S2 << endl;

	clock_t t1 = 0, t2 = 0, t3, t4;
	
	std::cout << std::endl<<endl;
	cout << "Строка 1: " << prefix(S1, LEN_PREFIX_S1) << endl;
	cout << "Строка 2: " << prefix(S2, LEN_PREFIX_S2) << endl;
	cout << endl;
	std::cout << std::endl << "  длина     рекурсия    дин.програм. ---"
		<< std::endl;
	int lev = 0, lev_r = 0;
	int sum = 0, sum_r = 0;
	
	for (int i = 0; i < std::min(LEN_PREFIX_S1, LEN_PREFIX_S2); i++)
	{
		
		t1 = clock(); lev = levenshtein_r(i, prefix(S1, LEN_PREFIX_S1), i, prefix(S2, LEN_PREFIX_S2)); t2 = clock();
		t3 = clock(); lev_r = levenshtein(i, prefix(S1, LEN_PREFIX_S1), i, prefix(S2, LEN_PREFIX_S2)); t4 = clock();
		std::cout << std::right << std::setw(2) << i << "/" << std::setw(2) << i
			<< "        " << std::left << std::setw(10) << (t2 - t1)
			<< "   " << std::setw(10) << (t4 - t3) << std::endl;
		sum_r += t2 - t1;
		sum += t4 - t3;
	}
	cout << "Рекурсия " << lev << "\t" << sum_r << endl;
	cout << "Динамически " << lev << "\t" << sum << endl;


	cout << "Скобки и матрицы" << endl;

	const int numMatrices = 6;
	const int dimensions[] = { 20, 15, 30, 53, 10, 20, 11 };
	int* positions = new int[(numMatrices - 1) * numMatrices];
	int flag = 0;

	cout << "Рекурсия" << endl;
	t1 = clock();
	int minimumOperations = OptimalM(1, numMatrices, numMatrices, dimensions, positions);
	t2 = clock();
	cout << "Результат: " << minimumOperations << endl;
	cout << "Матрица: \n";
	for (int i = 0; i < (numMatrices - 1) * numMatrices; i++) {
		if (flag == 6) {
			cout << endl;
			flag = 0;
		}
		if (positions[i] > 0) {
			cout << positions[i] << " ";
		}
		else {
			cout << 0 << " ";
		}

		flag++;
	}
	cout << endl;
	cout << "Время: " << t2 - t1 << endl;

	flag = 0;
	cout << "Динамическое программирование" << endl;
	t3 = clock();
	minimumOperations = OptimalMD(numMatrices, dimensions, positions);
	t4 = clock();
	cout << "Результат: " << minimumOperations << endl;
	cout << "Матрица: \n";
	for (int i = 0; i < (numMatrices - 1) * numMatrices; i++) {
		if (flag == 6) {
			cout << endl;
			flag = 0;
		}
		if(positions[i] > 0){
			cout << positions[i] << " ";
		}
		else {
			cout << 0 << " ";
		}
		
		flag++;
	}
	cout << endl;
	cout << "Время: " << t4 - t3 << endl;

	delete[] positions;


	system("pause");
	return 0;



}








// - main  
// -- вычисления длины LCS 



//#include <iostream>
//#include "LCH.h"
//int main()
//{
//    srand((unsigned)time(NULL));
//        	setlocale(0, "ru");
//        	char* S1, *S2;
//        	S1 = strGenerate::strGenerate(LEN_S1);
//        	S2 = strGenerate::strGenerate(LEN_S2);
//        
//        	cout << "-----------------------Строка 1-----------------------" <<endl<< S1 << endl;
//        	cout << "-----------------------Строка 2-----------------------" <<endl<< S2 << endl;
//        
//        std::cout << std::endl << "-- вычисление длины LCS для X и Y(динамичаское программирование )\n";
//        cout << "Строка1: " << prefix(S1, LEN_PREFIX_S1) << endl;
//        cout << "Строка2: " << prefix(S2, LEN_PREFIX_S2) << endl;
//        clock_t t1 = 0, t2 = 0;
//        t1 = clock();
//        char z[100];
//    int s = lcsd(  
//         prefix(S1, LEN_PREFIX_S1),       
//         prefix(S2, LEN_PREFIX_S2),
//        z
//    );
//    t2 = clock();
//       std::cout << std::endl << "-- длина LCS: " << s << std::endl;
//        cout << "Время: " << t2 - t1 << endl;
//    system("pause");
//    return 0;
//}



//#include <iostream>
//#include "LCS.h"
//int main()
//{
//
//    srand((unsigned)time(NULL));
//    	setlocale(0, "ru");
//    	char* S1, *S2;
//    	S1 = strGenerate::strGenerate(LEN_S1);
//    	S2 = strGenerate::strGenerate(LEN_S2);
//    
//    	cout << "-----------------------Строка 1-----------------------" <<endl<< S1 << endl;
//    	cout << "-----------------------Строка 2-----------------------" <<endl<< S2 << endl;
//    
//    std::cout << std::endl << "-- вычисление длины LCS для X и Y(рекурсия)\n";
//    cout << "Строка1: " << prefix(S1, LEN_PREFIX_S1) << endl;
//    cout << "Строка2: " << prefix(S2, LEN_PREFIX_S2) << endl;
//    clock_t t1 = 0, t2 = 0;
//    t1 = clock();
//    int s = lcs(
//       LEN_PREFIX_S1,  // длина   последовательности  X   
//        prefix(S1, LEN_PREFIX_S1),       // последовательность X
//        LEN_PREFIX_S2 - 1,  // длина   последовательности  Y
//        prefix(S2, LEN_PREFIX_S2)       // последовательность Y
//    );
//    t2 = clock();
//    std::cout << std::endl << "-- длина LCS: " << s << std::endl;
//    cout << "Время: " << t2 - t1 << endl;
//    system("pause");
//    return 0;
//}