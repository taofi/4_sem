#include <stdlib.h> 
#include <math.h> 
#include <string.h>


// ���������� ���������� GLUT 
//#include <gl/glut.h> 
#include <glut.h> 

//������� ��������� ���� ������� �� �����
void OnDraw(void); 
//������� ���������� ��� ��������� �������� ����
void OnSise(GLint w, GLint h); 
//������� ������������ ��������� �� ����������
void Keyboard( unsigned char key, int x, int y ); 
//������� ������������ ��������� �� ������,�� ������� ASCII - �����
void SpecialKey(int key, int x, int y ); 

void Cube();	// ���
void Box (GLfloat x1, GLfloat x2, GLfloat y1, GLfloat y2, GLfloat z1, GLfloat z2);
void Pyramid( GLfloat x1, GLfloat x2, GLfloat y1, GLfloat y2, GLfloat z1,GLfloat z2);


