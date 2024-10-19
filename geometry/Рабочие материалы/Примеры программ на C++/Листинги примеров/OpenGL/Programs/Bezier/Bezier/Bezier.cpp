#include "Bezier.h"

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
GLint left,right,top,bottom,znear,zfar;                              
GLint Index=0;  // ��� ������ �������
float angleX=0;    // ���� ��� �������� ������������, ����
float angleY=0;    // ���� ��� �������� ������������, ����
GLint NumPoints=4;
GLfloat Points2D_1[4][3]={{3.0,1.0,0.0},   //(x1,y1,z1=0)
	                    {6.0,9.0,0.0},   //(x2,y2,z2=0)
						{12.0,-3.0,0.0}, //(x3,y3,z3=0)
						{19.0,3.0,0.0}};  //(x4,y4,z4=0)

GLfloat Points2D_2[4][3]={{-5.0,1.0,0.0},   //(x1,y1,z1=0)
	                    {-2.0,9.0,0.0},   //(x2,y2,z2=0)
						{2.0,9.0,0.0}, //(x3,y3,z3=0)
						{5.0,1.0,0.0}};  //(x4,y4,z4=0)
int NumCoords=3; //����� ��������� (x,y,z)
int NumPoints3D=4; // ����� ����� � ���� (�����) z=const
int NumSheets=3; // ����� ����� (������) z=const
float ***ppPoints; 


GLfloat Points3D[3][4][3]=	{
							  {
							    {-5.0,1.0,-4.0},  
								{-2.0,9.0,-4.0},  
								{2.0,9.0,-4.0},
								{5.0,1.0,-4.0}
							  }, 

								{
								  {-5.0,1.0,0.0},  
								  {-2.0,9.0,0.0},  
								  {2.0,9.0,0.0},
								  {5.0,1.0,0.0}
							    }, 

								{
								  {-5.0,1.0,4.0},  
								  {-2.0,9.0,4.0},  
								  {2.0,9.0,4.0},
								  {5.0,1.0,4.0}
							    } 

							};				


//------ ��� ������� ��������� ���� ������� �� �����----------- 
void OnDraw(void) 
{   
	switch(Index)
	{
		case 0:
		{
			glClearColor(1.0,1.0,1.0,0.0);
			glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT); 
			glEnable(GL_DEPTH_TEST);	
			break;
		}

		case 1:
		{
			//���� ���� � ���� 
			glClearColor(1.0,1.0,1.0,0.0); // - �����
            // �������� ����� ����� - ������ ������ ����	
			glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);  	
			glColor3ub(0,0,255);	// ���� ����� 
			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=0; right=22; bottom=-5; top=11;
			gluOrtho2D(left, right, bottom, top); 
			DrawPoints(Points2D_1,NumPoints); // ������ �����,����������� �������
			glColor3ub(255,0,0);	// ���� ����� 
			glLineWidth(3.0) ;	    // ������� �����
			Bezier2D_1(Points2D_1,NumPoints); // ������ �����
			break;
		}

		case 2:
		{
			//���� ���� � ���� 
			glClearColor(1.0,1.0,1.0,0.0); // - �����
            // �������� ����� ����� - ������ ������ ����	
			glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);  	
			glColor3ub(0,0,255);	// ���� ����� 
			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity(); 		
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-7; right=7; bottom=-2; top=11;
			gluOrtho2D(left, right, bottom, top); 
			DrawPoints(Points2D_2,NumPoints); // ������ �����,����������� �������
			glColor3ub(255,0,0);	// ���� ����� 
			glLineWidth(3.0) ;	    // ������� �����
			Bezier2D_2(Points2D_2,NumPoints); // ������ �����
			break;        
		}	
		case 3:
		{
			//���� ���� � ���� 
			glClearColor(1.0,1.0,1.0,0.0); // - �����
            // �������� ����� ����� - ������ ������ ����	
			glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);  	
			glColor3ub(0,0,255);	// ���� ����� 
			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity();
			angleX=10;
			angleY=10;
			glRotatef(angleX,1.0,0.0,0.0);
			glRotatef(angleY,0.0,1.0,0.0);
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-7; right=7; bottom=-2; top=11; znear=-10; zfar=10;
			glOrtho(left, right, bottom, top,znear,zfar); 
			CopyPoints();
			DrawPoints3D(ppPoints,NumPoints,NumSheets,1); //���� �����
			break;        
		}
		case 4:
		{
			//���� ���� � ���� 
			glClearColor(1.0,1.0,1.0,0.0); // - �����
            // �������� ����� ����� - ������ ������ ����	
			glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);  	
			glColor3ub(0,0,255);	// ���� ����� 
			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity();
			angleX=30;
			angleY=40;
			glRotatef(angleX,1.0,0.0,0.0);
			glRotatef(angleY,0.0,1.0,0.0);
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-7; right=7; bottom=-3; top=11; znear=-10; zfar=10;
			glOrtho(left, right, bottom, top,znear,zfar); 
			glLineWidth(2.0) ;	    // ������� �����

			// ��������� ����������� �����
    
			glMap2f(GL_MAP2_VERTEX_3,	// ��� ������������ ������
			0.0f,						// ������ ������� u
			10.0f,						// ������� ������� u
			3,							// ���������� ����� ������� � ������
			4,							// ����������� � ����������� u (�������)
			0.0f,						// ������ ������� v 
			10.0f,						// ������� ������� v
			12,							// ���������� ����� ������� � ������
			3,							// ����������� � ����������� v (�������)
			&Points3D[0][0][0]);		// ������ ����������� �����   **ppPoints);

    
			glEnable(GL_MAP2_VERTEX_3);  //����������� ������� ������
       
			glMapGrid2f(10,0.0f,10.0f,10,0.0f,10.0f); //������������ ����� - 10 ����� �� 0 �� 10
		
			glEvalMesh2(GL_LINE,0,10,0,10);//� ������� ����� ����������� �����

			glColor3ub(255,0,0);	// ����  
			CopyPoints();
			DrawPoints3D(ppPoints,NumPoints,NumSheets,1);
			break;        
		}
		case 5:
		{
			//���� ���� � ���� 
			glClearColor(1.0,1.0,1.0,0.0); // - �����
            // �������� ����� ����� - ������ ������ ����	
			glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); 
			glColor3ub(165,42,42);	// ���� ����� 
			InitLight(); //��������� �����
			glMatrixMode(GL_MODELVIEW); // ������� �������
			glLoadIdentity();
			angleX=30;
			angleY=30;
			glRotatef(angleX,1.0,0.0,0.0);
			glRotatef(angleY,0.0,1.0,0.0);
			glMatrixMode(GL_PROJECTION); // ��������������� �������� 
			glLoadIdentity(); 
			left=-7; right=7; bottom=-3; top=11; znear=-10; zfar=10;
			glOrtho(left, right, bottom, top,znear,zfar); 
			glLineWidth(2.0) ;	    // ������� �����

			// ��������� ����������� �����
    
			glMap2f(GL_MAP2_VERTEX_3,	// ��� ������������ ������
			0.0f,						// ������ ������� u
			10.0f,						// ������� ������� u
			3,							// ���������� ����� ������� � ������
			4,							// ����������� � ����������� u (�������)
			0.0f,						// ������ ������� v 
			10.0f,						// ������� ������� v
			12,							// ���������� ����� ������� � ������
			3,							// ����������� � ����������� v (�������)
			&Points3D[0][0][0]);		// ������ ����������� �����   
  
			glEnable(GL_MAP2_VERTEX_3);  //����������� ������� ������
       
			glMapGrid2f(10,0.0f,10.0f,10,0.0f,10.0f); //������������ ����� - 10 ����� �� 0 �� 10
		
			glEvalMesh2(GL_FILL,0,10,0,10);//� ������� ����� ����������� �����
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


//===========================  Bezier2D =================================

