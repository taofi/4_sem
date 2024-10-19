#include "Animation.h"
//---- ���������� ����������---------------------------------
GLint x_win=100;     // x - ���������� ������ �������� ���� ���� OpenGL �� ������
GLint y_win=50;     // y - ���������� ������ �������� ���� ���� OpenGL �� ������
GLint Width = 800;	  // ��������� ������ ���� 
GLint Height = 600;   // ��������� ������ ���� 
GLint left,right,top,bottom; // ��� ����������� ������� ��������� �����������
                             //������ ����� �������������� � ���
GLint Index=1;  // ��� ������ 
float angle=0;    // ���� ��� �������� ������, ����
float d_angle=2;    // ��� �������� ����, ����.

//------ ��� ������� ��������� ���� ������� �� �����----------- 
void OnDraw(void) 
{   
	switch(Index)
	{
		case 1:
		{
			glClearColor(1.0,1.0,1.0,0.0); //���� ���� � ����
			glClear(GL_COLOR_BUFFER_BIT);  // �������� ����� ����� - ������ ������ ����		
			glColor3ub(255,0,0);	// ���� ����� ��� ������� 
			//glLineWidth(3.0) ;	    // ������� ����� 

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 
			glRotatef(angle,0.0,0.0,1.0); //  
			
			
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10;
			gluOrtho2D(left, right, bottom, top); // (left,bottom)- (right,top)
			Rectangle(-5.0,-5.0,5.0,5.0);
			break;
		}

		case 2:
		{
			glClearColor(0.0,1.0,0.0,0.0); //���� ���� � ����
			glClear(GL_COLOR_BUFFER_BIT);  // �������� ����� ����� - ������ ������ ����	
			glColor3ub(0,0,255);	       // ���� ����� 


			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-8; right=8; bottom=-8; top=8;
			gluOrtho2D(left, right, bottom, top); // (left,bottom)- (right,top)

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 
			glRotatef(angle,0.0,0.0,1.0); //								
			Triangle(-2.5,-2.5,0.0,0.0,2.5,-2.5);

			glLoadIdentity();
			glRotatef(angle+180,0.0,0.0,1.0); //
			glColor3ub(255,0,0);	       // ���� ����� 
			Triangle(-2.5,-2.5,0.0,0.0,2.5,-2.5);
			break;
		}
		
	}
	glutSwapBuffers(); // ������������ ������� (����������� 
	                   // ��� ������������� ������� ����������� GLUT_DOUBLE
    glFinish(); 
} 
 
// ------- ������� ���������� ��� ��������� �������� ����------------ 
void OnSize(GLint w, GLint h) 
// w - ����� ������ ����
// h - ����� ������ ����
{   
	// ������������� ����� ������� ������� ����������� 
    glViewport(0,0, w, h); 
} 

 

//-- ������� ������������ ��������� �� ������, �� ������� ASCII - ����  -------

void SpecialKey(int key, int x, int y )
{
	switch(key)
	{
		case GLUT_KEY_F1:	// 
		{
			Index=1;
			break;
		}
		case GLUT_KEY_F2:	// 
		{
			Index=2;
			break;
		}
	}
glutPostRedisplay();
}

//---------------------- IdleFunction ----------------------------
void IdleFunction()
{
	angle+=d_angle;
	glutPostRedisplay();	
}

//----------------------------------------------------------------

void MouseFunction(int button,int state,int x,int y)
{
	if(button==GLUT_LEFT_BUTTON && state==GLUT_DOWN)
		glutIdleFunc(IdleFunction);
	if(button==GLUT_RIGHT_BUTTON && state==GLUT_DOWN)
		{
			glutIdleFunc(NULL);
			angle=0;
		}
}



//--------- ����������� --------------------------------------------
void Triangle(GLfloat x1,GLfloat y1,GLfloat x2,GLfloat y2,GLfloat x3,GLfloat y3)
//  ����������� ABC:  A(x1,y1),B(x2,y2),C(x3,y3)- �� ������� �������
{        
    glBegin(GL_POLYGON); // ����� ������ ������� �������
      glVertex2f(x1,y1); //A
      glVertex2f(x3,y3); //C
      glVertex2f(x2,y2); //B
    glEnd(); 	
}

//--------- ������������� --------------------------------------------
void Rectangle(GLfloat x1,GLfloat y1,GLfloat x2,GLfloat y2)
//��������������� ABCD: 
//A(x1,y1) - ����� ������ ����
//C(x3,y3) - ������ ������� ����
{  
    glBegin(GL_POLYGON); // ����� ������ ������� �������
	  glVertex2f(x1,y1); //A
	  glVertex2f(x2,y1); //D
	  glVertex2f(x2,y2); //C
	  glVertex2f(x1,y2); //B
    glEnd(); 	
}

 
//================ main ==================================================
int main(int argc, char *argv[]) 
{ 
//----- ������� ���������� GLUT ------------------------------------------
    glutInit(&argc, argv); // ������������� ���������� GLUT
    glutInitDisplayMode(GLUT_RGB|GLUT_DOUBLE); //������������ ����� RGB ��� 
//������ ����� � ������� ���������� (������� ������������� �������� glutSwapBuffers())
	glutInitWindowPosition  (x_win,y_win);     // ���������� ������ �������� ���� 
	                                           //���� OpenGL �� ������ ��������
    glutInitWindowSize(Width, Height);         //������ � ������ ���� OpenGL 
	glutCreateWindow("������_4. ��������  "); //�������� ���� � ����������
    glutDisplayFunc(OnDraw); // ����������� ������� ��������� ������ OnDraw - ����������
	                         // �������� ��� ������������� ������������ ���� (������ OnPaint � MFC) 
    glutReshapeFunc(OnSize); // ����������� ������� ��������� ������ OnSize - ����������
	                         // �������� ��� ��������� �������� ���� (������ OnSize � MFC) 
   
	glutSpecialFunc(SpecialKey);// ����������� ������� ��������� ������ SpesialKey -����������
                                // �������� ��� ��� ������ �������, �� ������� ASCII-����
	glutIdleFunc(IdleFunction); //����������� ������� ��������� ������ dleFunction - ����������
								// �������� ����� ��� ������ ������� 
    glutMouseFunc(MouseFunction);//����������� ������� ��������� ������ MouseFunction- ����������
								 // �������� ��� ������� ������ ���� 
	glutIdleFunc(NULL); // ��������� IdleFunction
    glutMainLoop(); //������ ������������ ����� ��������� ��������� Windows
//-------------------------------------------------------------------------------

	return 0;
} 
 
 