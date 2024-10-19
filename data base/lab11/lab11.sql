use VOR_MyBase
--ex1

DECLARE @company char(35), @all char(500) = '';

DECLARE ПредприятияООО CURSOR for select Название_предприятия from Предприятие where Название_предприятия like '%ооо%';
OPEN ПредприятияООО;
FETCH ПредприятияООО into @company;
print 'ооо :';
while @@FETCH_STATUS = 0
	begin
		set @all = RTRIM(@company) +', ' +  @all;
		FETCH  ПредприятияООО into @company;
	end;
	print @all;
CLOSE ПредприятияООО;
go;
--ex2
DECLARE ПредприятияGlobal CURSOR GLOBAL for select Название_предприятия from Предприятие
--deallocate Puplit_cursor;
DECLARE @company char(35), @companys char(500) = '';
OPEN ПредприятияGlobal;
FETCH  ПредприятияGlobal into @company;
	set @companys ='1. ' + RTRIM(@company);	
	print @companys;
CLOSE ПредприятияGlobal;

go
DECLARE @company char(35), @companys char(500) = '';
OPEN ПредприятияGlobal;
FETCH  ПредприятияGlobal into @company;
	set @companys ='1. ' + RTRIM(@company);	
	print @companys;
CLOSE ПредприятияGlobal;
go

DECLARE ПредприятияLocal CURSOR LOCAL for select Название_предприятия from Предприятие
--deallocate Puplit_cursor;
DECLARE @company char(35), @companys char(500) = '';
OPEN ПредприятияLocal;
FETCH  ПредприятияLocal into @company;
	set @companys ='1. ' + RTRIM(@company);	
	print @companys;
CLOSE ПредприятияLocal;

go
DECLARE @company char(35), @companys char(500) = '';
OPEN ПредприятияLocal;
FETCH  ПредприятияLocal into @company;
	set @companys ='1. ' + RTRIM(@company);	
	print @companys;
CLOSE ПредприятияLocal;
go

--ex3

DECLARE Анализ_local_static CURSOR  STATIC for select  Значение_показателя, ID_Анализа from Анализ;

DECLARE @q int = 0, @analiz char(10), @iter int = 1;
open Анализ_local_static;
print 'Количество строк: ' + cast(@@CURSOR_ROWS as varchar(5));
DELETE Анализ where Значение_показателя = 100;
FETCH Анализ_local_static into @analiz, @q;
while @@FETCH_STATUS = 0
	begin
		print cast(@iter as varchar(5)) + '. Значение_показателя ' + rtrim(@analiz) +': ' + cast(@q as varchar(5)) + ' id' ;
		set @iter += 1;
		FETCH Анализ_local_static into @analiz, @q;
	end;
CLOSE Анализ_local_static;

go

INSERT Into Анализ values(10,'Убытки','ооо банк',101, '1990-10-1');
DECLARE Анализ_local_dynamic CURSOR  DYNAMIC for select  Значение_показателя, ID_Анализа from Анализ;

DECLARE @q int = 0, @analiz char(10), @iter int = 1;
open Анализ_local_dynamic;
print 'Количество строк: ' + cast(@@CURSOR_ROWS as varchar(5));
DELETE Анализ where Значение_показателя = 101;
FETCH Анализ_local_dynamic into @analiz, @q;
while @@FETCH_STATUS = 0
	begin
		print cast(@iter as varchar(5)) + '. Значение_показателя ' + rtrim(@analiz) +': ' + cast(@q as varchar(5)) + ' id' ;
		set @iter += 1;
		FETCH Анализ_local_dynamic into @analiz, @q;
	end;
CLOSE Анализ_local_dynamic;

--ex4

DECLARE @number varchar(6), @id varchar(6), @name varchar(40), @company varchar(30), @value varchar(6), @pdate varchar (11);
DECLARE Анализ_CURSOR_SCROLL CURSOR LOCAL DYNAMIC SCROLL
	for select ROW_NUMBER() over (order by ID_Анализа) Номер,
	* from Анализ;

