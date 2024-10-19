// ChildView.cpp : implementation of the CChildView class
//

#include "stdafx.h"
#include "PrimMFC.h"
#include "ChildView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CChildView

CChildView::CChildView()
{
	Index=0;
	angle=0;
}

CChildView::~CChildView()
{
}

///////////// Triangle ///////////////////////////
void CChildView::Triangle()
{       
	glBegin(GL_LINE_LOOP); 
	  glVertex2f(-5.0,-5.0); 
	  glVertex2f(0.0,5.0); 
	  glVertex2f(5.0,-5.0); 
	glEnd(); 	
}
///////////////////////////////////////////////////

BEGIN_MESSAGE_MAP(CChildView, CWnd)
	ON_WM_PAINT()
	ON_COMMAND(ID_32771, &CChildView::OnTriangle)
	ON_WM_CREATE()
	ON_WM_DESTROY()
	ON_WM_SIZE()
	//ON_WM_ERASEBKGND()
END_MESSAGE_MAP()

// CChildView message handlers

BOOL CChildView::PreCreateWindow(CREATESTRUCT& cs) 
{
	if (!CWnd::PreCreateWindow(cs))
		return FALSE;

	cs.dwExStyle |= WS_EX_CLIENTEDGE;
	cs.style &= ~WS_BORDER;


//====== ��������� ���� �����, ������ OpenGL ===============================

	cs.style |= WS_CLIPSIBLINGS | WS_CLIPCHILDREN;

//==========================================================================

	cs.lpszClass = AfxRegisterWndClass(CS_HREDRAW|CS_VREDRAW|CS_DBLCLKS, 
		::LoadCursor(NULL, IDC_ARROW), reinterpret_cast<HBRUSH>(COLOR_WINDOW+1), NULL);

	return TRUE;
}

void CChildView::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
	
	if(Index==1)
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
		Triangle();  // �����������
		
		SwapBuffers(m_hdc); //������������ �������

	}
}


void CChildView::OnTriangle()
{
	Index=1;
	Invalidate();
}

int CChildView::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CWnd::OnCreate(lpCreateStruct) == -1)
		return -1;

	// TODO:  Add your specialized creation code here

PIXELFORMATDESCRIPTOR pfd =	// ��������� �������
	{
		sizeof(PIXELFORMATDESCRIPTOR),// ������ ���������
		1,							// ����� ������
		PFD_DRAW_TO_WINDOW |	// ��������� GDI
		PFD_SUPPORT_OPENGL |	// ��������� OpenGL
		PFD_DOUBLEBUFFER,		  // ������� �����������
		PFD_TYPE_RGBA,		  	// ������ RGBA, �� �������
		24, 					    	// ���������� ����������
		 						      	// � ������ ������ �����
		24,	0,						// ��� ���������� Red
		24,	0,						// ��� ���������� Green
		24,	0,						// ��� ���������� Blue
		24,	0,						// ��� ���������� Alpha
		0,						  	// ���������� ����������
									    // ������ Accumulation
		0,			 				// �� �� ��� ���������� Red
		0,			 				// ��� ���������� Green
		0,							// ��� ���������� Blue
		0,							// ��� ���������� Alpha
		32, 						// ������� Z-������
		0,							// ������� ������ Stencil
		0,							// ������� ������ Auxiliary
		0,				 			// ������ ������������
		0,							// ���������� ����������
		0,							// ������ ������������
		0,							// ���� ���������� �����
		0							  // ������ ������������
	};

	//====== �������� �������� ��������
	m_hdc = ::GetDC(GetSafeHwnd());

	//====== ������ ������� ��������� ����������� ������
	int iD = ChoosePixelFormat(m_hdc, &pfd);
	if ( !iD )
	{
		MessageBox("ChoosePixelFormat::Error");
		return -1;
	}

	//====== �������� ���������� ���� ������
	if ( !SetPixelFormat (m_hdc, iD, &pfd) )
	{
		MessageBox("SetPixelFormat::Error");
		return -1;
	}

	//====== �������� ������� �������� �������� OpenGL
	if ( !(m_hRC = wglCreateContext (m_hdc)))
	{
		MessageBox("wglCreateContext::Error");
		return -1;
	}

	//====== �������� ������� ��� � �������� ��������
	if ( !wglMakeCurrent (m_hdc, m_hRC))
	{
		MessageBox("wglMakeCurrent::Error");
		return -1;
	}

	return 0;
}

void CChildView::OnDestroy()
{
	CWnd::OnDestroy();

	// TODO: Add your message handler code here
	//====== ����������� ������� �� ������
	wglMakeCurrent(0, 0);

	//====== ������� ��������
	if (m_hRC)
	{
		wglDeleteContext(m_hRC);
		m_hRC = 0;
	}
}

void CChildView::OnSize(UINT nType, int cx, int cy)
{
	CWnd::OnSize(nType, cx, cy);

	// TODO: Add your message handler code here

	//====== ��������� �������������� ���������
	glViewport(0, 0, cx, cy);
}
