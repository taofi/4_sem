
// Prim_FIT.h : ������� ���� ��������� ��� ���������� Prim_FIT
//
#pragma once

#ifndef __AFXWIN_H__
	#error "�������� stdafx.h �� ��������� ����� ����� � PCH"
#endif

#include "resource.h"       // �������� �������


// CPrim_FITApp:
// � ���������� ������� ������ ��. Prim_FIT.cpp
//

class CPrim_FITApp : public CWinApp
{
public:
	CPrim_FITApp();


// ���������������
public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();

// ����������

public:
	afx_msg void OnAppAbout();
	DECLARE_MESSAGE_MAP()
};

extern CPrim_FITApp theApp;
