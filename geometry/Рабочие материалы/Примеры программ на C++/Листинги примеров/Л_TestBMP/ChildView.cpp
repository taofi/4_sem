// ChildView.cpp : implementation of the CChildView class
//

#include "stdafx.h"
#include "TestBMP.h"
#include "ChildView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CChildView

CChildView::CChildView()
{
	Index=0;
}

CChildView::~CChildView()
{
}


BEGIN_MESSAGE_MAP(CChildView, CWnd)
	ON_WM_PAINT()
	ON_COMMAND(ID_FILE_LOADFILE, &CChildView::OnFileLoadfile)
	ON_COMMAND(ID_FILE_SAVEFILE, &CChildView::OnFileSavefile)
	ON_COMMAND(ID_FILE_CLEAR, &CChildView::OnFileClear)
	ON_COMMAND(ID_FILE_LOADPICT, &CChildView::OnFileLoadpict)
END_MESSAGE_MAP()



// CChildView message handlers

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
	CPaintDC dc(this); // device context for painting
	
	if(Index==1)	// ����������� ����� "FileBmp.bmp"
	{

		int k= ShowBitMap(this->m_hWnd,Bit,10,10);
		//Index=0;

	}

	if(Index==2)	// ����������� ����� "FileBmp.bmp"
	{

		int k= ShowBitMap(this->m_hWnd,Bit,10,10);
		//Index=0;

	}


	
	// TODO: Add your message handler code here
	
	// Do not call CWnd::OnPaint() for painting messages
}


void CChildView::OnFileLoadfile()	// �������� �����
{
	 Bit=(HBITMAP)LoadImage(NULL,"FileBmp.bmp",
				IMAGE_BITMAP,0,0,LR_LOADFROMFILE | LR_CREATEDIBSECTION);
    if(!Bit)MessageBox("FileBmp.bmp","��� ��������",0);
	Index=1;
	this->Invalidate();	
}


void CChildView::OnFileLoadpict()
{
	 Bit=(HBITMAP)LoadImage(NULL,"Elephant.bmp",
				IMAGE_BITMAP,0,0,LR_LOADFROMFILE | LR_CREATEDIBSECTION);
    if(!Bit)MessageBox("FileBmp.bmp","��� ��������",0);
	Index=2;
	this->Invalidate();	
	
}


void CChildView::OnFileSavefile()	// ������ ����������� � ����
{
	int k= ClientToBmp(this->m_hWnd,"Pict.bmp");

}

void CChildView::OnFileClear()
{
	Index=0;
	Invalidate();
}




///////////////////  �������  /////////////////////////////////////////////

int ShowBitMap(HWND hWnd,HBITMAP hBit,int x,int y)
//������� ���������� ������� � �������� ������� ����
//hWnd - ���������� ����, ���� ��������� �����������
//hBit - ���������� �������
//(x,y) - ���������� ������ �������� ���� ����������� � ���� ������
{
 BITMAP BitMap;
//� ��������� BitMap ����������� ��������� ��������
 GetObject(hBit,sizeof(BITMAP),&BitMap);
// �� �� ����� bmHeight � bmWidth �������� ������� ��� �����������
 int Height=BitMap.bmHeight;
 int Width=BitMap.bmWidth;
//�������� �������� �����������
 HDC hdc = GetDC(hWnd);
//������� �������� ������
 HDC hdcMem=CreateCompatibleDC(hdc);
//� ��������� �������� ������ ������� ���������� ������� �����
 HBITMAP OldBitmap=(HBITMAP)SelectObject(hdcMem,hBit);
///////////////////////////////////////////////////////////////////
//���� � �������� ������ ��������� ���� ������ 
//#include <windowsx.h>,�� ���������� hBit ����� �������� � ��������
// ��� ������ ����������:
//HBITMAP OldBitmap=SelectBitmap(hdcMem,hBit);
///////////////////////////////////////////////////////////////////
//�������� hdcMem ����� ������������ ��� ��������� ���������� GDI -
//����������� ����������� � ������ �������� ��������� �������� ��������� 
//�� ���������� � �������� ��������.
//� ����, � ������� ������ �������� ����������� hdc, �������� �����������
//��� ������ ������� �����������:
 BitBlt(hdc,x,y,Width,Height,hdcMem,0,0,SRCCOPY);	//PATCOPY
//����� ����������� ������������ ��������� ������ � �����������
 SelectObject(hdcMem,OldBitmap);
 //SelectBitmap(hdcMem,OldBitmap);
 ReleaseDC(hWnd,hdc);
 DeleteDC(hdcMem);
 return 0;
}

