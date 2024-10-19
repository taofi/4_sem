
// ChildView.cpp : ���������� ������ CChildView
//

#include "stdafx.h"
#include "Prim_FIT.h"
#include "ChildView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CChildView

CChildView::CChildView()
{
	Index = 0;
}

CChildView::~CChildView()
{
}


BEGIN_MESSAGE_MAP(CChildView, CWnd)
	ON_WM_PAINT()
	ON_COMMAND(ID_MYMENU_POINT1, &CChildView::OnMymenuPoint1)
	ON_COMMAND(ID_MYMENU_PRINT, &CChildView::OnMymenuPrint)
	ON_COMMAND(ID_MYMENU_ELLIPSE, &CChildView::OnMymenuEllipse)
	ON_COMMAND(ID_MYMENU_CIRCLE, &CChildView::OnMymenuCircle)
	ON_COMMAND(ID_MYMENU_PICTURE, &CChildView::OnMymenuPicture)
	ON_WM_LBUTTONDOWN()
END_MESSAGE_MAP()



// ����������� ��������� CChildView

BOOL CChildView::PreCreateWindow(CREATESTRUCT& cs) 
{
	if (!CWnd::PreCreateWindow(cs))
		return FALSE;

	cs.dwExStyle |= WS_EX_CLIENTEDGE;
	cs.style &= ~WS_BORDER;
	cs.lpszClass = AfxRegisterWndClass(CS_HREDRAW|CS_VREDRAW|CS_DBLCLKS, 
		::LoadCursor(NULL, IDC_ARROW), reinterpret_cast<HBRUSH>(COLOR_WINDOW+1), NULL);

	return TRUE;
}

void CChildView::OnPaint() 
{
	CPaintDC dc(this); // �������� ���������� ��� ���������
	
	// TODO: �������� ��� ��������� ���������


	if (Index == 1) dc.TextOut(10, 10, _T("����� ������ � ���� Windows!"));
	if (Index == 2) dc.Ellipse(50,50,250,200);
	if (Index == 3) dc.Ellipse(100,100,200,200);

	
	// �� ��������� CWnd::OnPaint() ��� ��������� ���������
}



void CChildView::OnMymenuPoint1()    // ���������� ������ ���� "Point1"
{
	// TODO: �������� ���� ��� ����������� ������

	 AfxMessageBox("������!!!  � Point1");
	


}


void CChildView::OnMymenuPrint()
{
	// TODO: �������� ���� ��� ����������� ������
	Index = 1;
	this->Invalidate(1);
}


void CChildView::OnMymenuEllipse()
{
	// TODO: �������� ���� ��� ����������� ������
	Index = 2;
	this->Invalidate(1);
}


void CChildView::OnMymenuCircle()
{
	// TODO: �������� ���� ��� ����������� ������

	Index = 3;
	this->Invalidate();
}


void CChildView::OnMymenuPicture()
{
	// TODO: �������� ���� ��� ����������� ������
	Index = 0;
	CDC* pDC = GetDC();
	pDC->Ellipse(200, 200, 300, 500);
	
	
}


void CChildView::OnLButtonDown(UINT nFlags, CPoint point)
{
	// TODO: �������� ���� ��� ����������� ��������� ��� ����� ������������

	CWnd::OnLButtonDown(nFlags, point);
	AfxMessageBox("������ ����� ������� ����!");

}
