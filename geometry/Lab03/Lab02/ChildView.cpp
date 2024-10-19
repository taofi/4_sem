
// ChildView.cpp: реализация класса CChildView
//

#include "stdafx.h"
#include "Lab03.h"
#include "ChildView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CChildView

CChildView::CChildView()
{
}

CChildView::~CChildView()
{
}


BEGIN_MESSAGE_MAP(CChildView, CWnd)
	ON_WM_PAINT()
	ON_COMMAND(ID_TESTS_F1, &CChildView::OnTestsF1)
	ON_COMMAND(ID_TESTS_F2, &CChildView::OnTestsF2)
	ON_COMMAND(ID_TESTS_F12, &CChildView::OnTestsF12)
END_MESSAGE_MAP()



// Обработчики сообщений CChildView

BOOL CChildView::PreCreateWindow(CREATESTRUCT& cs)
{
	if (!CWnd::PreCreateWindow(cs))
		return FALSE;

	cs.dwExStyle |= WS_EX_CLIENTEDGE;
	cs.style &= ~WS_BORDER;
	cs.lpszClass = AfxRegisterWndClass(CS_HREDRAW | CS_VREDRAW | CS_DBLCLKS,
		::LoadCursor(nullptr, IDC_ARROW), reinterpret_cast<HBRUSH>(COLOR_WINDOW + 1), nullptr);

	return TRUE;
}

void CChildView::OnPaint()
{
	CPaintDC dc(this); // контекст устройства для рисования
	Graph.Draw(dc, 1, 1);
}

double CChildView::MyF1(double x)
{
	double y = sin(x) / x;
	return y;
}

double CChildView::MyF2(double x)
{
	double y = sqrt(abs(x))* sin(x);
	return y;
}

void CChildView::OnTestsF1()	// MM_TEXT
{
	Invalidate();
	CPaintDC dc(this);
	double xL = -3 * pi;
	double xH = -xL;
	double dx = pi / 36;		//шаг
	int N = (xH - xL) / dx;
	X.RedimMatrix(N + 1);	// Изменяет размер матрицы с уничтожением данных
	Y.RedimMatrix(N + 1);
	for (int i = 0; i <= N; i++)
	{
		X(i) = xL + i * dx;
		Y(i) = MyF1(X(i));
	}
	PenLine.Set(PS_SOLID, 1, RGB(255, 0, 0));
	PenAxis.Set(PS_SOLID, 2, RGB(0, 0, 255));
	RW.SetRect(200, 200, 600, 600);
	Graph.SetParams(X, Y, RW);
	Graph.SetPenLine(PenLine);
	Graph.SetPenAxis(PenAxis);
	Index = 1;
	this->Invalidate();
	//Graph.Draw(dc, 1, 1);
}


void CChildView::OnTestsF2()
{
	Invalidate();
	CPaintDC dc(this);
	double xL = -4 * pi;
	double xH = 4 * pi;
	double dx = pi / 36;
	int N = (xH - xL) / dx;
	X.RedimMatrix(N + 1);
	Y.RedimMatrix(N + 1);
	for (int i = 0; i <= N; i++)
	{
		X(i) = xL + i * dx;
		Y(i) = MyF2(X(i));
	}
	PenLine.Set(PS_DASH, 3, RGB(255, 0, 0));
	PenAxis.Set(PS_SOLID, 2, RGB(0, 0, 0));
	RW.SetRect(200, 200, 600, 600);
	Graph.SetParams(X, Y, RW);
	Graph.SetPenLine(PenLine);
	Graph.SetPenAxis(PenAxis);
	//Graph.Draw(dc, 1, 1);
	this->Invalidate();
}



void CChildView::OnTestsF12()
{
	//Invalidate();
	CPaintDC dc(this);
	X.RedimMatrix(9);
	Y.RedimMatrix(9);
	const byte radius = 10;
	const double dx = pi / 4;
	const double a = pi / 8;
	for (int i = 0; i < 9; i++) {
		X(i) = radius - radius * cos(dx * i) - 10;
		Y(i) = radius - radius * sin(dx * -i) - 10;
	}
	RW.SetRect(200, 200, 600, 600);
	PenLine.Set(PS_DOT, 3, RGB(255, 0, 0));
	PenAxis.Set(PS_SOLID, 2, RGB(0, 0, 255));
	Graph.SetParams(X, Y, RW);
	Graph.SetPenLine(PenLine);
	Graph.SetPenAxis(PenAxis);
	//this->Invalidate();
	//Graph.Draw(dc, 1, 1);
	CPen PenEllipse(PenLine.PenStyle, PenLine.PenWidth, PenLine.PenColor);
	dc.SelectObject(&PenEllipse);
	dc.SelectObject(GetStockObject(NULL_BRUSH));
	dc.Ellipse(RW.left, RW.top, RW.right, RW.bottom);
	
	this->Invalidate();
}