//======================================================================================


int ClientToBmp(HWND hWnd,char *Name)
//���������� ������� ������� ���� � ����� Name.bmp
//hWnd - ���������� ����, ������� ������� �������� �����������
//Name - ��� ����� ��� ����������
{
 BITMAPFILEHEADER    bmfHdr;
 BITMAPINFOHEADER bi;
 RECT r;
 int BitToPixel=16;			//������������� �������� ������� 16 ��� 
 GetClientRect(hWnd,&r);	//������ ������ ������� �������
 HDC hdc = GetDC(hWnd);
 HDC hdcMem=CreateCompatibleDC(hdc); 
//�������� ������� ����� BitMap �� ������� ������� ������� ����
//������� ����� ��������� �� ������ ��������� ���������� hdc, ������� 
//��� ������ ����������� DDB-������� (� �� DIB). ������ ������� ������ 
//������������ ������� WriteDIBC() 

 HBITMAP BitMap = CreateCompatibleBitmap(hdc, r.right,r.bottom);
 HBITMAP OldBitmap = (HBITMAP)SelectObject(hdcMem, BitMap);
 BitBlt(hdcMem, 0, 0, r.right, r.bottom, hdc, 0, 0, SRCCOPY);
 BitMap = (HBITMAP)SelectObject(hdcMem,OldBitmap);
 ZeroMemory(&bi,sizeof(BITMAPINFOHEADER));	//��� ������ ������� memset(), 
											//������� ��������� ��������� ������. 

    bi.biSize = sizeof(BITMAPINFOHEADER);
    bi.biWidth = r.right;
    bi.biHeight = r.bottom;
    bi.biPlanes = 1;
    bi.biBitCount = BitToPixel; //� ��������  ����� 16 ��� ���� �����������, ��� 24- ��� DIB 
//�� 8 ��� �� ������ �������� �� ����� - �� �������� ����� ��������� �������� �������

//��� ���������� ������� ����������� � ������ �� ����������� �������� 
//�.right * BitToPixel/8 ���� �� ������ �� ��������, �������� �������. ��� 
//���������� ����� ��������� � ������� GetDIBits() (��. MSDN). 
	bi.biSizeImage = (r.right * BitToPixel+31)/32*4 * r.bottom;

	DWORD dwWritten; //���������� ���������� ������
//��������� ����
	HANDLE fh = CreateFile(Name, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS,
            FILE_ATTRIBUTE_NORMAL | FILE_FLAG_SEQUENTIAL_SCAN, NULL);
    if (fh == INVALID_HANDLE_VALUE)     return 2;

    bmfHdr.bfType = ('M'<<8)|'B';  //��������� �������� ���������
    bmfHdr.bfSize = bi.biSizeImage + sizeof(bmfHdr)+bi.biSize; //������ �����
    bmfHdr.bfReserved1 = bmfHdr.bfReserved2 = 0;
    bmfHdr.bfOffBits = sizeof(bmfHdr) + bi.biSize; // �������� �� ������ ������
//������ ��������� � ����
    WriteFile(fh, (LPSTR)&bmfHdr, sizeof(bmfHdr), &dwWritten, NULL);
// ������ � ���� ������������ ���������  
	WriteFile(fh, (LPSTR)&bi, sizeof(BITMAPINFOHEADER), &dwWritten, NULL);
//�������� ����� � ������ ��� ����,����� ������� GetDIBits()��������� 
//���� ���� ����� � DIB-�������.
    char *lp=(char *) GlobalAlloc(GMEM_FIXED, bi.biSizeImage);
// �� ����� BitMap ������ � ������� �� bi.biHeight ������� ���������� � ������ lp 
//	�� ������� bi ( ������������� ������) 
	int err=GetDIBits(hdc, BitMap,0,(UINT)r.bottom, lp,(LPBITMAPINFO)&bi, DIB_RGB_COLORS); 
//������ ����������� �� ����				          
    WriteFile(fh, lp, bi.biSizeImage, &dwWritten, NULL);
//������������ ������ � �������� �����
    GlobalFree(GlobalHandle(lp));
	CloseHandle(fh);
	 ReleaseDC(hWnd,hdc);
     DeleteDC(hdcMem);		
    if (dwWritten == 0)        return 2; 
    return 0;
		}







