#include "Figures.h"
 const float pi=3.14159;
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
			glutSwapBuffers(); // ������������ ������� (����������� 
	                   // ��� ������������� ������� ����������� GLUT_DOUBLE
			break;
		}

		case 1:
		{
			glClearColor(0.0,0.0,0.0,0.0); //���� ���� � ����
			//glEnable     ( GL_DEPTH_TEST );
			glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT );  // �������� ����� ����� - ������ ������ ����		
			glColor3ub(255,0,0);	// ���� ����� 
			glLineWidth(1.0) ;	    // ������� �����

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 	// ������� �������  M=I	
			glRotatef(angleY,0.0,1.0,0.0); // ������ ��� Y, M=Ry(angleY) 
			glRotatef(angleX,1.0,0.0,0.0); // ������ ��� X, M=Ry(angleY)*Rx(angleX) 
			// ��������� V2=Ry*Rx*V1
					
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10; znear=-10; zfar=10;
			glOrtho(left, right, bottom, top,znear,zfar); 

			//glEnable (GL_CULL_FACE);
			//glCullFace (GL_FRONT );
			//glCullFace (GL_BACK );
					
			glPolygonMode (GL_FRONT_AND_BACK ,GL_LINE); 

			GLfloat x1=-2.5, x2=2.5,y1=-2.5,y2=2.5,z1=0.0,z2=5;
			Pyramid(x1,x2,y1,y2,z1,z2);
			glutSwapBuffers(); // ������������ ������� (����������� 
	                   // ��� ������������� ������� ����������� GLUT_DOUBLE
			break;
			
		}

		case 2:
		{
			glClearColor(0.0,0.0,0.0,0.0); //���� ���� � ����
			//glEnable     ( GL_DEPTH_TEST );
			glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT );  // �������� ����� ����� - ������ ������ ����		
			glColor3ub(255,0,0);	// ���� ����� 
			glLineWidth(1.0) ;	    // ������� �����

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 	// ������� �������  M=I	
			glRotatef(angleY,0.0,1.0,0.0); // ������ ��� Y, M=Ry(angleY) 
			glRotatef(angleX,1.0,0.0,0.0); // ������ ��� X, M=Ry(angleY)*Rx(angleX) 
			// ��������� V2=Ry*Rx*V1
					
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10; znear=-10; zfar=10;
			glOrtho(left, right, bottom, top,znear,zfar); 

			glEnable (GL_CULL_FACE);
			glCullFace (GL_BACK );
					
			glPolygonMode (GL_FRONT_AND_BACK ,GL_LINE); 

			GLfloat x1=-2.5, x2=2.5,y1=-2.5,y2=2.5,z1=0.0,z2=5;
			Pyramid(x1,x2,y1,y2,z1,z2);
			glutSwapBuffers(); // ������������ ������� (����������� 
	                           // ��� ������������� ������� ����������� GLUT_DOUBLE
			break;
			
		}
		case 3:
		{
			glClearColor(0.0,0.0,0.0,0.0); //���� ���� � ����
			glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT );  // �������� ����� ����� - ������ ������ ����		
			glColor3ub(255,0,0);	// ���� ����� 
			glLineWidth(1.0) ;	    // ������� �����

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 
			glRotatef(angleY,0.0,1.0,0.0); // ������ ��� Y, M=Ry(angleY) 
			glRotatef(angleX,1.0,0.0,0.0); // ������ ��� X, M=Ry(angleY)*Rx(angleX) 
			// ��������� V2=Ry*Rx*V1
					
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10; znear=-10; zfar=10;
			glOrtho(left, right, bottom, top,znear,zfar); 

			glEnable (GL_CULL_FACE);
			//glCullFace (GL_FRONT );
			glCullFace (GL_BACK );
					
			glPolygonMode (GL_FRONT_AND_BACK ,GL_LINE); 

			GLfloat x1=-2.5, x2=2.5,y1=-5,y2=5,z1=-5,z2=5;
			Box(x1,x2,y1,y2,z1,z2);
			glutSwapBuffers(); // ������������ ������� (����������� 
	                           // ��� ������������� ������� ����������� GLUT_DOUBLE
			break;		
		}
		case 4: //����������
		{
			glClearColor(1.0,1.0,1.0,0.0); //���� ���� � ����		
			glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT );  // �������� ����� ����� - ������ ������ ����	
			glEnable     ( GL_DEPTH_TEST );	// ��������� ���� ������� !!!!!
			//glColor3ub(255,0,0);	// ���� ����� 
			//glLineWidth(1.0) ;	    // ������� �����

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 
			glRotatef(angleY,0.0,1.0,0.0); // ������ ��� Y, M=Ry(angleY) 
			glRotatef(angleX,1.0,0.0,0.0); // ������ ��� X, M=Ry(angleY)*Rx(angleX) 
			// ��������� V2=Ry*Rx*V1
					
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10; znear=-15; zfar=15;
			glOrtho(left, right, bottom, top,znear,zfar); 

			glEnable (GL_CULL_FACE);
			glCullFace (GL_BACK );
					
			//glPolygonMode (GL_FRONT_AND_BACK ,GL_FILL); 

			GLfloat x1=-2.5, x2=2.5,y1=-2.5,y2=2.5,z1=-2.5,z2=2.5;
			Box(x1,x2,y1,y2,z1,z2);

