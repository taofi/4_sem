#include "Primer2.h"
 const float pi=3.14159;
//---- ���������� ����������---------------------------------
GLint x_win=100;     // x - ���������� ������ �������� ���� ���� OpenGL �� ������
GLint y_win=50;     // y - ���������� ������ �������� ���� ���� OpenGL �� ������
GLint Width = 800;	  // ��������� ������ ���� 
GLint Height = 600;   // ��������� ������ ���� 
GLint left,right,top,bottom; // ��� ����������� ������� ��������� �����������
                             //������ ����� �������������� � ���
GLint Index=0;  // ��� ������ �������
float **MasFunc=NULL; // ��� ������� �������� �������
int NamberPoints; // ����� ����� ��� ������� �������
float angle=0;    // ���� ��� �������� ������������, ����
float d_angle=10;    // ��� �������� ����, ����
char MyText1[]="Font GLUT_BITMAP_8_BY_13 ";
char MyText2[]="Font GLUT_BITMAP_9_BY_15 ";
char MyText3[]="Font  GLUT_BITMAP_TIMES_ROMAN_10";
char MyText4[]="Font GLUT_BITMAP_HELVETICA_12";
char MyText5[]="Font GLUT_BITMAP_HELVETICA_18";
 
//------ ��� ������� ��������� ���� ������� �� �����----------- 
void OnDraw(void) 
{   
	//glClearColor(1.0,1.0,1.0,0.0); // ���� ����� ���������� ��� ��� ���� �������� Index
	//glClear(GL_COLOR_BUFFER_BIT); 
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
			glClearColor(0.0,0.0,0.0,0.0); //���� ���� � ����
			glClear(GL_COLOR_BUFFER_BIT);  // �������� ����� ����� - ������ ������ ����		
			glColor3ub(255,255,0);	// ���� ����� 
			glLineWidth(3.0) ;	    // ������� �����

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 
			glRotatef(angle,0.0,0.0,1.0); //  
			
			
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10;
			gluOrtho2D(left, right, bottom, top); // (left,bottom)- (right,top)
			Triangle();
			break;
		}

		case 2:
		{
			glClearColor(0.0,1.0,0.0,0.0); //���� ���� � ����
			glClear(GL_COLOR_BUFFER_BIT);  // �������� ����� ����� - ������ ������ ����	
			glColor3ub(0,0,255);	       // ���� ����� 

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 	
			
			
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10;
			gluOrtho2D(left, right, bottom, top); // (left,bottom)- (right,top)
			Rectangle();
			break;
		}
		case 3:
		{
			glClearColor(1.0,1.0,1.0,0.0); //���� ���� � ����
			glClear(GL_COLOR_BUFFER_BIT);  // �������� ����� ����� - ������ ������ ����	
			//glColor3ub(0,0,0);	// ���� ����� 
			//glLineWidth(2.0) ;	// ������� �����
			
			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 

			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			//left=-10; right=10; bottom=-10; top=10;
			gluOrtho2D(left, right, bottom, top); // (left,bottom)- (right,top)
			MyFunction();
			break;
		}

		case 4:
		{
			glClearColor(1.0,1.0,1.0,0.0);
			glClear(GL_COLOR_BUFFER_BIT); 

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 

			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-30; right=30; bottom=-30; top=30;
			gluOrtho2D(left, right, bottom, top); // (left,bottom)- (right,top)

			glColor3ub(0,0,0);	// ���� ������
			glRasterPos2i(-10,0);
			int len=strnlen(MyText1,100);
			for(int i=0;i<len;i++)glutBitmapCharacter(GLUT_BITMAP_8_BY_13,MyText1[i]);

			glColor3ub(255,0,0);	// ���� ������
			glRasterPos2i(-10,3);
			len=strnlen(MyText2,100);
			for(int i=0;i<len;i++)glutBitmapCharacter(GLUT_BITMAP_9_BY_15,MyText2[i]);
			
			glColor3ub(0,255,0);	// ���� ������
			glRasterPos2i(-10,6);
			len=strnlen(MyText3,100);
			for(int i=0;i<len;i++)glutBitmapCharacter(GLUT_BITMAP_TIMES_ROMAN_10,MyText3[i]);
			glColor3ub(0,0,255);	// ���� ������
			glRasterPos2i(-10,9);
			len=strnlen(MyText4,100);
			for(int i=0;i<len;i++)glutBitmapCharacter(GLUT_BITMAP_HELVETICA_12,MyText4[i]);

			glColor3ub(0,125,125);	// ���� ������
			glRasterPos2i(-10,12);
			len=strnlen(MyText5,100);
			for(int i=0;i<len;i++)glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18,MyText5[i]);


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

 
//-- ������� ������������ ��������� �� ������, ������� ASCII - ���  -------

