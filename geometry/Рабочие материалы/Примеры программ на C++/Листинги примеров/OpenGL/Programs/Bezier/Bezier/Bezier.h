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
void DrawPoints(GLfloat Points[][3],GLint NumPoints);
//void DrawPoints3D(GLfloat Points[][4][3],GLint NumPoints,GLint NumSheets);
void DrawPoints3D(float ***Points,int NumPoints,int NumSheets,int k);
void Bezier2D_1(GLfloat Points[][3],GLint NumPoints);	
void Bezier2D_2(GLfloat Points[][3],GLint NumPoints);
void InitLight();
void CopyPoints();

