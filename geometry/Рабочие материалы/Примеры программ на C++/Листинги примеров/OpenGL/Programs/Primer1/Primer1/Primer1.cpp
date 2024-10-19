#include "Primer1.h"
 
//---- ���������� ����������---------------------------------
GLint Width = 512;  // ��������� ������ ���� 
GLint Height = 512;       // ��������� ������ ���� 
const int SquareSize = 200; // ������ �������� 
 
//------ ��� ������� ��������� ���� ������� �� �����----------- 
void Display(void) 
{ 
    int left, right, top, bottom; 
	//GLUquadricObj* m_qObj;
	//m_qObj = gluNewQuadric();
 
    left  = (Width - SquareSize) / 2; 
    right = left +SquareSize; 
    bottom = (Height - SquareSize) / 2; 
    top = bottom + SquareSize; 
 
    glClearColor(0, 0, 0, 1); 
    glClear(GL_COLOR_BUFFER_BIT); 
     
    glColor3ub(255,0,0); 
    glBegin(GL_QUADS); 
      glVertex2f(left,bottom); 
      glVertex2f(left,top); 
      glVertex2f(right,top); 
      glVertex2f(right,bottom); 
    glEnd(); 

	//gluSphere(m_qObj, 100.0f, 10, 10);
 
    glFinish(); 
} 
 
// ------- ������� ���������� ��� ��������� �������� ����------------ 
void Reshape(GLint w, GLint h) 
{ 
    Width = w; 
    Height = h; 
    
	// ������������� ������� ������� ����������� 
    glViewport(0, 0, w, h); 
 
    // ��������������� �������� 
    glMatrixMode(GL_PROJECTION); 
    glLoadIdentity(); 
    glOrtho(0, w, 0, h, -1.0, 1.0); 
 
    glMatrixMode(GL_MODELVIEW); 
    glLoadIdentity(); 
} 

 
//------ ������� ������������ ��������� �� ���������� ---------------

void Keyboard( unsigned char key, int x, int y )
{ 
#define ESCAPE '\033' 
 
    if( key == ESCAPE ) 
        exit(0); 
} 
 
//--------������� ���� ����������------------------------------------
int main(int argc, char *argv[]) 
{ 
    glutInit(&argc, argv); 
    glutInitDisplayMode(GLUT_RGB); 
    glutInitWindowSize(Width, Height); 
	glutCreateWindow("������_1.    ����������� ���� OpenGL");
 
    glutDisplayFunc(Display); 
    glutReshapeFunc(Reshape); 
    glutKeyboardFunc(Keyboard); 
 
    glutMainLoop(); 
	return 0;
} 
 
 