void Keyboard( unsigned char key, int x, int y )
{ 
#define ESCAPE '\033' 
 
if( key == ESCAPE ) exit(0);
//if( key == ESCAPE ) Index=1;
         
switch(key)
{
	case'a':case'A':	// �����������
		{
			Index=1;
			break;
		}
	case'b':case'B':	// ����������� �������������
		{
			Index=2;
			break;
		}

	case'f':case'F':	// ������ �������
		{
			if(MasFunc!=NULL)MasFunc=NULL;

			float x_begin=-8*pi, x_end=8*pi, dx=pi/10;
			NamberPoints=(int)((x_end-x_begin)/dx)+1;	//����� �������� ���������
			
			MasFunc=new float*[NamberPoints];
			for(int i=0;i<NamberPoints;i++) MasFunc[i]=new float[2];
			
			CreateMasFunc(MyF1,x_begin,dx,NamberPoints,MasFunc);
			float maxF=MasFunc[0][1];
			for(int i=0;i<NamberPoints;i++)	//����� ������������� �������� y
			{
				if(maxF<MasFunc[i][1])maxF=MasFunc[i][1];
			}
			left=x_begin; right=x_end; bottom=-maxF; top=maxF;
			Index=3;
			break;
		}

	case't':case'T':	// ����� ������
		{
			Index=4;
			break;
		}
}

glutPostRedisplay();

} 

//-- ������� ������������ ��������� �� ������, �� ������� ASCII - ����  -------

void SpecialKey(int key, int x, int y )
{
	switch(key)
	{
		case GLUT_KEY_RIGHT:	// ������� ������ (102)
		{
			angle+=d_angle;		
			break;
		}
		case GLUT_KEY_LEFT:	// ������� ����� (100)
		{
			angle-=d_angle;	
			break;
		}
	}

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
	  /*glVertex2f(-5.0,-5.0); 
	  glVertex2f(-5.0,5.0); 
	  glVertex2f(5.0,5.0); 
	  glVertex2f(5.0,-5.0); */

      for(int i=0;i<4;i++) glVertex2fv(VectCoords[i]); 
    glEnd(); 	
}

//------------- MyFunction ------------------------------------------
void MyFunction()
{
	if(left*right<0)        // ����� ��� Y -?
	{	
		glColor3ub(0,0,255);	// ���� ����� 
		glLineWidth(3.0) ;	    // ������� �����
		glBegin(GL_LINE_STRIP); // ��� y
		  glVertex2f(0,bottom); 
		  glVertex2f(0,top);     
		glEnd(); 
	}

	if(top*bottom<0)        // ����� ��� X -?
	{
		glColor3ub(0,0,255);	// ���� ����� 
		glLineWidth(3.0) ;	    // ������� �����
		glBegin(GL_LINE_STRIP); // ��� X
		  glVertex2f(left,0); 
		  glVertex2f(right,0);     
		glEnd(); 
	}

    glColor3ub(255,0,0);	// ���� ����� 
	glLineWidth(2.0) ;	    // ������� �����
	glBegin(GL_LINE_STRIP); // ����� �������
      for(int i=0;i<NamberPoints;i++) glVertex2fv(MasFunc[i]); 
    glEnd(); 	
}

//-------- �������------------------------------------------------
void CreateMasFunc(pFunc FuncName,float x_begin,float dx,int N,float **Mas)
//������� ������� ������ �������� ������� y=f(x)
//pFunc - ��������� �� ������� f(x)
//x_begin - ��������� �������� ���������
//dx - ��� ��������� ���������
//N - ����� ����� ��� ���������
//Mas - ������ �������� Nx2 ��� ������ �������� �������

{
	for(int i=0;i<N;i++)
	{
		float x=x_begin+i*dx;
		float y=FuncName(x);
		Mas[i][0]=x;
		Mas[i][1]=y;
	}		
}

//--------- MayF1 ------------------------------------------------------
float MyF1(float x)
{
	float y;
	if (fabs(x)<0.0001) y=1;
	else y=(sin(x)/x);
	return y;
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
	glutCreateWindow("������_2.    ��������� ����������"); //�������� ���� � ����������
    glutDisplayFunc(OnDraw); // ����������� ������� ��������� ������ OnDraw - ����������
	                         // �������� ��� ������������� ������������ ���� (������ OnPaint � MFC) 
    glutReshapeFunc(OnSize); // ����������� ������� ��������� ������ OnSize - ����������
	                         // �������� ��� ��������� �������� ���� (������ OnSize � MFC) 
    glutKeyboardFunc(Keyboard); // ����������� ������� ��������� ������ Keyboard -����������
                                // �������� ��� ��� ������ �������, ������� ASCII-��� 
	glutSpecialFunc(SpecialKey);// ����������� ������� ��������� ������ SpesialKey -����������
                                // �������� ��� ��� ������ �������, �� ������� ASCII-���� 
    glutMainLoop(); //������ ������������ ����� ��������� ��������� Windows
//-------------------------------------------------------------------------------
//�������� ������������� ������� 
	for(int i=0;i<NamberPoints;i++) delete MasFunc[i]; 
	delete MasFunc;
	return 0;
} 
 
 