#include <stdlib.h> 
#include <math.h> 
#include <string.h>


// ���������� ���������� GLUT 
//#include <gl/glut.h> 
#include <glut.h> 

typedef float (*pFunc)(float);


//������� ��������� ���� ������� �� �����
void OnDraw(void); 
//������� ���������� ��� ��������� �������� ����
void OnSise(GLint w, GLint h); 
//������� ������������ ��������� �� ����������
void Keyboard( unsigned char key, int x, int y ); 
//������� ������������ ��������� �� ������,�� ������� ASCII - �����
void SpecialKey(int key, int x, int y ); 
void Triangle();	// �����������
void Rectangle();	// �������������
void MyFunction();	// ������ �������
// �������, ���������� ��������� ���������
void CreateMasFunc(pFunc,float x_bedin,float dx,int N,float **Mas);
float MyF1(float x);	// ������� ��� �������
