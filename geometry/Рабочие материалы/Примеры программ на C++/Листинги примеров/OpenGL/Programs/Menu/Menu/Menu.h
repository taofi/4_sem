#include <stdlib.h> 
#include <math.h> 
#include <string.h>

// ���������� ���������� GLUT 
 
#include <glut.h> // ��� Windows 7

//������� ��������� ���� ������� �� �����
void OnDraw(void); 
//������� ���������� ��� ��������� �������� ����
void OnSise(GLint w, GLint h); 
void Figure(GLint TypeFigure);
void Triangle();	// �����������
void Rectangle();	// �������������
