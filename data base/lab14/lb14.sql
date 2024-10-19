--ex1
use VOR_MyBase
go
DROP FUNCTION IF EXISTS COUNT_CONTACTS;

GO
CREATE FUNCTION COUNT_CONTACTS(@lastname NVARCHAR(30)) RETURNS INT
AS BEGIN 
    DECLARE @ret INT = 0;
    SET @ret = (SELECT COUNT(ID_�����������_����) FROM ����������_���� 
                WHERE ������� = @lastname);
    RETURN @ret;
END;
go

DECLARE @lastname NVARCHAR(30) = '������';
DECLARE @f_result INT = dbo.COUNT_CONTACTS(@lastname);
PRINT '���������� ���������� ��� � �������� ' + RTRIM(@lastname) + ': ' + CAST(@f_result AS VARCHAR);
GO
ALTER FUNCTION COUNT_CONTACTS(
    @lastname NVARCHAR(30),
    @prof VARCHAR(20)
) 
RETURNS INT
AS 
BEGIN 
    DECLARE @ret INT = 0;
    SET @ret = (
        SELECT COUNT(ID_�����������_����) 
        FROM ����������_���� 
        WHERE ������� = @lastname
        AND ��� = @prof
    );
    RETURN @ret;
END;
GO

DECLARE @lastname NVARCHAR(30) = '�������';
DECLARE @name NVARCHAR(30) = '������';

DECLARE @f_result INT = dbo.COUNT_CONTACTS(@lastname, @name);
PRINT '���������� ���������� ��� � �������� ' + RTRIM(@lastname) + ' '  + RTRIM(@name) + ': ' + CAST(@f_result AS VARCHAR);

--ex2
go
DROP FUNCTION IF EXISTS FAnalysis;

GO
CREATE FUNCTION FAnalysis(@p NVARCHAR(30)) RETURNS NVARCHAR(MAX)
AS BEGIN
    DECLARE Analysis CURSOR LOCAL FOR 
        SELECT [��������_����������] FROM [������] WHERE [������].��������_����������� = @p;
    DECLARE @indicator NVARCHAR(40), @indicators_list NVARCHAR(MAX) = '';

    OPEN Analysis;
    FETCH Analysis INTO @indicator;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @indicators_list = RTRIM(@indicator) + ', ' + @indicators_list;
        FETCH Analysis INTO @indicator;
    END;
    CLOSE Analysis;
    DEALLOCATE Analysis;

    SET @indicators_list = '����������: ' + @indicators_list;
    RETURN @indicators_list;
END;
go

SELECT [��������_�����������] AS '�����������', dbo.FAnalysis([��������_�����������]) AS '���������� �����������' FROM [������];

--ex3
go
DROP FUNCTION IF EXISTS FAnalysisPulpit;

GO
CREATE FUNCTION FAnalysisPulpit(@enterpriseName NVARCHAR(30), @indicatorName NVARCHAR(40)) RETURNS TABLE
AS RETURN 
    SELECT ������.��������_�����������, ����������.��������_���������� FROM
        ���������� LEFT OUTER JOIN ������
        ON ����������.��������_���������� = ������.��������_����������
        WHERE ������.��������_����������� = ISNULL(@enterpriseName, ������.��������_�����������)
        AND ����������.��������_���������� = ISNULL(@indicatorName, ����������.��������_����������);

go
SELECT * FROM dbo.FAnalysisPulpit(NULL, NULL);
SELECT * FROM dbo.FAnalysisPulpit('��� ����', NULL);
SELECT * FROM dbo.FAnalysisPulpit(NULL, '������');
SELECT * FROM dbo.FAnalysisPulpit('��� ����', '������');

--ex4
go
DROP FUNCTION IF EXISTS FContactCount;

GO
CREATE FUNCTION FContactCount (@enterpriseName VARCHAR(30) = NULL) RETURNS INT
AS BEGIN
    DECLARE @result INT = 0;
    SET @result = (SELECT COUNT(DISTINCT �����������.��������_�����������)
                   FROM �����������
                   INNER JOIN ������
                   ON �����������.��������_����������� = ������.��������_�����������
                   WHERE ������.��������_����������� = ISNULL(@enterpriseName, ������.��������_�����������));
    RETURN @result;
END;

go
SELECT ��������_�����������, dbo.FContactCount(��������_�����������) '����������' FROM ������;
SELECT dbo.FContactCount(NULL) '����� �����������';


--ex6
DROP FUNCTION IF EXISTS CountAnalyses;
go
CREATE FUNCTION dbo.CountAnalyses(@enterpriseName VARCHAR(50))
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(*) FROM ������ WHERE ��������_����������� = @enterpriseName);
END;
GO

DROP FUNCTION IF EXISTS CountIndicators;
go
CREATE FUNCTION dbo.CountIndicators(@enterpriseName VARCHAR(50))
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(DISTINCT ��������_����������) FROM ������ WHERE ��������_����������� = @enterpriseName);
END;
GO
DROP FUNCTION IF EXISTS CountContacts;

go
CREATE FUNCTION dbo.CountContacts(@enterpriseName VARCHAR(50))
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(DISTINCT ID_�����������_����) FROM ����������� WHERE ��������_����������� = @enterpriseName);
END;
GO
DROP FUNCTION IF EXISTS EnterpriseReport;
go
CREATE FUNCTION dbo.EnterpriseReport(@c INT) 
RETURNS @fr TABLE
(
    [�������� �����������] VARCHAR(50), 
    [���������� ��������] INT, 
    [���������� �����������] INT, 
    [���������� ���������� ���] INT
)
AS 
BEGIN 
    DECLARE cc CURSOR STATIC FOR 
        SELECT ��������_����������� 
        FROM ������ 
        WHERE ��������_���������� > @c;

    DECLARE @n VARCHAR(50);
    OPEN cc;  
    FETCH cc INTO @n;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT @fr VALUES
        ( 
            @n, 
            dbo.CountAnalyses(@n),
            dbo.CountIndicators(@n),
            dbo.CountContacts(@n)
        ); 
        FETCH cc INTO @n;  
    END;   
    CLOSE cc;
    DEALLOCATE cc;
    RETURN; 
END;
GO

SELECT * FROM dbo.EnterpriseReport(5);