void DrawPoints(GLfloat Points[][3],GLint NumPoints)
// Points - ������� �������� NumPoints x 3
// NumPoints - ����� �����,������ �� ������� ���� 3 ���������� (x,y,z)
{
	glPointSize(5.0);
	glBegin(GL_POINTS);
		for(int i = 0; i < NumPoints; i++) glVertex2fv(Points[i]);
	glEnd();

	glLineWidth(1.0) ;	    // ������� �����
	glBegin(GL_LINE_STRIP);
		for(int i = 0; i < NumPoints; i++) glVertex2fv(Points[i]);
	glEnd();

    }



//--------- Bezier2D_1 --------------------------------------------
void  Bezier2D_1(GLfloat Points[][3],GLint NumPoints)
{        
    glMap1f(GL_MAP1_VERTEX_3,	// ��� ������������ ������
    0.0f,						// ������ ������� ��������� u
    100.0f,						// ������� ������� ��������� u
    3,							// ���������� ����� ������� � ������
    NumPoints,					// ����� ����������� �����
    &Points[0][0]);		    	// ������ ����������� �����

    glEnable(GL_MAP1_VERTEX_3); // ����������� ������� ������
	glBegin(GL_LINE_STRIP);     // ����� ����������� �������
		for(int i = 0; i <= 100; i++)
			{
				glEvalCoord1f((GLfloat) i); // ����������� ������ � ���� �����
            }
    glEnd();
}
//--------- Bezier2D_2 --------------------------------------------
void  Bezier2D_2(GLfloat Points[][3],GLint NumPoints)
{        
    glMap1f(GL_MAP1_VERTEX_3,	// ��� ������������ ������
    0.0f,						// ������ ������� u
    100.0f,						// ������� ������� u
    3,							// ���������� ����� ������� � ������
    NumPoints,					// ����� ����������� �����
    &Points[0][0]);			    // ������ ����������� �����

	glEnable(GL_MAP1_VERTEX_3); // ����������� ������� ������

    glMapGrid1d(100,0.0,100.0); // ������������ �����: 100 ����� - �� 0 �� 100
	glEvalMesh1(GL_LINE,1,100); // � ������� ����� ����������� �����
}

//===========================  Bezier3D =====================================

void DrawPoints3D(float ***Points,int NumPoints,int NumSheets,int k)
//NumPoints - ����� ����� � ���� (�����) z=const
//NumSheets - ����� ����� (������) z=const
//����� ������ ���� ����� ��� ���������� (x,y,z) - NumCoords=3
//��� k=0 ������������ ������ �����, � ��� k=1 - ����� � �����
    {
	
    glPointSize(5.0f);
	for(int i = 0; i < NumSheets; i++)//�� ����� ����� 
		{
			glBegin(GL_POINTS);
				for(int j = 0; j < NumPoints; j++) //�� ����� ����� � ����
					glVertex3fv(Points[i][j]);	
			glEnd();
		}


//����� � ���
/*
    glBegin(GL_POINTS);
    for(int i = 0; i < NumSheets; i++) //�� ����� ����� 
			for(int j = 0; j < NumPoints; j++) //�� ����� ����� � ����
				glVertex3fv(Points[i][j]);
	glEnd();
*/

	if(k!=0)
	{
//����� � ���� ��������� ������� 	
		glLineWidth(1.0) ;	    // ������� �����
		for(int i = 0; i < NumSheets; i++)//�� ����� ����� 
		{
			glBegin(GL_LINE_STRIP);
				for(int j = 0; j < NumPoints; j++) //�� ����� ����� � ����
					glVertex3fv(Points[i][j]);	
			glEnd();
		}
	}
    
    }
