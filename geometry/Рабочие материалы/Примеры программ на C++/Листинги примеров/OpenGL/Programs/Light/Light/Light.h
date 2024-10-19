#include <stdlib.h> 
#include <math.h> 
#include <string.h>

// ���������� ���������� GLUT 
//#include <gl/glut.h> 
#include <glut.h> 
struct Point
{
	double x;
	double y;
	double z;
	Point(double xx,double yy,double zz){x=xx; y=yy; z=zz;};
};

// ������������� ���������� ���������� � ��������� ����� 
void Init (); 
//������� ��������� ���� ������� �� �����
void OnDraw(void); 
//������� ���������� ��� ��������� �������� ����
void OnSise(GLint w, GLint h); 
//������� ������������ ��������� �� ����������
void Keyboard( unsigned char key, int x, int y ); 
//������� ������������ ��������� �� ������,�� ������� ASCII - �����
void SpecialKey(int key, int x, int y ); 
//-------- ������� ������������ ------------------------------------------------------
void Box (GLfloat x1, GLfloat x2, GLfloat y1, GLfloat y2, GLfloat z1, GLfloat z2);
void Pyramid( GLfloat x1, GLfloat x2, GLfloat y1, GLfloat y2, GLfloat z1,GLfloat z2);
void GetNormal(Point &P1,Point &P2,Point &P3,GLfloat *VN);



