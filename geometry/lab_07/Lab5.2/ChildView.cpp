#include "stdafx.h"
#include "CMatrix.h"
#include "LibGraph.h"
#include "CPyramid.h"
#include "Lab2.h"
#include "ChildView.h"
#include <fstream>
#include <string>
#include <iostream>

using namespace std;

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CChildView

CChildView::CChildView()
{
	Mode = 0;
	Viewport.resize(3);
}

CChildView::~CChildView()
{
}

BEGIN_MESSAGE_MAP(CChildView, CWnd)
	ON_WM_PAINT()
	ON_COMMAND(ID_PYRAMID_DRAW, &CChildView::OnPyramidDrawxray)
	ON_COMMAND(ID_PYRAMID_DRAWXRAY, &CChildView::OnPyramidDraw)
	ON_WM_KEYDOWN()
	ON_WM_SIZE()
	ON_COMMAND(ID_32773, &CChildView::CurrentCameraPosition)
	ON_COMMAND(ID_32774, &CChildView::SetDefaultCameraPosition)
END_MESSAGE_MAP()

// обработчики сообщений CChildView

BOOL CChildView::PreCreateWindow(CREATESTRUCT& cs)
{
	if (!CWnd::PreCreateWindow(cs))
		return FALSE;

	cs.dwExStyle |= WS_EX_CLIENTEDGE;
	cs.style &= ~WS_BORDER;
	cs.lpszClass = AfxRegisterWndClass(CS_HREDRAW | CS_VREDRAW | CS_DBLCLKS,
		::LoadCursor(NULL, IDC_ARROW), reinterpret_cast<HBRUSH>(COLOR_WINDOW + 1), NULL);

	return TRUE;
}

void CChildView::OnPaint()
{
	CPaintDC dc(this);

	if (Mode == 1)	// Прозрачная
	{
		Pyramid.draw(dc, Viewport, RectWindow);
	}
	if (Mode == 2)	// Непрозрачная
	{
		Pyramid.drawXray(dc, Viewport, RectWindow);
	}
}

void CChildView::OnPyramidDraw()
{
	Viewport(0) = 10;//расстояние до камеры
	Viewport(1) = 315;// угол до линии обзора камеры по Х
	Viewport(2) = 45;// угол до линии обзора до камеры по У

	Mode = 1;
	Invalidate();
}

void CChildView::OnPyramidDrawxray()
{
	Viewport(0) = 10;	// расстояние до камеры
	Viewport(1) = 315;	// угол до линии обзора камеры по Х
	Viewport(2) = 45;	// угол до линии обзора до камеры по У

	Mode = 2;
	Invalidate();
}

void CChildView::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags)
{
	return;
	if ((Mode == 1) || (Mode == 2))
	{
		double d;
		switch (nChar)
		{
		case VK_UP:	// Стрелка вверх
			d = Viewport(2) - 5;
			if (d >= -180)
				Viewport(2) = d;
			else
				Viewport(2) = d + 360;
			break;

		case VK_DOWN:	// Стрелка вниз
			d = Viewport(2) + 5;
			if (d <= 180)
				Viewport(2) = d;
			else
				Viewport(2) = d - 360;
			break;

		case VK_LEFT:	// Стрелка влево
			d = Viewport(1) - 5;
			if (d >= -180)
				Viewport(1) = d;
			else
				Viewport(1) = d + 360;
			break;

		case VK_RIGHT:	// Стрелка вправо
			d = Viewport(1) + 5;
			if (d <= 180)
				Viewport(1) = d;
			else
				Viewport(1) = d - 360;
			break;
		}
		Invalidate();
	}
	CWnd::OnKeyDown(nChar, nRepCnt, nFlags);
}

void CChildView::OnSize(UINT nType, int cx, int cy)// изменяет фигуру при изменении размеров окна
{
	CWnd::OnSize(nType, cx, cy);
	RectWindow.SetRect(100, 100, cx - 100, cy - 50);
}

void CChildView::CurrentCameraPosition()
{
	std::string line;

	int r = 0;
	int fi = 0;
	int teta = 0;

	std::ifstream in("D:\\4_sem\\geometry\\lab_07\\Lab5.2\\x64\\Debug\\camera.txt");

	if (in.is_open())
	{
		std::getline(in, line);
		r = stoi(line);

		std::getline(in, line);
		fi = stoi(line);

		std::getline(in, line);
		teta = stoi(line);
	}
	in.close();

	Viewport(0) = r;
	Viewport(1) = fi;
	Viewport(2) = teta;

	Invalidate();
}


void CChildView::SetDefaultCameraPosition()
{
	Viewport(0) = 10;//расстояние до камеры
	Viewport(1) = 315;// угол до линии обзора камеры по Х
	Viewport(2) = 45;// угол до линии обзора до камеры по У

	Invalidate();
}
