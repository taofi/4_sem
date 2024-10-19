#ifndef LIBPLANETS
#define LIBPLANETS 1
const double pi = 3.14159;


struct CSizeD
{
	double cx;
	double cy;
};
//-------------------------------------------------------------------------------
struct CRectD
{
	double left;
	double top;
	double right;
	double bottom;
	CRectD() { left = top = right = bottom = 0; };
	CRectD(double l, double t, double r, double b);
	void SetRectD(double l, double t, double r, double b);
	CSizeD SizeD();		// ���������� �������(������, ������) �������������� 
};
//-------------------------------------------------------------------------------

CMatrix CreateTranslate2D(double dx, double dy);
CMatrix CreateRotate2D(double fi);
CMatrix SpaceToWindow(CRectD& rs, CRect& rw);
void SetMyMode(CDC& dc, CRectD& RS, CRect& RW);



class CBlade
{
	CRect MainPoint;
	CRect FirstTop;
	CRect SecondTop;
	CRect FirstBootom;
	CRect SecondBootom;
	CRect FirstTop2;
	CRect SecondTop2;
	CRect FirstBootom2;
	CRect SecondBootom2;
	CRect EarthOrbit;
	CMatrix FTCoords;
	CMatrix STCoords;
	CMatrix FBCoords;
	CMatrix SBCoords;
	CMatrix FT2Coords;
	CMatrix ST2Coords;
	CMatrix FB2Coords;
	CMatrix SB2Coords;
	CRect RW;		   // ������������� � ����
	CRectD RS;		   // ������������� ������� � ���
	double wPoint;		//������� ��������
	double fiSB;
	double fiFB;
	double fiST;
	double fiFT;
	double fiSB2;
	double fiFB2;
	double fiST2;
	double fiFT2;

	double dt;		   // �������� �������������, ���.
public:
	CBlade();
	void DrawTriangle(CMatrix FTCoords, CMatrix STCoords, CDC& dc);
	void DrawTriangle2(CMatrix FTCoords, CMatrix STCoords, CDC& dc);
	void SetDT(double dtx) { dt = dtx; };	// ��������� ��������� �������������
	void SetNewCoords();					// ��������� ����� ���������� ������
	void GetRS(CRectD& RSX);				// ���������� ������� ������� � ������� ��
	CRect GetRW() { return RW; };			// ���������� ������� ������� � ����	
	void Draw(CDC& dc);						// ��������� ��� ���������������� ��������� ���������
};


#endif