//--------------- �������� --------------------------------------
			glColor3ub(0,0,255);	// ���� ����� 
			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 	// ������� �������  M=I	
			
			glRotatef(angleY,0.0,1.0,0.0); // ������ ��� Y, M=Ry(angleY) 
			glRotatef(angleX,1.0,0.0,0.0); // ������ ��� X, M=Ry(angleY)*Rx(angleX)
			glTranslatef(0.0,0.0,-10.0);	// ��������	
			// ��������� V2=Ry*Rx*V1*Txyz
					
			//glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			//glLoadIdentity(); 
			//left=-10; right=10; bottom=-10; top=10; znear=-10; zfar=10;
			//glOrtho(left, right, bottom, top,znear,zfar); 

			//glEnable (GL_CULL_FACE);
			//glCullFace (GL_BACK );
			//		
			//glPolygonMode (GL_FRONT_AND_BACK ,GL_LINE); 

		    x1=-2.5, x2=2.5,y1=-2.5,y2=2.5,z1=0.0,z2=5.0;
			Pyramid(x1,x2,y1,y2,z1,z2);
			glutSwapBuffers(); // ������������ ������� (����������� 
							   // ��� ������������� ������� ����������� GLUT_DOUBLE

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
         
switch(key)
{
	case'a':case'A':	// Gbhfvblf
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

	case'd':case'D':	//  �������� � ������������ - ����������
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


//--------- �������� --------------------------------------------

void Pyramid( GLfloat x1, GLfloat x2, GLfloat y1, GLfloat y2, GLfloat z1,GLfloat z2)
{		
//��������� ABCD: A(x1,y1,z1),B(x2,y1,z1),C(x2,y2,z1),D(x1,y2,z1)
//������� E(0,0,z2)

        glBegin ( GL_POLYGON );         // ��������� 
         
glColor3ub(255,0,0);	// ���� ������� 
	      glVertex3f ( x2, y1, z1 );	//D
glColor3ub(0,255,0);	// ���� ������� 
          glVertex3f ( x1, y1, z1 );	//A
glColor3ub(0,0,255);	// ���� ������� 
          glVertex3f ( x1, y2, z1 );	//B
glColor3ub(255,255,0);	// ���� ������� 
          glVertex3f ( x2, y2, z1 );	//C
        glEnd ();

		

				glBegin ( GL_POLYGON );         // EDC
  glColor3ub(0,0,255);	// ���� �������         
					glVertex3f ( 0, 0, z2 );	//E
glColor3ub(0,0,120);	// ���� ������� 
          glVertex3f ( x2, y1, z1 );	//D
glColor3ub(0,0,0);	// ���� ������� 
					glVertex3f ( x2, y2, z1 );	//C         
        glEnd ();



				glBegin ( GL_POLYGON );         // ECB
glColor3ub(0,0,255);	// ���� �������          
					glVertex3f ( 0, 0, z2 );	//E
glColor3ub(0,0,120);	// ���� ������� 
					glVertex3f ( x2, y2, z1 );	//C 
glColor3ub(0,0,0);	// ���� ������� 
          glVertex3f ( x1, y2, z1 );	//B					       
        glEnd ();

				glBegin ( GL_POLYGON );         // EBA
glColor3ub(0,0,255);	// ���� �������            
					glVertex3f ( 0, 0, z2 );	//E
glColor3ub(0,0,120);	// ���� ������� 
					glVertex3f ( x1, y2, z1 );	//B	
glColor3ub(0,0,0);	// ���� ������� 
					glVertex3f ( x1, y1, z1 );	//A
        glEnd ();

				glBegin ( GL_POLYGON );         // EAD
glColor3ub(0,0,255);	// ���� �������            
					glVertex3f ( 0, 0, z2 );	//E
glColor3ub(0,0,120);	// ���� ������� 
					glVertex3f ( x1, y1, z1 );	//A
glColor3ub(0,0,0);	// ���� ������� 
					glVertex3f ( x2, y1, z1 );	//D

        glEnd ();	
        
}


//-----------------------------------------------------------------

void    Box ( GLfloat x1, GLfloat x2, GLfloat y1, GLfloat y2, GLfloat z1, GLfloat z2)
{				
        glBegin ( GL_POLYGON );     // front face - ����� �� ������� ������� 
			glColor3ub(255,0,0);	// ���� �������  
			glVertex3f ( x1, y1, z2 );
			glColor3ub(200,0,0);	// ���� �������  
			glVertex3f ( x2, y1, z2 );
			glColor3ub(150,0,0);	// ���� �������  
			glVertex3f ( x2, y2, z2 );
			glColor3ub(50,0,0);	// ���� �������  
			glVertex3f ( x1, y2, z2 );
        glEnd ();

        glBegin ( GL_POLYGON );         // back face
			glColor3ub(255,0,0);	// ���� �������            
			glVertex3f ( x2, y1, z1 );
			glColor3ub(200,0,0);	// ���� ������� 
			glVertex3f ( x1, y1, z1 );
			glColor3ub(150,0,0);	// ���� �������  
		    glVertex3f ( x1, y2, z1 );
			glColor3ub(50,0,0);	// ���� �������  
            glVertex3f ( x2, y2, z1 );
        glEnd ();

        glBegin ( GL_POLYGON );         // left face
			glColor3ub(255,0,0);	// ���� �������           
			glVertex3f ( x1, y1, z1 );
			glColor3ub(200,0,0);	// ���� ������� 
			glVertex3f ( x1, y1, z2 );
			glColor3ub(150,0,0);	// ���� �������  
			glVertex3f ( x1, y2, z2 );
			glColor3ub(50,0,0);	// ���� �������  
			glVertex3f ( x1, y2, z1 );
        glEnd ();

        glBegin ( GL_POLYGON);         // right face
			glColor3ub(255,0,0);	// ���� �������               
			glVertex3f ( x2, y1, z2 );
			glColor3ub(200,0,0);	// ���� �������     
			glVertex3f ( x2, y1, z1 );
			glColor3ub(150,0,0);	// ���� �������     
			glVertex3f ( x2, y2, z1 );
			glColor3ub(50,0,0);	// ���� �������     
			glVertex3f ( x2, y2, z2 );

        glEnd ();

        glBegin ( GL_POLYGON );         // top face
			glColor3ub(255,0,0);	// ���� �������           
			glVertex3f ( x1, y2, z2 );
			glColor3ub(200,0,0);	// ���� �������    
			glVertex3f ( x2, y2, z2 );
			glColor3ub(150,0,0);	// ���� �������
			glVertex3f ( x2, y2, z1 );
			glColor3ub(50,0,0);	// ���� �������
			glVertex3f ( x1, y2, z1 );
        glEnd ();

        glBegin ( GL_POLYGON );         // bottom face
			glColor3ub(255,0,0);	// ���� �������                 
			glVertex3f ( x2, y1, z2 );
			glColor3ub(200,0,0);	// ���� �������    
			glVertex3f ( x1, y1, z2 );
			glColor3ub(150,0,0);	// ���� �������
			glVertex3f ( x1, y1, z1 );
			glColor3ub(50,0,0);	// ���� �������
			glVertex3f ( x2, y1, z1 );
        glEnd ();
}

 
//================ main ==================================================
int main(int argc, char *argv[]) 
{ 
//----- ������� ���������� GLUT ------------------------------------------
    glutInit(&argc, argv); // ������������� ���������� GLUT
//������������ ����� RGB ��� ������ �����,��������� ����������,
//����������� ������������� ����� �������
    glutInitDisplayMode(GLUT_RGB|GLUT_DOUBLE| GLUT_DEPTH ); 
			                                           
	glutInitWindowPosition  (x_win,y_win);     // ���������� ������ �������� ���� 
	                                           //���� OpenGL �� ������ ��������
    glutInitWindowSize(Width, Height);         //������ � ������ ���� OpenGL 
	glutCreateWindow("������_4.   ��� ������"); //�������� ���� � ����������
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
 
 