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
CREATE TRIGGER TR_ContactPerson_INS ON ����������_����
AFTER INSERT AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'INS', 'TR_ContactPerson_INS',
           '���������� ����: ' + RTRIM(i.ID_�����������_����) +
           '. �������: ' + RTRIM(i.�������) +
           '. ���: ' + RTRIM(i.���) +
           '. ��������: ' + RTRIM(i.��������) +
           '. �������: ' + RTRIM(i.�������)
    FROM INSERTED i;
END;
GO

INSERT INTO ����������_���� (ID_�����������_����, �������, ���, ��������, �������)
VALUES (12, '������', '����', '��������', '1234567890');

SELECT * FROM TR_AUDIT;

go
--ex2
DROP TRIGGER IF EXISTS TR_ContactPerson_DEL;

GO
CREATE TRIGGER TR_ContactPerson_DEL ON ����������_����
AFTER DELETE AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_ContactPerson_DEL',
           '���������� ����: ' + RTRIM(d.ID_�����������_����) +
           '. �������: ' + RTRIM(d.�������) +
           '. ���: ' + RTRIM(d.���) +
           '. ��������: ' + RTRIM(d.��������) +
           '. �������: ' + RTRIM(d.�������)
    FROM DELETED d;
END;
GO

DELETE FROM ����������_���� WHERE ID_�����������_���� = 12;
SELECT * FROM TR_AUDIT;
--ex3
go
DROP TRIGGER IF EXISTS TR_ContactPerson_UPD;

GO
CREATE TRIGGER TR_ContactPerson_UPD ON ����������_����
AFTER UPDATE AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'UPD', 'TR_ContactPerson_UPD',
           '���������� ���� ���������: ' + RTRIM(i.ID_�����������_����) +
           '. �������: ' + RTRIM(i.�������) +
           '. ���: ' + RTRIM(i.���) +
           '. ��������: ' + RTRIM(i.��������) +
           '. �������: ' + RTRIM(i.�������)
    FROM INSERTED i;
END;
GO

UPDATE ����������_���� SET ������� = '9876543210' WHERE ID_�����������_���� = 2;
SELECT * FROM TR_AUDIT;
--ex4
DROP TRIGGER IF EXISTS TR_ContactPerson;

GO
CREATE TRIGGER TR_ContactPerson ON ����������_����
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    DECLARE @ins INT = (SELECT COUNT(*) FROM inserted),
            @del INT = (SELECT COUNT(*) FROM deleted);

    IF @ins > 0 AND @del = 0
    BEGIN
        PRINT '�������: INSERT';
        INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
        SELECT 'INS', 'TR_ContactPerson_INS',
               '���������� ����: ' + RTRIM(i.ID_�����������_����) +
               '. �������: ' + RTRIM(i.�������) +
               '. ���: ' + RTRIM(i.���) +
               '. ��������: ' + RTRIM(i.��������) +
               '. �������: ' + RTRIM(i.�������)
        FROM inserted i;
    END
    ELSE IF @ins = 0 AND @del > 0
    BEGIN
        PRINT '�������: DELETE';
        INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
        SELECT 'DEL', 'TR_ContactPerson_DEL',
               '���������� ����: ' + RTRIM(d.ID_�����������_����) +
               '. �������: ' + RTRIM(d.�������) +
               '. ���: ' + RTRIM(d.���) +
               '. ��������: ' + RTRIM(d.��������) +
               '. �������: ' + RTRIM(d.�������)
        FROM deleted d;
    END
    ELSE IF @ins > 0 AND @del > 0
    BEGIN
        PRINT '�������: UPDATE';
        INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
        SELECT 'UPD', 'TR_ContactPerson_UPD',
               '���������� ���� ���������: ' + RTRIM(i.ID_�����������_����) +
               '. �������: ' + RTRIM(i.�������) +
               '. ���: ' + RTRIM(i.���) +
               '. ��������: ' + RTRIM(i.��������) +
               '. �������: ' + RTRIM(i.�������)
        FROM inserted i;
    END
END;
GO

INSERT INTO ����������_���� (ID_�����������_����, �������, ���, ��������, �������)
VALUES (12, '������', '����', '��������', '1234567890');
UPDATE ����������_���� SET ������� = '9876543210' WHERE ID_�����������_���� = 12;
DELETE FROM ����������_���� WHERE ������� = '������';
go

SELECT * FROM TR_AUDIT;


--ex5

