use VOR_MyBase
--ex1

DECLARE @company char(35), @all char(500) = '';

DECLARE �������������� CURSOR for select ��������_����������� from ����������� where ��������_����������� like '%���%';
OPEN ��������������;
FETCH �������������� into @company;
print '��� :';
while @@FETCH_STATUS = 0
	begin
		set @all = RTRIM(@company) +', ' +  @all;
		FETCH  �������������� into @company;
	end;
	print @all;
CLOSE ��������������;
go;
--ex2
DECLARE �����������Global CURSOR GLOBAL for select ��������_����������� from �����������
--deallocate Puplit_cursor;
DECLARE @company char(35), @companys char(500) = '';
OPEN �����������Global;
FETCH  �����������Global into @company;
	set @companys ='1. ' + RTRIM(@company);	
	print @companys;
CLOSE �����������Global;

go
DECLARE @company char(35), @companys char(500) = '';
OPEN �����������Global;
FETCH  �����������Global into @company;
	set @companys ='1. ' + RTRIM(@company);	
	print @companys;
CLOSE �����������Global;
go

DECLARE �����������Local CURSOR LOCAL for select ��������_����������� from �����������
--deallocate Puplit_cursor;
DECLARE @company char(35), @companys char(500) = '';
OPEN �����������Local;
FETCH  �����������Local into @company;
	set @companys ='1. ' + RTRIM(@company);	
	print @companys;
CLOSE �����������Local;

go
DECLARE @company char(35), @companys char(500) = '';
OPEN �����������Local;
FETCH  �����������Local into @company;
	set @companys ='1. ' + RTRIM(@company);	
	print @companys;
CLOSE �����������Local;
go

--ex3

DECLARE ������_local_static CURSOR  STATIC for select  ��������_����������, ID_������� from ������;

DECLARE @q int = 0, @analiz char(10), @iter int = 1;
open ������_local_static;
print '���������� �����: ' + cast(@@CURSOR_ROWS as varchar(5));
DELETE ������ where ��������_���������� = 100;
FETCH ������_local_static into @analiz, @q;
while @@FETCH_STATUS = 0
	begin
		print cast(@iter as varchar(5)) + '. ��������_���������� ' + rtrim(@analiz) +': ' + cast(@q as varchar(5)) + ' id' ;
		set @iter += 1;
		FETCH ������_local_static into @analiz, @q;
	end;
CLOSE ������_local_static;

go

INSERT Into ������ values(10,'������','��� ����',101, '1990-10-1');
DECLARE ������_local_dynamic CURSOR  DYNAMIC for select  ��������_����������, ID_������� from ������;

DECLARE @q int = 0, @analiz char(10), @iter int = 1;
open ������_local_dynamic;
print '���������� �����: ' + cast(@@CURSOR_ROWS as varchar(5));
DELETE ������ where ��������_���������� = 101;
FETCH ������_local_dynamic into @analiz, @q;
while @@FETCH_STATUS = 0
	begin
		print cast(@iter as varchar(5)) + '. ��������_���������� ' + rtrim(@analiz) +': ' + cast(@q as varchar(5)) + ' id' ;
		set @iter += 1;
		FETCH ������_local_dynamic into @analiz, @q;
	end;
CLOSE ������_local_dynamic;

--ex4

DECLARE @number varchar(6), @id varchar(6), @name varchar(40), @company varchar(30), @value varchar(6), @pdate varchar (11);
DECLARE ������_CURSOR_SCROLL CURSOR LOCAL DYNAMIC SCROLL
	for select ROW_NUMBER() over (order by ID_�������) �����,
	* from ������;

OPEN ������_CURSOR_SCROLL
FETCH ������_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print '������ ��������� ������: ' + CHAR(10) +
'����� ������: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' ��������: '+ rtrim(@name)  +
'. ��������: '+ rtrim(@company) +
'. ��������: ' + rtrim(@value) +
'. ����: '  + rtrim(@pdate);

FETCH LAST from ������_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print '��������� ������: ' + CHAR(10) +
'����� ������: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' ��������: '+ rtrim(@name)  +
'. ��������: '+ rtrim(@company) +
'. ��������: ' + rtrim(@value) +
'. ����: '  + rtrim(@pdate);

FETCH RELATIVE -1  from ������_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print '������ �� ���������� ������: ' + CHAR(10) +
'����� ������: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' ��������: '+ rtrim(@name)  +
'. ��������: '+ rtrim(@company) +
'. ��������: ' + rtrim(@value) +
'. ����: '  + rtrim(@pdate);

FETCH ABSOLUTE 2  from ������_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print '������ � ������ ������: ' + CHAR(10) +
'����� ������: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' ��������: '+ rtrim(@name)  +
'. ��������: '+ rtrim(@company) +
'. ��������: ' + rtrim(@value) +
'. ����: '  + rtrim(@pdate);
FETCH RELATIVE 1  from ������_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print '������ ����� ���������� ������: ' + CHAR(10) +
'����� ������: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' ��������: '+ rtrim(@name)  +
'. ��������: '+ rtrim(@company) +
'. ��������: ' + rtrim(@value) +
'. ����: '  + rtrim(@pdate);

FETCH ABSOLUTE -3 from ������_CURSOR_SCROLL into @number, @id, @name, @company, @value, @pdate;
print '������ � ����� ������: ' + CHAR(10) +
'����� ������: '+ rtrim(@number) +
' ID: '+ rtrim(@id)  +
' ��������: '+ rtrim(@name)  +
'. ��������: '+ rtrim(@company) +
'. ��������: ' + rtrim(@value) +
'. ����: '  + rtrim(@pdate);

close ������_CURSOR_SCROLL;

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

INSERT Into ������ values(10,'������','��� ����',101, '1990-10-1');
INSERT Into ������ values(11,'������','��� ����',102, '1990-10-1');

DECLARE newCursor cursor local dynamic 
						for SELECT ���, �����������.��������_�����������, ��������_����������
						from ������ inner join ����������� on ������.��������_����������� = �����������.��������_����������� inner join
						����������_���� on ����������_����.ID_�����������_���� = �����������.ID_�����������_����;

DECLARE @name varchar(300), @company varchar(300), @value varchar(5), @list varchar(400);

OPEN newCursor;
fetch newCursor into @name,@company,@value;
While (@@FETCH_STATUS = 0)
	begin
		print @name + ' - '+ @company + ' - ' + @value ;
		if(@value > 100)
			begin
				DELETE ������ where CURRENT OF newCursor;
			end;
		fetch newCursor into @name,@company,@value;
		
	end;
CLOSE newCursor;
				