OPEN Анализ_CURSOR_SCROLL
FETCH Анализ_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print 'Первая выбранная строка: ' + CHAR(10) +
'Номер записи: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' Название: '+ rtrim(@name)  +
'. Компания: '+ rtrim(@company) +
'. Значение: ' + rtrim(@value) +
'. Дата: '  + rtrim(@pdate);

FETCH LAST from Анализ_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print 'Последняя строка: ' + CHAR(10) +
'Номер записи: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' Название: '+ rtrim(@name)  +
'. Компания: '+ rtrim(@company) +
'. Значение: ' + rtrim(@value) +
'. Дата: '  + rtrim(@pdate);

FETCH RELATIVE -1  from Анализ_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print 'Первая до предыдущей строка: ' + CHAR(10) +
'Номер записи: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' Название: '+ rtrim(@name)  +
'. Компания: '+ rtrim(@company) +
'. Значение: ' + rtrim(@value) +
'. Дата: '  + rtrim(@pdate);

FETCH ABSOLUTE 2  from Анализ_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print 'Вторая с начала строка: ' + CHAR(10) +
'Номер записи: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' Название: '+ rtrim(@name)  +
'. Компания: '+ rtrim(@company) +
'. Значение: ' + rtrim(@value) +
'. Дата: '  + rtrim(@pdate);
FETCH RELATIVE 1  from Анализ_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print 'Первая после предыдущей строка: ' + CHAR(10) +
'Номер записи: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' Название: '+ rtrim(@name)  +
'. Компания: '+ rtrim(@company) +
'. Значение: ' + rtrim(@value) +
'. Дата: '  + rtrim(@pdate);

FETCH ABSOLUTE -3 from Анализ_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print 'Третья с конца строка: ' + CHAR(10) +
'Номер записи: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' Название: '+ rtrim(@name)  +
'. Компания: '+ rtrim(@company) +
'. Значение: ' + rtrim(@value) +
'. Дата: '  + rtrim(@pdate);

close Анализ_CURSOR_SCROLL;

--ex5

use master;
CREATE TABLE #EXAMPLE
(
	ID int identity(1,1),
	WORD varchar(100)
);

INSERT INTO #EXAMPLE values ('asd'),('aaaa'),('dd'),('fas'),('sssa'),('asddd'),('sdaa');


DECLARE @id varchar(10), @word varchar(100);
DECLARE CURRENT_OF_CURSROR CURSOR LOCAL DYNAMIC
	for SELECT * from #EXAMPLE FOR UPDATE;
OPEN CURRENT_OF_CURSROR
fetch CURRENT_OF_CURSROR into @id,@word;
print @id + '-' + @word;
DELETE #EXAMPLE where CURRENT OF CURRENT_OF_CURSROR;
fetch  CURRENT_OF_CURSROR into @id,@word;
UPDATE #EXAMPLE set WORD += ' - updated' where CURRENT OF CURRENT_OF_CURSROR;
close CURRENT_OF_CURSROR;



OPEN CURRENT_OF_CURSROR
while(@@FETCH_STATUS = 0)
	begin
		fetch CURRENT_OF_CURSROR into @id,@word;
		print @id + '-' + @word;
	end;
close CURRENT_OF_CURSROR;

DROP TABLE #EXAMPLE;

--ex6
go;
use VOR_MyBase;

INSERT Into Анализ values(10,'Убытки','ооо банк',101, '1990-10-1');
INSERT Into Анализ values(11,'Убытки','ооо банк',102, '1990-10-1');

DECLARE newCursor cursor local dynamic 
						for SELECT Имя, Предприятие.Название_предприятия, Значение_показателя
						from Анализ inner join Предприятие on Анализ.Название_предприятия = Предприятие.Название_предприятия inner join
						Контактное_лицо on Контактное_лицо.ID_Контактного_лица = Предприятие.ID_Контактного_лица;

DECLARE @name varchar(300), @company varchar(300), @value varchar(5), @list varchar(400);

OPEN newCursor;
fetch newCursor into @name,@company,@value;
While (@@FETCH_STATUS = 0)
	begin
		print @name + ' - '+ @company + ' - ' + @value ;
		if(@value > 100)
			begin
				DELETE Анализ where CURRENT OF newCursor;
			end;
		fetch newCursor into @name,@company,@value;
		
	end;
CLOSE newCursor;
				