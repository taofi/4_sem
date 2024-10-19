--ex1
CREATE PROCEDURE PАнализ
AS 
BEGIN
    DECLARE @k INT = (SELECT COUNT(*) FROM Анализ);
    SELECT ID_Анализа, Название_показателя, Название_предприятия, Значение_показателя, Дата FROM Анализ;
    RETURN @k;
END;
go
DECLARE @k INT = 0;
EXEC @k = PАнализ;
PRINT 'количество анализов: ' + CAST(@k AS VARCHAR(3));


--ex2
go
ALTER PROCEDURE PАнализ @p nvarchar(30) = NULL, @c int OUTPUT
AS 
BEGIN
    DECLARE @k INT = (SELECT COUNT(*) FROM Анализ);
    PRINT 'параметры: @p= ' + @p + ', @c= ' + CAST(@c AS varchar(3))
    SELECT ID_Анализа, Название_показателя, Название_предприятия, Значение_показателя, Дата FROM Анализ
    WHERE Название_предприятия = @p;
    SET @c = @@ROWCOUNT
    RETURN @k;
END;
go


DECLARE @k INT = 0, @r INT = 0, @p NVARCHAR(30) = 'ооо стройбат';
EXEC @k = PАнализ @p, @r OUTPUT;
PRINT 'общее количество строк: ' + CAST(@k AS VARCHAR(3));
PRINT 'количество анализов для предприятия "' + @p + '": ' + CAST(@r AS VARCHAR(3));
drop procedure IF EXISTS  PАнализ

--ex3
DROP TABLE IF EXISTS #Анализ;
go
CREATE TABLE #Анализ(
    ID_Анализа INT PRIMARY KEY,
    Название_показателя NVARCHAR(40),
    Название_предприятия NVARCHAR(30),
    Значение_показателя REAL,
    Дата DATE
);
go
ALTER PROCEDURE PАнализ @Название_предприятия NVARCHAR(30)
AS BEGIN
    SELECT * FROM Анализ WHERE Название_предприятия = @Название_предприятия;
END;

INSERT INTO #Анализ 
EXEC PАнализ @Название_предприятия = 'ооо стройбат';

SELECT * FROM #Анализ;

--ex4
go

DROP PROCEDURE IF EXISTS PInsertContactPerson;
go

CREATE PROCEDURE PInsertContactPerson 
    @id int, 
    @Фамилия nvarchar(30), 
    @Имя nvarchar(30), 
    @Отчество nvarchar(30), 
    @Телефон nvarchar(30)
AS 
BEGIN TRY
    INSERT INTO Контактное_лицо ([ID_Контактного_лица], Фамилия, Имя, Отчество, Телефон)
    VALUES (@id, @Фамилия, @Имя, @Отчество, @Телефон)
    RETURN 1; 
END TRY
BEGIN CATCH
    PRINT 'номер ошибки: ' + CAST(ERROR_NUMBER() AS varchar(6));	
    PRINT 'сообщение: ' + ERROR_MESSAGE();
    PRINT 'уровень: ' + CAST(ERROR_SEVERITY() AS varchar(6));
    PRINT 'метка: ' + CAST(ERROR_STATE() AS varchar(8));
    PRINT 'номер строки: ' + CAST(ERROR_LINE() AS varchar(8));
    IF ERROR_PROCEDURE() IS NOT NULL   
        PRINT 'имя процедуры: ' + ERROR_PROCEDURE();
    RETURN -1; 
END CATCH;
go
DECLARE @rc INT, @id int = 5; 
EXEC @rc = PInsertContactPerson @id= @id, @Фамилия = 'Иванов', @Имя = 'Иван', @Отчество = 'Иванович', @Телефон = '1234567890';
PRINT 'ответ: ' + CAST(@rc AS VARCHAR(3));

SELECT * FROM Контактное_лицо where [ID_Контактного_лица] = @id;

--ex5
DROP PROCEDURE IF EXISTS REPORT_ANALYSIS;
go
CREATE PROCEDURE REPORT_ANALYSIS @p NVARCHAR(30)
AS
DECLARE @rc INT = 0;
BEGIN TRY
    IF NOT EXISTS (SELECT ID_Анализа FROM Анализ WHERE Название_предприятия = @p)
        RAISERROR('Нет данных для предприятия', 11, 1);
    DECLARE @list NVARCHAR(MAX) = '', @name NVARCHAR(40);

    DECLARE indicators CURSOR FOR
        SELECT Название_показателя FROM Анализ WHERE Название_предприятия = @p;

    OPEN indicators;
    FETCH NEXT FROM indicators INTO @name;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @list = RTRIM(@list) + @name + ', ';
        SET @rc += 1;
        FETCH NEXT FROM indicators INTO @name;
    END;

    PRINT 'Предприятие ' + RTRIM(@p) + ':';
    PRINT RTRIM(@list);

    CLOSE indicators;
    DEALLOCATE indicators;
    RETURN @rc;
END TRY
BEGIN CATCH
    PRINT 'номер ошибки: ' + CAST(ERROR_NUMBER() AS VARCHAR(6));
    PRINT 'сообщение: ' + ERROR_MESSAGE();
    PRINT 'уровень: ' + CAST(ERROR_SEVERITY() AS VARCHAR(6));
    PRINT 'метка: ' + CAST(ERROR_STATE() AS VARCHAR(8));
    PRINT 'номер строки: ' + CAST(ERROR_LINE() AS VARCHAR(8));
    IF ERROR_PROCEDURE() IS NOT NULL
        PRINT 'имя процедуры: ' + ERROR_PROCEDURE();
    RETURN @rc;
END CATCH;
GO

DECLARE @rc INT;
EXEC @rc = REPORT_ANALYSIS 'оао рыба';
PRINT 'Количество показателей: ' + CAST(@rc AS VARCHAR);


--ex6

DROP PROCEDURE IF EXISTS PIndicatorAnalysisInsert;
go
CREATE PROCEDURE PIndicatorAnalysisInsert
@indicatorName nvarchar(40), @importance real,
@enterpriseName nvarchar(30), @indicatorValue real, @date date, @id int
AS BEGIN TRY
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    BEGIN TRAN 
        INSERT INTO Показатель (Название_показателя, Важность_показателя) VALUES (@indicatorName, @importance);
        INSERT INTO Анализ (ID_Анализа, Название_показателя, Название_предприятия, Значение_показателя, Дата)
        VALUES (@id, @indicatorName, @enterpriseName, @indicatorValue, @date);
    COMMIT TRAN
END TRY
BEGIN CATCH
    PRINT 'номер:  ' + CAST(ERROR_NUMBER() AS varchar);
    PRINT 'уровень: ' + CAST(ERROR_SEVERITY() AS varchar);
    PRINT 'сообщение:   ' + CAST(ERROR_MESSAGE() AS varchar);
    IF @@TRANCOUNT > 0 
        ROLLBACK TRAN; 
    RETURN -1;
END CATCH
go


DECLARE @rc INT;
EXEC @rc = PIndicatorAnalysisInsert @indicatorName = 'Эффективность', @importance = 0.9,
									@enterpriseName = 'ооо банк',
									@indicatorValue = 75.5, @date = '2021-06-30', @id = 10;
PRINT 'Количество показателей: ' + CAST(@rc AS VARCHAR);


go
SELECT * FROM Показатель;
SELECT * FROM Анализ;
