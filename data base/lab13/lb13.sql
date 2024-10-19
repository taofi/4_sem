--ex1
CREATE PROCEDURE P������
AS 
BEGIN
    DECLARE @k INT = (SELECT COUNT(*) FROM ������);
    SELECT ID_�������, ��������_����������, ��������_�����������, ��������_����������, ���� FROM ������;
    RETURN @k;
END;
go
DECLARE @k INT = 0;
EXEC @k = P������;
PRINT '���������� ��������: ' + CAST(@k AS VARCHAR(3));


--ex2
go
ALTER PROCEDURE P������ @p nvarchar(30) = NULL, @c int OUTPUT
AS 
BEGIN
    DECLARE @k INT = (SELECT COUNT(*) FROM ������);
    PRINT '���������: @p= ' + @p + ', @c= ' + CAST(@c AS varchar(3))
    SELECT ID_�������, ��������_����������, ��������_�����������, ��������_����������, ���� FROM ������
    WHERE ��������_����������� = @p;
    SET @c = @@ROWCOUNT
    RETURN @k;
END;
go


DECLARE @k INT = 0, @r INT = 0, @p NVARCHAR(30) = '��� ��������';
EXEC @k = P������ @p, @r OUTPUT;
PRINT '����� ���������� �����: ' + CAST(@k AS VARCHAR(3));
PRINT '���������� �������� ��� ����������� "' + @p + '": ' + CAST(@r AS VARCHAR(3));
drop procedure IF EXISTS  P������

--ex3
DROP TABLE IF EXISTS #������;
go
CREATE TABLE #������(
    ID_������� INT PRIMARY KEY,
    ��������_���������� NVARCHAR(40),
    ��������_����������� NVARCHAR(30),
    ��������_���������� REAL,
    ���� DATE
);
go
ALTER PROCEDURE P������ @��������_����������� NVARCHAR(30)
AS BEGIN
    SELECT * FROM ������ WHERE ��������_����������� = @��������_�����������;
END;

INSERT INTO #������ 
EXEC P������ @��������_����������� = '��� ��������';

SELECT * FROM #������;

--ex4
go

DROP PROCEDURE IF EXISTS PInsertContactPerson;
go

CREATE PROCEDURE PInsertContactPerson 
    @id int, 
    @������� nvarchar(30), 
    @��� nvarchar(30), 
    @�������� nvarchar(30), 
    @������� nvarchar(30)
AS 
BEGIN TRY
    INSERT INTO ����������_���� ([ID_�����������_����], �������, ���, ��������, �������)
    VALUES (@id, @�������, @���, @��������, @�������)
    RETURN 1; 
END TRY
BEGIN CATCH
    PRINT '����� ������: ' + CAST(ERROR_NUMBER() AS varchar(6));	
    PRINT '���������: ' + ERROR_MESSAGE();
    PRINT '�������: ' + CAST(ERROR_SEVERITY() AS varchar(6));
    PRINT '�����: ' + CAST(ERROR_STATE() AS varchar(8));
    PRINT '����� ������: ' + CAST(ERROR_LINE() AS varchar(8));
    IF ERROR_PROCEDURE() IS NOT NULL   
        PRINT '��� ���������: ' + ERROR_PROCEDURE();
    RETURN -1; 
END CATCH;
go
DECLARE @rc INT, @id int = 5; 
EXEC @rc = PInsertContactPerson @id= @id, @������� = '������', @��� = '����', @�������� = '��������', @������� = '1234567890';
PRINT '�����: ' + CAST(@rc AS VARCHAR(3));

SELECT * FROM ����������_���� where [ID_�����������_����] = @id;

--ex5
DROP PROCEDURE IF EXISTS REPORT_ANALYSIS;
go
CREATE PROCEDURE REPORT_ANALYSIS @p NVARCHAR(30)
AS
DECLARE @rc INT = 0;
BEGIN TRY
    IF NOT EXISTS (SELECT ID_������� FROM ������ WHERE ��������_����������� = @p)
        RAISERROR('��� ������ ��� �����������', 11, 1);
    DECLARE @list NVARCHAR(MAX) = '', @name NVARCHAR(40);

    DECLARE indicators CURSOR FOR
        SELECT ��������_���������� FROM ������ WHERE ��������_����������� = @p;

    OPEN indicators;
    FETCH NEXT FROM indicators INTO @name;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @list = RTRIM(@list) + @name + ', ';
        SET @rc += 1;
        FETCH NEXT FROM indicators INTO @name;
    END;

    PRINT '����������� ' + RTRIM(@p) + ':';
    PRINT RTRIM(@list);

    CLOSE indicators;
    DEALLOCATE indicators;
    RETURN @rc;
END TRY
BEGIN CATCH
    PRINT '����� ������: ' + CAST(ERROR_NUMBER() AS VARCHAR(6));
    PRINT '���������: ' + ERROR_MESSAGE();
    PRINT '�������: ' + CAST(ERROR_SEVERITY() AS VARCHAR(6));
    PRINT '�����: ' + CAST(ERROR_STATE() AS VARCHAR(8));
    PRINT '����� ������: ' + CAST(ERROR_LINE() AS VARCHAR(8));
    IF ERROR_PROCEDURE() IS NOT NULL
        PRINT '��� ���������: ' + ERROR_PROCEDURE();
    RETURN @rc;
END CATCH;
GO

DECLARE @rc INT;
EXEC @rc = REPORT_ANALYSIS '��� ����';
PRINT '���������� �����������: ' + CAST(@rc AS VARCHAR);


--ex6

DROP PROCEDURE IF EXISTS PIndicatorAnalysisInsert;
go
CREATE PROCEDURE PIndicatorAnalysisInsert
@indicatorName nvarchar(40), @importance real,
@enterpriseName nvarchar(30), @indicatorValue real, @date date, @id int
AS BEGIN TRY
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    BEGIN TRAN 
        INSERT INTO ���������� (��������_����������, ��������_����������) VALUES (@indicatorName, @importance);
        INSERT INTO ������ (ID_�������, ��������_����������, ��������_�����������, ��������_����������, ����)
        VALUES (@id, @indicatorName, @enterpriseName, @indicatorValue, @date);
    COMMIT TRAN
END TRY
BEGIN CATCH
    PRINT '�����:  ' + CAST(ERROR_NUMBER() AS varchar);
    PRINT '�������: ' + CAST(ERROR_SEVERITY() AS varchar);
    PRINT '���������:   ' + CAST(ERROR_MESSAGE() AS varchar);
    IF @@TRANCOUNT > 0 
        ROLLBACK TRAN; 
    RETURN -1;
END CATCH
go


DECLARE @rc INT;
EXEC @rc = PIndicatorAnalysisInsert @indicatorName = '�������������', @importance = 0.9,
									@enterpriseName = '��� ����',
									@indicatorValue = 75.5, @date = '2021-06-30', @id = 10;
PRINT '���������� �����������: ' + CAST(@rc AS VARCHAR);


go
SELECT * FROM ����������;
SELECT * FROM ������;