//============================ Init ===================================
void InitLight()
	{
	GLfloat  ambientLight[] = { 0.3f, 0.3f, 0.3f, 1.0f };
	GLfloat  diffuseLight[] = { 0.7f, 0.7f, 0.7f, 1.0f };
	GLfloat	 lightPos[] = { 20.0f, 0.0f, 0.0f, 0.0f };
	glEnable(GL_LIGHTING);

	// ������������� ��������  �������� ����� 0
	glLightfv(GL_LIGHT0,GL_AMBIENT,ambientLight);
	glLightfv(GL_LIGHT0,GL_DIFFUSE,diffuseLight);

	// �������� �������� ����� 0
	glLightfv(GL_LIGHT0,GL_POSITION,lightPos);
	glEnable(GL_LIGHT0);

	glEnable(GL_COLOR_MATERIAL);
	
	// ��������� ������� ���������
	glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);

	// �������������� ��������� �������� 
	glEnable(GL_AUTO_NORMAL);
	}


//----------------- CopyPoints()----------------------------------------------
void CopyPoints()
{
	for(int i=0;i<NumSheets;i++)
		for(int j=0;j<NumPoints3D; j++)
			for(int k=0;k<NumCoords; k++) ppPoints[i][j][k]=Points3D[i][j][k];
}


//================ main ==================================================
int main(int argc, char *argv[]) 
{ 
//----- ������� ���������� GLUT ------------------------------------------
 glutInit(&argc, argv); // ������������� ���������� GLUT
 glutInitDisplayMode(GLUT_RGB|GLUT_SINGLE); //������������ ����� RGB ��� 
	                                          //������ ����� � ��������� ����������
	glutInitWindowPosition  (x_win,y_win);    // ���������� ������ �������� ���� 
	                                          //���� OpenGL �� ������ ��������
  glutInitWindowSize(Width, Height);          //������ � ������ ���� OpenGL 
	glutCreateWindow("������ ����� 2D"); //�������� ���� � ����������
  glutDisplayFunc(OnDraw); // ����������� ������� ��������� ������ OnDraw - ����������
	                         // �������� ��� ������������� ������������ ���� (������ OnPaint � MFC) 
  glutReshapeFunc(OnSize);   // ����������� ������� ��������� ������ OnSize - ����������
	                         // �������� ��� ��������� �������� ���� (������ OnSize � MFC) 
  //-------������� ���� -------------------------
	glutCreateMenu(Figure);
		glutAddMenuEntry("Bezier2D_1",1);
		glutAddMenuEntry("Bezier2D_2",2);
		glutAddMenuEntry("Points3D",3);
		glutAddMenuEntry("Bezier3D",4);
		glutAddMenuEntry("Bezier3D_Light",5);
		glutAddMenuEntry("��������",0);
		glutAttachMenu(GLUT_RIGHT_BUTTON);
//-------------------------------------------------
// ����������� ������� ���������� ������ (����������� NumSheets_X_NumPoints3D_X_NumCoords)

ppPoints=new float **[NumSheets]; //dim1
for(int i=0;i<NumSheets;i++)
{
	ppPoints[i]=new float *[NumPoints3D]; //dim2
	for(int j=0;j<NumPoints3D;j++) ppPoints[i][j]=new float[NumCoords];//dim3
}
//Init();
  glutMainLoop(); //������ ������������ ����� ��������� ��������� Windows

//������� ���������� ������������ �����
for(int i=0;i<NumSheets;i++)
{
	for (int j = 0; j < NumPoints3D; j++) delete[]ppPoints[i][j];
}
for (int i = 0; i < NumSheets; i++) delete[]ppPoints[i];
delete[] ppPoints;

return 0;
} 


//�������� � ����������� ���������� ������� 
/*
int ***ppArr;
ppArr = new int**[dim1];
for (i = 0; i < dim1; i++) ppArr[i] = new int*[dim2];
for (i = 0; i < dim1; i++)
{
 for (j = 0; j < dim2; j++) ppArr[i][j] = new int[dim3];
}
ppArr[1][2][3] = 750; cout << ppArr[1][2][3] << endl; fdArr(ppArr,1,2,3);

for (i = 0; i < dim1; i++)
{
 for (j = 0; j < dim2; j++) delete[]ppArr[i][j];
}
for (i = 0; i < dim1; i++) delete[]ppArr[i];
delete[] ppArr;
}
*/
 