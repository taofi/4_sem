// ChildView.h : interface of the CChildView class
//


#pragma once


// CChildView window

class CChildView : public CWnd
{
// Construction
public:
	CChildView();

// Attributes ///////////////////////////////////////////////////
public:
	HGLRC		m_hRC;				// �������� OpenGL
	HDC			m_hdc; 		   	// �������� Windows
	int Index;
	GLint left,right,top,bottom; // ��� ����������� ������� ��������� �����������
                                 //������ ����� �������������� � ���
	float angle;    // ���� ��� �������� ������������, ����

// Operations ////////////////////////////////////////////////////
public:

// Overrides
	protected:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);

// Implementation
public:
	virtual ~CChildView();

	// Generated message map functions
protected:
	afx_msg void OnPaint();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnTriangle();

	void Triangle();	////////////////////////////////////////////////

	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnDestroy();
	afx_msg void OnSize(UINT nType, int cx, int cy);
	//afx_msg BOOL OnEraseBkgnd(CDC* pDC);
};

