USE master;

DROP DATABASE VOR_MyBase;

CREATE DATABASE VOR_MyBase
ON PRIMARY 
(NAME = N'VOR_MyBase_mdf', FILENAME = N'D:\4_sem\data base\data\VOR_MyBase_mgf.mdf',
SIZE = 10MB, MAXSIZE = UNLIMITED, FILEGROWTH = 1024Kb),
(NAME = N'VOR_MyBase_ndf', FILENAME = N'D:\4_sem\data base\data\VOR_MyBase_ndf.ndf',
SIZE = 10MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10%),
FILEGROUP FG1
(NAME = N'VOR_MyBase_FG1_1', FILENAME = N'D:\4_sem\data base\data\VOR_MyBase_FG1_1.ndf', 
SIZE = 5MB, MAXSIZE = UNLIMITED, FILEGROWTH = 15%),
(NAME = N'VOR_MyBase_FG1_2', FILENAME = N'D:\4_sem\data base\data\VOR_MyBase_FG1_2.ndf',
SIZE = 5MB, MAXSIZE = UNLIMITED, FILEGROWTH = 15%)
LOG ON 
(NAME = N'VOR_MyBase_log', FILENAME = N'D:\4_sem\data base\log\VOR_MyBase_log.ldf',
SIZE = 5MB, MAXSIZE = 25MB, FILEGROWTH = 5MB);


USE VOR_MyBase

DROP table ������
DROP table ����������
DROP table �����������
DROP table ����������_����

CREATE table ����������_����
(
	ID_�����������_���� int primary key,
	������� nvarchar(30) not null,
	��� nvarchar(30) not null,
	�������� nvarchar(30) not null,
	������� nvarchar(30) not null
) on FG1;

CREATE table ����������
(
	��������_���������� nvarchar(40) primary key,
	��������_���������� real not null
)on FG1;

CREATE table �����������
(
	��������_����������� nvarchar(30) primary key,
	����������_��������� nvarchar(15) not null,
	ID_�����������_���� int not null
		foreign key REFERENCES ����������_����(ID_�����������_����),
)on FG1;

CREATE table ������
(
	ID_������� int primary key,
	��������_���������� nvarchar(40) not null
		foreign key REFERENCES ����������(��������_����������),
	��������_����������� nvarchar(30) not null
		foreign key REFERENCES �����������(��������_�����������),
	��������_���������� real not null,
	���� date not null,

)on FG1;




Alter table ����������_���� ADD ������� int default (18) CHECK (������� >= 18);

ALTER TABLE ����������_����
DROP CONSTRAINT DF__���������__�����__5AEE82B9;
ALTER TABLE ����������_����
DROP CONSTRAINT CK__���������__�����__5BE2A6F2;
ALTER TABLE ����������_����
DROP COLUMN �������;

INSERT into ���������� (��������_����������, ��������_����������)
	values ('�����', 10),
	('������', 11),
	('���� ���������', 3.2);

INSERT into ����������_���� (ID_�����������_����, �������, ���, ��������, �������)
	values (1, '�������', '������', '��������������', '+375 29 123 42 32'),
	(2, '������� ', '����', '�����������', '+375 29 789 12 32'),
	(3, '��������', '���������', '����������', '+375 29 123 42 32');

INSERT into ����������� (��������_�����������, ����������_���������, ID_�����������_����)
	values ('��� ����', '531231', 1),
	('��� ����', '5231231', 2),
	('��� ��������', '88911231', 3);

INSERT into ������(ID_�������, ��������_����������, ��������_�����������, ��������_����������, ����)
	values (1, '������', '��� ����', 100, '20.02.23'),
	(2, '�����', '��� ��������', 10, '20.06.23');


SELECT ��������_�����������, ����������_���������
FROM �����������;

SELECT COUNT(*)
FROM �����������;

UPDATE �����������
SET ����������_��������� = '123456789012345'
WHERE ��������_����������� = N'��� ����';

SELECT *
FROM �����������;

