--ex1

DROP TABLE IF EXISTS TR_AUDIT;
go

CREATE TABLE TR_AUDIT
(
ID int identity,
STMT varchar(20) check (STMT in ('INS','DEL','UPD')),
TRNAME varchar(50),
CC varchar(800)
)

GO
DROP TRIGGER IF EXISTS TR_ContactPerson_INS;
go
CREATE TRIGGER TR_ContactPerson_INS ON Контактное_лицо
AFTER INSERT AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'INS', 'TR_ContactPerson_INS',
           'Контактное лицо: ' + RTRIM(i.ID_Контактного_лица) +
           '. Фамилия: ' + RTRIM(i.Фамилия) +
           '. Имя: ' + RTRIM(i.Имя) +
           '. Отчество: ' + RTRIM(i.Отчество) +
           '. Телефон: ' + RTRIM(i.Телефон)
    FROM INSERTED i;
END;
GO

INSERT INTO Контактное_лицо (ID_Контактного_лица, Фамилия, Имя, Отчество, Телефон)
VALUES (12, 'Иванов', 'Иван', 'Иванович', '1234567890');

SELECT * FROM TR_AUDIT;

go
--ex2
DROP TRIGGER IF EXISTS TR_ContactPerson_DEL;

GO
CREATE TRIGGER TR_ContactPerson_DEL ON Контактное_лицо
AFTER DELETE AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_ContactPerson_DEL',
           'Контактное лицо: ' + RTRIM(d.ID_Контактного_лица) +
           '. Фамилия: ' + RTRIM(d.Фамилия) +
           '. Имя: ' + RTRIM(d.Имя) +
           '. Отчество: ' + RTRIM(d.Отчество) +
           '. Телефон: ' + RTRIM(d.Телефон)
    FROM DELETED d;
END;
GO

DELETE FROM Контактное_лицо WHERE ID_Контактного_лица = 12;
SELECT * FROM TR_AUDIT;
--ex3
go
DROP TRIGGER IF EXISTS TR_ContactPerson_UPD;

GO
CREATE TRIGGER TR_ContactPerson_UPD ON Контактное_лицо
AFTER UPDATE AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'UPD', 'TR_ContactPerson_UPD',
           'Контактное лицо обновлено: ' + RTRIM(i.ID_Контактного_лица) +
           '. Фамилия: ' + RTRIM(i.Фамилия) +
           '. Имя: ' + RTRIM(i.Имя) +
           '. Отчество: ' + RTRIM(i.Отчество) +
           '. Телефон: ' + RTRIM(i.Телефон)
    FROM INSERTED i;
END;
GO

UPDATE Контактное_лицо SET Телефон = '9876543210' WHERE ID_Контактного_лица = 2;
SELECT * FROM TR_AUDIT;
--ex4
DROP TRIGGER IF EXISTS TR_ContactPerson;

GO
CREATE TRIGGER TR_ContactPerson ON Контактное_лицо
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    DECLARE @ins INT = (SELECT COUNT(*) FROM inserted),
            @del INT = (SELECT COUNT(*) FROM deleted);

    IF @ins > 0 AND @del = 0
    BEGIN
        PRINT 'Событие: INSERT';
        INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
        SELECT 'INS', 'TR_ContactPerson_INS',
               'Контактное лицо: ' + RTRIM(i.ID_Контактного_лица) +
               '. Фамилия: ' + RTRIM(i.Фамилия) +
               '. Имя: ' + RTRIM(i.Имя) +
               '. Отчество: ' + RTRIM(i.Отчество) +
               '. Телефон: ' + RTRIM(i.Телефон)
        FROM inserted i;
    END
    ELSE IF @ins = 0 AND @del > 0
    BEGIN
        PRINT 'Событие: DELETE';
        INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
        SELECT 'DEL', 'TR_ContactPerson_DEL',
               'Контактное лицо: ' + RTRIM(d.ID_Контактного_лица) +
               '. Фамилия: ' + RTRIM(d.Фамилия) +
               '. Имя: ' + RTRIM(d.Имя) +
               '. Отчество: ' + RTRIM(d.Отчество) +
               '. Телефон: ' + RTRIM(d.Телефон)
        FROM deleted d;
    END
    ELSE IF @ins > 0 AND @del > 0
    BEGIN
        PRINT 'Событие: UPDATE';
        INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
        SELECT 'UPD', 'TR_ContactPerson_UPD',
               'Контактное лицо обновлено: ' + RTRIM(i.ID_Контактного_лица) +
               '. Фамилия: ' + RTRIM(i.Фамилия) +
               '. Имя: ' + RTRIM(i.Имя) +
               '. Отчество: ' + RTRIM(i.Отчество) +
               '. Телефон: ' + RTRIM(i.Телефон)
        FROM inserted i;
    END
END;
GO

INSERT INTO Контактное_лицо (ID_Контактного_лица, Фамилия, Имя, Отчество, Телефон)
VALUES (12, 'Иванов', 'Иван', 'Иванович', '1234567890');
UPDATE Контактное_лицо SET Телефон = '9876543210' WHERE ID_Контактного_лица = 12;
DELETE FROM Контактное_лицо WHERE Фамилия = 'Иванов';
go

SELECT * FROM TR_AUDIT;


--ex5

GO
ALTER TABLE Контактное_лицо ADD CONSTRAINT 
Телефон_LEN CHECK (LEN(Телефон) <= 12);
go
UPDATE Контактное_лицо SET Телефон = '123456789012345' WHERE ID_Контактного_лица = 1;

