#include <stdlib.h> 
#include <math.h> 
#include <string.h>


// ���������� ���������� GLUT 
#include <glut.h> 

//������� ��������� ���� ������� �� �����
void OnDraw(void); 
//������� ���������� ��� ��������� �������� ����
void OnSise(GLint w, GLint h); 
//������� ������������ ��������� �� ������,�� ������� ASCII - �����
void SpecialKey(int key, int x, int y );
void MouseFunction(int button,int state,int x,int y);
void IdleFunction();
void Triangle(GLfloat x1,GLfloat y1,GLfloat x2,GLfloat y2,GLfloat x3,GLfloat y3);	// �����������
void Rectangle(GLfloat x1,GLfloat y1,GLfloat x2,GLfloat y2);	// �������������

