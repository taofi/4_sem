#include "Light.h"

//---- ���������� ����������---------------------------------
GLint x_win=100;     // x - ���������� ������ �������� ���� ���� OpenGL �� ������
GLint y_win=50;     // y - ���������� ������ �������� ���� ���� OpenGL �� ������
GLint Width = 800;	  // ��������� ������ ���� 
GLint Height = 600;   // ��������� ������ ���� 
GLint left,right,top,bottom,znear,zfar; // ��� ����������� ������� ��������� �����������
                             //������ ����� �������������� � ���
GLint Index=0;  // ��� ������ �������

float angleX=0;    // ���� ��� �������� ������ ��� X, ����
float angleY=0;    // ���� ��� �������� ������ ��� X, ����
float d_angle=10;    // ��� �������� ����, ����


//��������� ��������� ��������������� 
float mat1_dif[]={0.8f,0.8f,0.0f}; 
float mat1_amb[]= {0.2f,0.2f,0.2f}; 
float mat1_spec[]={0.6f,0.6f,0.6f}; 
float mat1_shininess=0.5f*128; 

 
 //��������� ��������� �������� 
float mat3_dif[]={0.9f,0.2f,0.0f}; 
float mat3_amb[]= {0.2f,0.2f,0.2f}; 
float mat3_spec[]={0.6f,0.6f,0.6f}; 
float mat3_shininess=0.1f*128; 
 



//------ ��� ������� ��������� ���� ������� �� �����----------- 
void OnDraw(void) 
{   
	switch(Index)
	{
		case 0:
		{
			Init();
			glClearColor(1.0,1.0,1.0,0.0);
			glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT ); 
			glutSwapBuffers(); // ������������ ������� (����������� 
	                   // ��� ������������� ������� ����������� GLUT_DOUBLE
			break;
		}

		case 1:
		{
			glClearColor(1.0,1.0,1.0,0.0); //���� ���� � ����
			glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT );  // �������� ����� ����� - ������ ������ ����		
			
			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 
			glRotatef(angleY,0.0,1.0,0.0); // ������ ��� Y, M=Ry(angleY) 
			glRotatef(angleX,1.0,0.0,0.0); // ������ ��� X, M=Ry(angleY)*Rx(angleX) 
			// ��������� V2=Ry*Rx*V1
					
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10; znear=-10; zfar=10;
			glOrtho(left, right, bottom, top,znear,zfar); 

			glMaterialfv (GL_FRONT,GL_AMBIENT,mat1_amb); 
			glMaterialfv (GL_FRONT,GL_DIFFUSE,mat1_dif); 
			glMaterialfv (GL_FRONT,GL_SPECULAR,mat1_spec); 
			glMaterialf  (GL_FRONT,GL_SHININESS,mat1_shininess); 

			GLfloat x1=-2.5, x2=2.5,y1=-5,y2=5,z1=-5,z2=5;
			Box(x1,x2,y1,y2,z1,z2);
			glutSwapBuffers(); // ������������ ������� (����������� 
	                           // ��� ������������� ������� ����������� GLUT_DOUBLE
			break;		
			
			
		}

		case 2:
		{
		
			glClearColor(1.0,1.0,1.0,0.0); //���� ���� � ����
			glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT );  // �������� ����� ����� - ������ ������ ����		
			
			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 
			glRotatef(angleY,0.0,1.0,0.0); // ������ ��� Y, M=Ry(angleY) 
			glRotatef(angleX,1.0,0.0,0.0); // ������ ��� X, M=Ry(angleY)*Rx(angleX) 
			// ��������� V2=Ry*Rx*V1
					
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10; znear=-10; zfar=10;
			glOrtho(left, right, bottom, top,znear,zfar); 

			glMaterialfv (GL_FRONT,GL_AMBIENT,mat3_amb); 
			glMaterialfv (GL_FRONT,GL_DIFFUSE,mat3_dif); 
			glMaterialfv (GL_FRONT,GL_SPECULAR,mat3_spec); 
			glMaterialf  (GL_FRONT,GL_SHININESS,mat3_shininess); 
			GLfloat x1=-2.5, x2=2.5,y1=-5,y2=5,z1=-5,z2=5;	
			Pyramid(x1,x2,y1,y2,z1,z2);

			glutSwapBuffers(); // ������������ ������� (����������� 
	                           // ��� ������������� ������� ����������� GLUT_DOUBLE
			break;		
			
			
			
		}
		case 3:
		{
			
		}
		case 4:
		{
			
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
         
switch(key)
{
	case'a':case'A':	// ������������
		{
			Index=1;
			break;
		}
	case'b':case'B':	// ��������
		{
			Index=2;
			break;
		}

	case'c':case'C':	// ������������ � ��������� ��������� ������
		{
			
			Index=3;
			break;
		}

	case'd':case'D':	//  �������� � ������������
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
			angleY+=d_angle;		
			break;
		}
		case GLUT_KEY_LEFT:	// ������� ����� (100)
		{
			angleY-=d_angle;	
			break;
		}
		case GLUT_KEY_UP:	// ������� ����� (101)
		{
			angleX-=d_angle;		
			break;
		}
		case GLUT_KEY_DOWN:	// ������� ���� (103)
		{
			angleX+=d_angle;	
			break;
		}
	}
glutPostRedisplay();
}

//------------------ Init()-------------------------------------
 
void Init () 
// ������������� ���������� ���������� � ��������� ����� 

{ 
   GLfloat light_ambient[] = { 0.0, 0.0, 0.0, 1.0 }; 
   GLfloat light_diffuse[] = { 1.0, 1.0, 1.0, 1.0 }; 
   GLfloat light_specular[] = { 1.0, 1.0, 1.0, 1.0 }; 
   GLfloat light_position[] = { 0.0, 0.0, 1.0, 0.0 }; 

   //������������� ��������� ��������� �����  
   glLightfv (GL_LIGHT0, GL_AMBIENT, light_ambient); 
   glLightfv (GL_LIGHT0, GL_DIFFUSE, light_diffuse); 
   glLightfv (GL_LIGHT0, GL_SPECULAR, light_specular);
   glLightfv (GL_LIGHT0, GL_POSITION, light_position);
 
   // �������� ��������� � �������� �����  
   glEnable (GL_LIGHTING); 
   glEnable (GL_LIGHT0); 
   // ��������� ���� �������
   glEnable(GL_DEPTH_TEST);
  
} 



//--------- �������� --------------------------------------------

void Pyramid( GLfloat x1, GLfloat x2, GLfloat y1, GLfloat y2, GLfloat z1,GLfloat z2)
{		
//��������� ABCD: A(x1,y1,z1),B(x2,y1,z1),C(x2,y2,z1),D(x1,y2,z1)
//������� E(0,0,z2)
GLfloat VN[3]; //������ �������;
Point A(x1,y1,z1),B(x2,y1,z1),C(x2,y2,z1),D(x1,y2,z1),E(0,0,z2);

		GetNormal(A,B,D,VN); // �������� ������� � ���������
        glBegin ( GL_POLYGON );         // ��������� 
          glNormal3fv (VN);
          glVertex3f ( x2, y1, z1 );	//D
          glVertex3f ( x1, y1, z1 );	//A
          glVertex3f ( x1, y2, z1 );	//B
          glVertex3f ( x2, y2, z1 );	//C
        glEnd ();

		GetNormal(E,D,C,VN); // �������� ������� � EDC
		glBegin ( GL_POLYGON );         // EDC
		  glNormal3fv (VN);
		  glVertex3f ( 0, 0, z2 );	//E
          glVertex3f ( x2, y1, z1 );	//D
	      glVertex3f ( x2, y2, z1 );	//C         
        glEnd ();

		GetNormal(E,C,B,VN); // �������� ������� � ECB
		glBegin ( GL_POLYGON );         // ECB
          glNormal3fv (VN);
		  glVertex3f ( 0, 0, z2 );	//E
		  glVertex3f ( x2, y2, z1 );	//C  
          glVertex3f ( x1, y2, z1 );	//B					       
        glEnd ();

		GetNormal(E,B,A,VN); // �������� ������� � EBA
		glBegin ( GL_POLYGON );         // EBA
		  glNormal3fv (VN);
		  glVertex3f ( 0, 0, z2 );	//E
		  glVertex3f ( x1, y2, z1 );	//B	
		  glVertex3f ( x1, y1, z1 );	//A
        glEnd ();

		GetNormal(E,A,D,VN); // �������� ������� � EAD
		glBegin ( GL_POLYGON );         // EAD
          glNormal3fv (VN);
		  glVertex3f ( 0, 0, z2 );	//E
		  glVertex3f ( x1, y1, z1 );	//A
		  glVertex3f ( x2, y1, z1 );	//D
        glEnd ();	
        
}


