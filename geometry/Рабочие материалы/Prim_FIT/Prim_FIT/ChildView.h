
// ChildView.h : ��������� ������ CChildView
//


#pragma once


// ���� CChildView

class CChildView : public CWnd
{
// ��������
public:
	CChildView();
	int Index;

// ��������
public:

// ��������
public:

// ���������������
	protected:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);

// ����������
public:
	virtual ~CChildView();

	// ��������� ������� ����� ���������
protected:
	afx_msg void OnPaint();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnMymenuPoint1();
	afx_msg void OnMymenuPrint();
	afx_msg void OnMymenuEllipse();
	afx_msg void OnMymenuCircle();
	afx_msg void OnMymenuPicture();
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
};

