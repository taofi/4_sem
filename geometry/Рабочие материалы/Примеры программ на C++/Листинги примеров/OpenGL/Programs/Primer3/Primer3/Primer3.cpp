#include "Primer3.h"
const float pi=3.14159;

//---- ���������� ����������---------------------------------

// x - ���������� ������ �������� ���� ���� OpenGL �� ������
GLint x_win=100;   
// y - ���������� ������ �������� ���� ���� OpenGL �� ������
GLint y_win=50;  
// ��������� ������ ���� 
GLint Width = 800;	
// ��������� ������ ����
GLint Height = 600;   
// ��� ����������� ������� ��������� �����������
//������ ����� �������������� � ���
GLint left,right,top,bottom,znear,zfar; 
 // ��� ������ �������                           
GLint Index=0; 
// ���� ��� �������� ������ ��� X, ����
float angleX=0;  
// ���� ��� �������� ������ ��� X, ����
float angleY=0;
// ��� �������� ����, ����
float d_angle=10;    

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
			glClearColor(1.0,1.0,1.0,0.0); //�����
			//�������� ����� ����� - ������ ������ ����
			glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT );  		
			glColor3ub(255,0,0);	// ���� ����� - �������
			glLineWidth(2.0) ;	    // ������� �����

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 	        // ������� �������  M=I	
			//������� ������ ��� Y, M=Ry(angleY)
			glRotatef(angleY,0.0,1.0,0.0);  
			//������� ������ ��� X, M=Ry(angleY)*Rx(angleX) 
			glRotatef(angleX,1.0,0.0,0.0); 
			//��������� V2=Ry*Rx*V1
					
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10; znear=-10; zfar=10;
			//������������� ������� ���������
			glOrtho(left, right, bottom, top,znear,zfar); 				
			glPolygonMode (GL_FRONT_AND_BACK ,GL_LINE); 
			GLfloat x1=-5, x2=5,y1=-5,y2=5,z1=0.0,z2=10;
			glDisable (GL_CULL_FACE);    //��������� ������� �� ������� �����
			Pyramid(x1,x2,y1,y2,z1,z2);  //������ ��������
			break;
			
		}

		case 2:
		{
			//���� ���� � ����
			glClearColor(1.0,1.0,1.0,0.0); //�����
			//�������� ����� ����� - ������ ������ ����	
			glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT );  		
			glColor3ub(0,0,255);	// ���� ����� - ����� 
			glLineWidth(2.0) ;	    // ������� �����

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 	// ������� �������  M=I	
			//������� ������ ��� Y, M=Ry(angleY)
			glRotatef(angleY,0.0,1.0,0.0); 
			//������� ������ ��� X, M=Ry(angleY)*Rx(angleX) 
			glRotatef(angleX,1.0,0.0,0.0); 
			//��������� V2=Ry*Rx*V1
					
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10; znear=-10; zfar=10;
			//������������� ������� ���������
			glOrtho(left, right, bottom, top,znear,zfar); 

			glEnable (GL_CULL_FACE);//��������� ������� �� ������� �����
			glCullFace (GL_BACK );
					
			glPolygonMode (GL_FRONT_AND_BACK ,GL_LINE); 
			GLfloat x1=-5, x2=5,y1=-5,y2=5,z1=0.0,z2=10;
			Pyramid(x1,x2,y1,y2,z1,z2); //������ ��������
			break;
			
		}
		case 3:
		{
			//���� ���� � ����
			glClearColor(1.0,1.0,1.0,0.0); //�����
			//�������� ����� ����� - ������ ������ ����
			glClear(GL_COLOR_BUFFER_BIT| GL_DEPTH_BUFFER_BIT );  		
			glColor3ub(0,0,0);	// ���� ����� - ������ 
			glLineWidth(2.0) ;	    // ������� �����

			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 
			//������� ������ ��� Y, M=Ry(angleY)
			glRotatef(angleY,0.0,1.0,0.0); 
			//������� ������ ��� X, M=Ry(angleY)*Rx(angleX) 
			glRotatef(angleX,1.0,0.0,0.0); 
			// ��������� V2=Ry*Rx*V1
					
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-10; right=10; bottom=-10; top=10; znear=-10; zfar=10;
			//������������� ������� ���������
			glOrtho(left, right, bottom, top,znear,zfar); 

			glEnable (GL_CULL_FACE); //��������� ������� �� ������� �����
			glCullFace (GL_BACK );
					
			glPolygonMode (GL_FRONT_AND_BACK ,GL_LINE); 

			GLfloat x1=-2.5, x2=2.5,y1=-5,y2=5,z1=-5,z2=5;
			Box(x1,x2,y1,y2,z1,z2);
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
 
//-- ������� ������������ ��������� �� ������, ������� ASCII - ���  --

void Keyboard( unsigned char key, int x, int y )
{ 
#define ESCAPE '\033' 
 
if( key == ESCAPE ) exit(0);
         
switch(key)
{
	case'a':case'A':  // �������� ��� �������� ��������� ������
		{
			Index=1;
			break;
		}
	case'b':case'B':  // �������� � ��������� ��������� ������
		{
			Index=2;
			break;
		}

	case'c':case'C':  // ������������ � ��������� ��������� ������
		{	
			Index=3;
			break;
		}
}

glutPostRedisplay(); //������� ����������� ����

} 

//-- ������� ������������ ��������� �� ������,--- 
//-- �� ������� ASCII - ����  -------------------

void SpecialKey(int key, int x, int y )
{
	switch(key)
	{
		case GLUT_KEY_RIGHT: // ������� ������ (102)
		{
			angleY+=d_angle;		
			break;
		}
		case GLUT_KEY_LEFT:  // ������� ����� (100)
		{
			angleY-=d_angle;	
			break;
		}
		case GLUT_KEY_UP:	 // ������� ����� (101)
		{
			angleX-=d_angle;		
			break;
		}
		case GLUT_KEY_DOWN:  // ������� ���� (103)
		{
			angleX+=d_angle;	
			break;
		}
	}
glutPostRedisplay(); //������� ����������� ����
}


//--------- �������� --------------------------------------------

void Pyramid( GLfloat x1, GLfloat x2, GLfloat y1, GLfloat y2, 
	          GLfloat z1,GLfloat z2)
{		
//��������� ABCD: A(x1,y1,z1),B(x2,y1,z1),C(x2,y2,z1),D(x1,y2,z1)
//������� E(0,0,z2)

        glBegin ( GL_POLYGON );       //��������� 
          glVertex3f ( x2, y1, z1 );  //D
          glVertex3f ( x1, y1, z1 );  //A
          glVertex3f ( x1, y2, z1 );  //B
          glVertex3f ( x2, y2, z1 );	//C
        glEnd ();

		glBegin ( GL_POLYGON );       //EDC
   	      glVertex3f ( 0, 0, z2 );	  //E
          glVertex3f ( x2, y1, z1 );  //D
          glVertex3f ( x2, y2, z1 );  //C         
        glEnd ();

		glBegin ( GL_POLYGON );       //ECB
          glVertex3f ( 0, 0, z2 );	  //E
	      glVertex3f ( x2, y2, z1 );  //C  
          glVertex3f ( x1, y2, z1 );  //B					       
        glEnd ();

		glBegin ( GL_POLYGON );       //EBA
          glVertex3f ( 0, 0, z2 );	  //E
          glVertex3f ( x1, y2, z1 );  //B	
		  glVertex3f ( x1, y1, z1 );  //A
        glEnd ();

		glBegin ( GL_POLYGON );       //EAD
          glVertex3f ( 0, 0, z2 );	  //E
          glVertex3f ( x1, y1, z1 );  //A
          glVertex3f ( x2, y1, z1 );  //D

        glEnd ();	
        
}


//-----------------------------------------------------------------

void    Box ( GLfloat x1, GLfloat x2, GLfloat y1, GLfloat y2, 
	          GLfloat z1, GLfloat z2)
{				
        glBegin ( GL_POLYGON );      // front face 
          glVertex3f ( x1, y1, z2 );
          glVertex3f ( x2, y1, z2 );
          glVertex3f ( x2, y2, z2 );
          glVertex3f ( x1, y2, z2 );
        glEnd ();

        glBegin ( GL_POLYGON );       // back face
          glVertex3f ( x2, y1, z1 );
          glVertex3f ( x1, y1, z1 );
          glVertex3f ( x1, y2, z1 );
          glVertex3f ( x2, y2, z1 );
        glEnd ();

        glBegin ( GL_POLYGON );       // left face
          glVertex3f ( x1, y1, z1 );
          glVertex3f ( x1, y1, z2 );
          glVertex3f ( x1, y2, z2 );
          glVertex3f ( x1, y2, z1 );
        glEnd ();

        glBegin ( GL_POLYGON);        // right face
          glVertex3f ( x2, y1, z2 );
          glVertex3f ( x2, y1, z1 );
          glVertex3f ( x2, y2, z1 );
          glVertex3f ( x2, y2, z2 );
        glEnd ();

        glBegin ( GL_POLYGON );       // top face
          glVertex3f ( x1, y2, z2 );
          glVertex3f ( x2, y2, z2 );
          glVertex3f ( x2, y2, z1 );
          glVertex3f ( x1, y2, z1 );
        glEnd ();

        glBegin ( GL_POLYGON );       // bottom face
          glVertex3f ( x2, y1, z2 );
          glVertex3f ( x1, y1, z2 );
          glVertex3f ( x1, y1, z1 );
          glVertex3f ( x2, y1, z1 );
        glEnd ();
}

 
//================ main ============================================

int main(int argc, char *argv[]) 
{ 
//----- ������� ���������� GLUT ------------------------------------

    glutInit(&argc, argv); // ������������� ���������� GLUT
//������������ ����� RGB ��� ������ �����,��������� ����������,
//����������� ������������� ����� �������
    glutInitDisplayMode(GLUT_RGB|GLUT_SINGLE| GLUT_DEPTH ); 
// ���������� ������ �������� ���� ���� OpenGL �� ������ ��������		                                           
	glutInitWindowPosition  (x_win,y_win);     
//������ � ������ ���� OpenGL                                            
    glutInitWindowSize(Width, Height); 
//�������� ���� � ����������
	glutCreateWindow("������.    ��������� ����������");
//����������� ������� ��������� ������ OnDraw - ����������
//�������� ��� ������������� ������������ ���� (������ OnPaint � MFC) 
    glutDisplayFunc(OnDraw); 
//����������� ������� ��������� ������ OnSize - ����������	 
//�������� ��� ��������� �������� ���� (������ OnSize � MFC) 
    glutReshapeFunc(OnSize); 
//����������� ������� ��������� ������ Keyboard -����������	
//�������� ��� ��� ������ �������, ������� ASCII-��� 
    glutKeyboardFunc(Keyboard); 
//����������� ������� ��������� ������ SpesialKey -����������    
//�������� ��� ��� ������ �������, �� ������� ASCII-���� 
	glutSpecialFunc(SpecialKey);
//������ ������������ ����� ��������� ��������� Windows                              
    glutMainLoop(); 
//---------------------------------------------------------------------
	return 0;
} 
 
 