ALTER TABLE Контактное_лицо DROP CONSTRAINT Телефон_LEN;
GO

--ex6
DROP TRIGGER IF EXISTS TR_ContactPerson_INS;

GO
CREATE TRIGGER TR_ContactPerson_DEL1 ON Контактное_лицо AFTER DELETE AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_ContactPerson_DEL1',
           'Контактное лицо: ' + RTRIM(d.ID_Контактного_лица) +
           '. Фамилия: ' + RTRIM(d.Фамилия) +
           '. Имя: ' + RTRIM(d.Имя) +
           '. Отчество: ' + RTRIM(d.Отчество) +
           '. Телефон: ' + RTRIM(d.Телефон)
    FROM DELETED d;
    PRINT('Вызван TR_ContactPerson_DEL1');
END;
GO

CREATE TRIGGER TR_ContactPerson_DEL2 ON Контактное_лицо AFTER DELETE AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_ContactPerson_DEL2',
           'Контактное лицо: ' + RTRIM(d.ID_Контактного_лица) +
           '. Фамилия: ' + RTRIM(d.Фамилия) +
           '. Имя: ' + RTRIM(d.Имя) +
           '. Отчество: ' + RTRIM(d.Отчество) +
           '. Телефон: ' + RTRIM(d.Телефон)
    FROM DELETED d;
    PRINT('Вызван TR_ContactPerson_DEL2');
END;
GO

CREATE TRIGGER TR_ContactPerson_DEL3 ON Контактное_лицо AFTER DELETE AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_ContactPerson_DEL3',
           'Контактное лицо: ' + RTRIM(d.ID_Контактного_лица) +
           '. Фамилия: ' + RTRIM(d.Фамилия) +
           '. Имя: ' + RTRIM(d.Имя) +
           '. Отчество: ' + RTRIM(d.Отчество) +
           '. Телефон: ' + RTRIM(d.Телефон)
    FROM DELETED d;
    PRINT('Вызван TR_ContactPerson_DEL3');
END;
GO
DROP TRIGGER IF EXISTS TR_ContactPerson_DEL1;
DROP TRIGGER IF EXISTS TR_ContactPerson_DEL2;
DROP TRIGGER IF EXISTS TR_ContactPerson_DEL3;

SELECT t.name, e.type_desc 
FROM sys.triggers t JOIN sys.trigger_events e  
ON t.object_id = e.object_id  
WHERE OBJECT_NAME(t.parent_id) = 'Контактное_лицо' AND e.type_desc = 'DELETE';  

-- Устанавливаем порядок вызова триггеров
EXEC SP_SETTRIGGERORDER @triggername = 'TR_ContactPerson_DEL3', 
                         @order = 'First', @stmttype = 'DELETE';

EXEC SP_SETTRIGGERORDER @triggername = 'TR_ContactPerson_DEL2', 
                         @order = 'Last', @stmttype = 'DELETE'
--ex7
DROP TRIGGER IF EXISTS ContactPerson_TRAN;

GO
CREATE TRIGGER ContactPerson_TRAN ON Контактное_лицо
AFTER INSERT, DELETE, UPDATE  
AS 
BEGIN
    DECLARE @count INT = (SELECT COUNT(*) FROM Контактное_лицо);
    IF (@count >= 5)
    BEGIN
        RAISERROR('Количество контактных лиц не должно быть больше 5!', 10, 1);
        ROLLBACK;
    END;
RETURN;
END;

INSERT INTO Контактное_лицо (ID_Контактного_лица, Фамилия, Имя, Отчество, Телефон) VALUES (10, 'Смирнов', 'Николай', 'Викторович', '9876543210')

go

--ex8
go
DROP TRIGGER IF EXISTS ContactPerson_INSTEAD_OF;

GO
CREATE TRIGGER ContactPerson_INSTEAD_OF ON Контактное_лицо
INSTEAD OF DELETE AS
BEGIN
    RAISERROR('Удаление контактных лиц запрещено', 10, 1);
END;
RETURN;
go
DELETE FROM Контактное_лицо WHERE ID_Контактного_лица = 1;
go
SELECT * FROM Контактное_лицо;

DROP TRIGGER IF EXISTS TR_ContactPerson_INS;
DROP TRIGGER IF EXISTS TR_ContactPerson_UPD;
DROP TRIGGER IF EXISTS ContactPerson_TRAN;
DROP TRIGGER IF EXISTS ContactPerson_INSTEAD_OF;
DROP TRIGGER IF EXISTS TR_ContactPerson_INS;
DROP TRIGGER IF EXISTS TR_ContactPerson;
DROP TRIGGER IF EXISTS TR_ContactPerson_DEL;

--ex9 
DROP TRIGGER  DDL_MYBASE;

go	
create  trigger DDL_MYBASE on database for DDL_DATABASE_LEVEL_EVENTS  
as   
declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INS-TANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectType)[1]', 'varchar(50)'); 
       print 'Тип события: '+@t;
       print 'Имя объекта: '+@t1;
       print 'Тип объекта: '+@t2;
       raiserror( N'Операции с таблицами запрещены ', 16, 1);  
       rollback;    

go
CREATE TABLE Контактное_лицо_Test
(
    ID INT IDENTITY(1,1),
    Фамилия VARCHAR(100)
)