GO
ALTER TABLE ����������_���� ADD CONSTRAINT 
�������_LEN CHECK (LEN(�������) <= 12);
go
UPDATE ����������_���� SET ������� = '123456789012345' WHERE ID_�����������_���� = 1;

ALTER TABLE ����������_���� DROP CONSTRAINT �������_LEN;
GO

--ex6
DROP TRIGGER IF EXISTS TR_ContactPerson_INS;

GO
CREATE TRIGGER TR_ContactPerson_DEL1 ON ����������_���� AFTER DELETE AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_ContactPerson_DEL1',
           '���������� ����: ' + RTRIM(d.ID_�����������_����) +
           '. �������: ' + RTRIM(d.�������) +
           '. ���: ' + RTRIM(d.���) +
           '. ��������: ' + RTRIM(d.��������) +
           '. �������: ' + RTRIM(d.�������)
    FROM DELETED d;
    PRINT('������ TR_ContactPerson_DEL1');
END;
GO

CREATE TRIGGER TR_ContactPerson_DEL2 ON ����������_���� AFTER DELETE AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_ContactPerson_DEL2',
           '���������� ����: ' + RTRIM(d.ID_�����������_����) +
           '. �������: ' + RTRIM(d.�������) +
           '. ���: ' + RTRIM(d.���) +
           '. ��������: ' + RTRIM(d.��������) +
           '. �������: ' + RTRIM(d.�������)
    FROM DELETED d;
    PRINT('������ TR_ContactPerson_DEL2');
END;
GO

CREATE TRIGGER TR_ContactPerson_DEL3 ON ����������_���� AFTER DELETE AS
BEGIN
    INSERT INTO TR_AUDIT (STMT, TRNAME, CC)
    SELECT 'DEL', 'TR_ContactPerson_DEL3',
           '���������� ����: ' + RTRIM(d.ID_�����������_����) +
           '. �������: ' + RTRIM(d.�������) +
           '. ���: ' + RTRIM(d.���) +
           '. ��������: ' + RTRIM(d.��������) +
           '. �������: ' + RTRIM(d.�������)
    FROM DELETED d;
    PRINT('������ TR_ContactPerson_DEL3');
END;
GO
DROP TRIGGER IF EXISTS TR_ContactPerson_DEL1;
DROP TRIGGER IF EXISTS TR_ContactPerson_DEL2;
DROP TRIGGER IF EXISTS TR_ContactPerson_DEL3;

SELECT t.name, e.type_desc 
FROM sys.triggers t JOIN sys.trigger_events e  
ON t.object_id = e.object_id  
WHERE OBJECT_NAME(t.parent_id) = '����������_����' AND e.type_desc = 'DELETE';  

-- ������������� ������� ������ ���������
EXEC SP_SETTRIGGERORDER @triggername = 'TR_ContactPerson_DEL3', 
                         @order = 'First', @stmttype = 'DELETE';

EXEC SP_SETTRIGGERORDER @triggername = 'TR_ContactPerson_DEL2', 
                         @order = 'Last', @stmttype = 'DELETE'
--ex7
DROP TRIGGER IF EXISTS ContactPerson_TRAN;

GO
CREATE TRIGGER ContactPerson_TRAN ON ����������_����
AFTER INSERT, DELETE, UPDATE  
AS 
BEGIN
    DECLARE @count INT = (SELECT COUNT(*) FROM ����������_����);
    IF (@count >= 5)
    BEGIN
        RAISERROR('���������� ���������� ��� �� ������ ���� ������ 5!', 10, 1);
        ROLLBACK;
    END;
RETURN;
END;

INSERT INTO ����������_���� (ID_�����������_����, �������, ���, ��������, �������) VALUES (10, '�������', '�������', '����������', '9876543210')

go

--ex8
go
DROP TRIGGER IF EXISTS ContactPerson_INSTEAD_OF;

GO
CREATE TRIGGER ContactPerson_INSTEAD_OF ON ����������_����
INSTEAD OF DELETE AS
BEGIN
    RAISERROR('�������� ���������� ��� ���������', 10, 1);
END;
RETURN;
go
DELETE FROM ����������_���� WHERE ID_�����������_���� = 1;
go
SELECT * FROM ����������_����;

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
       print '��� �������: '+@t;
       print '��� �������: '+@t1;
       print '��� �������: '+@t2;
       raiserror( N'�������� � ��������� ��������� ', 16, 1);  
       rollback;    

go
CREATE TABLE ����������_����_Test
(
    ID INT IDENTITY(1,1),
    ������� VARCHAR(100)
)
