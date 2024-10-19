#include "Menu.h"

//x - ���������� ������ �������� ���� ���� OpenGL �� ������
GLint x_win=100;
//y - ���������� ������ �������� ���� ���� OpenGL �� ������
GLint y_win=50;   
// ��������� ������ ���� OpenGL �� ������
GLint Width = 800;	 
 //��������� ������ ���� OpenGL �� ������
GLint Height = 600;  
// ���������� ��� ����������� ������� ��������� �����������
//������ ����� �������������� � ������� ��������� ����������� (���)
GLint left,right,top,bottom;                              
GLint Index=0;  // ��� ������ �������
float angle=0;    // ���� ��� �������� ������������, ����

//------ ��� ������� ��������� ���� ������� �� �����----------- 
void OnDraw(void) 
{   
	switch(Index)
	{
		case 0:
		{
			glClearColor(1.0,1.0,1.0,0.0);
			glClear(GL_COLOR_BUFFER_BIT); 
			break;
		}

		case 1:
		{
			//���� ���� � ���� 
			glClearColor(1.0,1.0,1.0,0.0); // - �����
            // �������� ����� ����� - ������ ������ ����	
			glClear(GL_COLOR_BUFFER_BIT);  	
			glColor3ub(0,0,0);	// ���� ����� 
			glLineWidth(3.0) ;	    // ������� �����
			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 
			//glRotatef(angle,0.0,0.0,1.0); //  		
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10;
			gluOrtho2D(left, right, bottom, top); 
			Triangle(); //������ �����������
			break;
		}

		case 2:
		{
           //���� ���� � ����
			glClearColor(0.8,0.8,0.8,0.0); // - �����
            // �������� ����� ����� - ������ ������ ����	
			glClear(GL_COLOR_BUFFER_BIT);  
			glColor3ub(0,0,0);	       // ���� ������ 
			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 				
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10;
			gluOrtho2D(left, right, bottom, top); 
			Rectangle();
			break;
		}
		
	}
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

//--------------- Figure ------------------------------------------------
void Figure(GLint TypeFigure)
{
	Index= TypeFigure;
	glutPostRedisplay();
}

//--------- ����������� --------------------------------------------
void Triangle()
{        
    glBegin(GL_LINE_LOOP); 
      glVertex2f(-5.0,-5.0); 
      glVertex2f(0.0,5.0); 
      glVertex2f(5.0,-5.0); 
    glEnd(); 	
}

//--------- ������������� --------------------------------------------
void Rectangle()
{  
	GLfloat VectCoords[4][2]={-7.0,-5.0,-7.0,5.0,7.0,5.0,7.0,-5.0};
    glBegin(GL_POLYGON); 
    for(int i=0;i<4;i++) glVertex2fv(VectCoords[i]); 
    glEnd(); 	
}

//================ main ==================================================
int main(int argc, char *argv[]) 
{ 
//----- ������� ���������� GLUT ------------------------------------------
 glutInit(&argc, argv); // ������������� ���������� GLUT
 glutInitDisplayMode(GLUT_RGB|GLUT_SINGLE); //������������ ����� RGB ��� 
	                                           //������ ����� � ��������� ����������
	glutInitWindowPosition  (x_win,y_win);     // ���������� ������ �������� ���� 
	                                           //���� OpenGL �� ������ ��������
  glutInitWindowSize(Width, Height);         //������ � ������ ���� OpenGL 
	glutCreateWindow("�������� ����"); //�������� ���� � ����������
  glutDisplayFunc(OnDraw); // ����������� ������� ��������� ������ OnDraw - ����������
	                         // �������� ��� ������������� ������������ ���� (������ OnPaint � MFC) 
  glutReshapeFunc(OnSize); // ����������� ������� ��������� ������ OnSize - ����������
	                         // �������� ��� ��������� �������� ���� (������ OnSize � MFC) 
  //-------������� ���� -------------------------
	glutCreateMenu(Figure);
		glutAddMenuEntry("�����������",1);
		glutAddMenuEntry("�������������",2);
		glutAddMenuEntry("��������",0);
	glutAttachMenu(GLUT_RIGHT_BUTTON);
//-------------------------------------------------
  glutMainLoop(); //������ ������������ ����� ��������� ��������� Windows
	return 0;
} 
 