//-----------------------------------------------------------------

void    Box ( GLfloat x1, GLfloat x2, GLfloat y1, GLfloat y2, GLfloat z1, GLfloat z2)
{				
        glBegin ( GL_POLYGON );         // front face - ����� �� ������� ������� 
          glNormal3f ( 0.0, 0.0, 1.0 );
          glVertex3f ( x1, y1, z2 );
          glVertex3f ( x2, y1, z2 );
          glVertex3f ( x2, y2, z2 );
          glVertex3f ( x1, y2, z2 );
        glEnd ();

        glBegin ( GL_POLYGON );         // back face
          glNormal3f ( 0.0, 0.0, -1.0 );
          glVertex3f ( x2, y1, z1 );
          glVertex3f ( x1, y1, z1 );
          glVertex3f ( x1, y2, z1 );
          glVertex3f ( x2, y2, z1 );
        glEnd ();

        glBegin ( GL_POLYGON );         // left face
          glNormal3f ( -1.0, 0.0, 0.0 );
          glVertex3f ( x1, y1, z1 );
          glVertex3f ( x1, y1, z2 );
          glVertex3f ( x1, y2, z2 );
          glVertex3f ( x1, y2, z1 );
        glEnd ();

        glBegin ( GL_POLYGON);         // right face
          glNormal3f ( 1.0, 0.0, 0.0 );
          glVertex3f ( x2, y1, z2 );
          glVertex3f ( x2, y1, z1 );
          glVertex3f ( x2, y2, z1 );
          glVertex3f ( x2, y2, z2 );
        glEnd ();

        glBegin ( GL_POLYGON );         // top face
          glNormal3f ( 0.0, 1.0, 0.0 );
          glVertex3f ( x1, y2, z2 );
          glVertex3f ( x2, y2, z2 );
          glVertex3f ( x2, y2, z1 );
          glVertex3f ( x1, y2, z1 );
        glEnd ();

        glBegin ( GL_POLYGON );         // bottom face
          glNormal3f ( 0.0, -1.0, 0.0 );
          glVertex3f ( x2, y1, z2 );
          glVertex3f ( x1, y1, z2 );
          glVertex3f ( x1, y1, z1 );
          glVertex3f ( x2, y1, z1 );
        glEnd ();
}

//-------------GetNormal-------------------------------------
void GetNormal(Point &P1,Point &P2,Point &P3,GLfloat *VN)
// ��������� ��������� ������ ������� � ���������,������������
// ������� P1,P2,P3(P=(P.x,P.y,P.z)
// ������� P1P2, P1P3 � VN �������� ������ ������ 
// ��������� ������������ � ������ VN[3]
{
	double V1[3]={P2.x-P1.x,P2.y-P1.y,P2.z-P1.z}; //P1P2
	double V2[3]={P3.x-P1.x,P3.y-P1.y,P3.z-P1.z}; //P1P3
	double x=V1[1]*V2[2]-V1[2]*V2[1];
	double y=-(V1[0]*V2[2]-V1[2]*V2[0]);
	double z=V1[0]*V2[1]-V1[1]*V2[0];
	double r=sqrt(x*x+y*y+z*z);
	VN[0]=x/r;
	VN[1]=y/r;
	VN[2]=z/r;
}

 
//================ main ==================================================
int main(int argc, char *argv[]) 
{ 
//----- ������� ���������� GLUT ------------------------------------------
    glutInit(&argc, argv); // ������������� ���������� GLUT
//������������ ����� RGB ��� ������ �����,��������� ����������,
//����������� ������������� ����� �������
    glutInitDisplayMode(GLUT_RGB|GLUT_DOUBLE); 
			                                           
		glutInitWindowPosition  (x_win,y_win);     // ���������� ������ �������� ���� 
	                                           //���� OpenGL �� ������ ��������
    glutInitWindowSize(Width, Height);         //������ � ������ ���� OpenGL 
		glutCreateWindow("������_4.  ����"); //�������� ���� � ����������
	
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

	return 0;
} 
 
 