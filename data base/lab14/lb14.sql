--ex1
use VOR_MyBase
go
DROP FUNCTION IF EXISTS COUNT_CONTACTS;

GO
CREATE FUNCTION COUNT_CONTACTS(@lastname NVARCHAR(30)) RETURNS INT
AS BEGIN 
    DECLARE @ret INT = 0;
    SET @ret = (SELECT COUNT(ID_Контактного_лица) FROM Контактное_лицо 
                WHERE Фамилия = @lastname);
    RETURN @ret;
END;
go

DECLARE @lastname NVARCHAR(30) = 'Иванов';
DECLARE @f_result INT = dbo.COUNT_CONTACTS(@lastname);
PRINT 'Количество контактных лиц с фамилией ' + RTRIM(@lastname) + ': ' + CAST(@f_result AS VARCHAR);
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
        SELECT COUNT(ID_Контактного_лица) 
        FROM Контактное_лицо 
        WHERE Фамилия = @lastname
        AND Имя = @prof
    );
    RETURN @ret;
END;
GO

DECLARE @lastname NVARCHAR(30) = 'Макаров';
DECLARE @name NVARCHAR(30) = 'Максим';

DECLARE @f_result INT = dbo.COUNT_CONTACTS(@lastname, @name);
PRINT 'Количество контактных лиц с фамилией ' + RTRIM(@lastname) + ' '  + RTRIM(@name) + ': ' + CAST(@f_result AS VARCHAR);

--ex2
go
DROP FUNCTION IF EXISTS FAnalysis;

GO
CREATE FUNCTION FAnalysis(@p NVARCHAR(30)) RETURNS NVARCHAR(MAX)
AS BEGIN
    DECLARE Analysis CURSOR LOCAL FOR 
        SELECT [Название_показателя] FROM [Анализ] WHERE [Анализ].Название_предприятия = @p;
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

    SET @indicators_list = 'Показатели: ' + @indicators_list;
    RETURN @indicators_list;
END;
go

SELECT [Название_предприятия] AS 'Предприятие', dbo.FAnalysis([Название_предприятия]) AS 'Показатели предприятия' FROM [Анализ];

--ex3
go
DROP FUNCTION IF EXISTS FAnalysisPulpit;

GO
CREATE FUNCTION FAnalysisPulpit(@enterpriseName NVARCHAR(30), @indicatorName NVARCHAR(40)) RETURNS TABLE
AS RETURN 
    SELECT Анализ.Название_предприятия, Показатель.Название_показателя FROM
        Показатель LEFT OUTER JOIN Анализ
        ON Показатель.Название_показателя = Анализ.Название_показателя
        WHERE Анализ.Название_предприятия = ISNULL(@enterpriseName, Анализ.Название_предприятия)
        AND Показатель.Название_показателя = ISNULL(@indicatorName, Показатель.Название_показателя);

go
SELECT * FROM dbo.FAnalysisPulpit(NULL, NULL);
SELECT * FROM dbo.FAnalysisPulpit('оао рыба', NULL);
SELECT * FROM dbo.FAnalysisPulpit(NULL, 'Убытки');
SELECT * FROM dbo.FAnalysisPulpit('оао рыба', 'Убытки');

--ex4
go
DROP FUNCTION IF EXISTS FContactCount;

GO
CREATE FUNCTION FContactCount (@enterpriseName VARCHAR(30) = NULL) RETURNS INT
AS BEGIN
    DECLARE @result INT = 0;
    SET @result = (SELECT COUNT(DISTINCT Предприятие.Название_предприятия)
                   FROM Предприятие
                   INNER JOIN Анализ
                   ON Предприятие.Название_предприятия = Анализ.Название_предприятия
                   WHERE Анализ.Название_предприятия = ISNULL(@enterpriseName, Анализ.Название_предприятия));
    RETURN @result;
END;

go
SELECT Название_предприятия, dbo.FContactCount(Название_предприятия) 'Количество' FROM Анализ;
SELECT dbo.FContactCount(NULL) 'Всего предприятий';


--ex6
DROP FUNCTION IF EXISTS CountAnalyses;
go
CREATE FUNCTION dbo.CountAnalyses(@enterpriseName VARCHAR(50))
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(*) FROM Анализ WHERE Название_предприятия = @enterpriseName);
END;
GO

DROP FUNCTION IF EXISTS CountIndicators;
go
CREATE FUNCTION dbo.CountIndicators(@enterpriseName VARCHAR(50))
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(DISTINCT Название_показателя) FROM Анализ WHERE Название_предприятия = @enterpriseName);
END;
GO
DROP FUNCTION IF EXISTS CountContacts;

go
CREATE FUNCTION dbo.CountContacts(@enterpriseName VARCHAR(50))
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(DISTINCT ID_Контактного_лица) FROM Предприятие WHERE Название_предприятия = @enterpriseName);
END;
GO
DROP FUNCTION IF EXISTS EnterpriseReport;
go
CREATE FUNCTION dbo.EnterpriseReport(@c INT) 
RETURNS @fr TABLE
(
    [Название предприятия] VARCHAR(50), 
    [Количество анализов] INT, 
    [Количество показателей] INT, 
    [Количество контактных лиц] INT
)
AS 
BEGIN 
    DECLARE cc CURSOR STATIC FOR 
        SELECT Название_предприятия 
        FROM Анализ 
        WHERE Значение_показателя > @c;

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
