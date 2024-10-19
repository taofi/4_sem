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

DROP table Анализ
DROP table Показатель
DROP table Предприятие
DROP table Контактное_лицо

CREATE table Контактное_лицо
(
	ID_Контактного_лица int primary key,
	Фамилия nvarchar(30) not null,
	Имя nvarchar(30) not null,
	Отчество nvarchar(30) not null,
	Телефон nvarchar(30) not null
) on FG1;

CREATE table Показатель
(
	Название_показателя nvarchar(40) primary key,
	Важность_показателя real not null
)on FG1;

CREATE table Предприятие
(
	Название_предприятия nvarchar(30) primary key,
	Банковские_реквизиты nvarchar(15) not null,
	ID_Контактного_лица int not null
		foreign key REFERENCES Контактное_лицо(ID_Контактного_лица),
)on FG1;

CREATE table Анализ
(
	ID_Анализа int primary key,
	Название_показателя nvarchar(40) not null
		foreign key REFERENCES Показатель(Название_показателя),
	Название_предприятия nvarchar(30) not null
		foreign key REFERENCES Предприятие(Название_предприятия),
	Значение_показателя real not null,
	Дата date not null,

)on FG1;




Alter table Контактное_лицо ADD Возраст int default (18) CHECK (Возраст >= 18);

ALTER TABLE Контактное_лицо
DROP CONSTRAINT DF__Контактно__Возра__5AEE82B9;
ALTER TABLE Контактное_лицо
DROP CONSTRAINT CK__Контактно__Возра__5BE2A6F2;
ALTER TABLE Контактное_лицо
DROP COLUMN Возраст;

INSERT into Показатель (Название_показателя, Важность_показателя)
	values ('Доход', 10),
	('Убытки', 11),
	('Себе стоимость', 3.2);

INSERT into Контактное_лицо (ID_Контактного_лица, Фамилия, Имя, Отчество, Телефон)
	values (1, 'Макаров', 'Максим', 'Константинович', '+375 29 123 42 32'),
	(2, 'Крюкова ', 'Анна', 'Ярославовна', '+375 29 789 12 32'),
	(3, 'Денисова', 'Мирослава', 'Данииловна', '+375 29 123 42 32');

INSERT into Предприятие (Название_предприятия, Банковские_реквизиты, ID_Контактного_лица)
	values ('ооо банк', '531231', 1),
	('ооо рыба', '5231231', 2),
	('ооо стройбат', '88911231', 3);

INSERT into Анализ(ID_Анализа, Название_показателя, Название_предприятия, Значение_показателя, Дата)
	values (1, 'Убытки', 'ооо банк', 100, '20.02.23'),
	(2, 'Доход', 'ооо стройбат', 10, '20.06.23');


SELECT Название_предприятия, Банковские_реквизиты
FROM Предприятие;

SELECT COUNT(*)
FROM Предприятие;

UPDATE Предприятие
SET Банковские_реквизиты = '123456789012345'
WHERE Название_предприятия = N'ооо рыба';

SELECT *
FROM Предприятие;

