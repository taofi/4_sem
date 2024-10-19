use UNIVER;

/* ex_1 */
DECLARE @c char = 'A', 
		@vc varchar(4) = 'BSTU',
		@dt datetime,
		@t time(0),
		@i int,
		@si smallint,
		@ti tinyint,
		@num numeric(12,5)

SET @i = (select sum(NOTE) from PROGRESS);
SET @dt = Getdate();
SET @t = '11:34:45';

SELECT @si = min(NOTE), @num = avg(NOTE) from PROGRESS;
set @ti = @i + @si; 

print 'i = ' + cast(@i as varchar(13));
print 'c = ' + @c;
print 'vc = ' + @vc;
print 'dt = ' + cast(@dt as varchar(13));
print 't = ' + cast(@t as varchar(13));

select @i, @si, @ti, @num

/* ex_2 */
DECLARE @capacity int = (select sum(AUDITORIUM_CAPACITY) from AUDITORIUM),
		@q int = (select count(*) from AUDITORIUM),
		@avg int = (select cast(avg(AUDITORIUM_CAPACITY) as int) from AUDITORIUM);

DECLARE	@lessavg int =  (select cast(count(*) as int) from AUDITORIUM where AUDITORIUM_CAPACITY < @avg);
DECLARE	@percent float =  cast(cast(@lessavg as float) / cast(@q as float) * 100  as float);
		
	IF @capacity > 200
		begin 
		SELECT @q '���������� ���������',			@avg '������� ���������� ����',
			   @lessavg  '���������� ��������� < ��������',		cast(@percent as varchar) + '%'   '������� ���������, ������� < ��������'
		end
	ELSE IF @capacity < 200
		begin
		PRINT @capacity
		end;

/* ex_3 */
print '����� ������������ ����� = ' + cast(@@ROWCOUNT as varchar(10));
print '������ SQL Server = ' + cast(@@VERSION as varchar(300));
print '��������� ������������� ��������, ����������� �������� �������� ����������� = ' + cast(@@SPID as varchar(300));
print '��� ��������� ������ = ' + cast(@@ERROR as varchar(30));
print '��� ������� = ' + cast(@@SERVERNAME as varchar(30));
print '������� ����������� ���������� = ' + cast(@@trancount as varchar(30));
print '�������� ���������� ���������� ����� ��������������� ������ = ' + cast(@@FETCH_STATUS as varchar(30));
print '������� ����������� ������� ��������� = ' + cast(@@NESTLEVEL as varchar(30));

/* ex_4 */
/*---------------------*/
DECLARE @t2 int = 45, 
		@z float(10),
		@x int = 52;

if @t2 > @x
begin
set @z = power(sin(@t2),2);
print 'Z = '+cast(@z as varchar(15));
end

else if @t2 < @x
begin
set @z = 4 * (@t2 + @x);
print 'Z = '+cast(@z as varchar(15));
end

else if @t2 = @x
begin
set @z = 1 - exp(@x-2);
print 'Z = '+cast(@z as varchar(15));
end

/*---------------------*/
DECLARE @full_name varchar(100) = '������� ������ ���������';

set @full_name = (select substring(@full_name, 1, charindex(' ', @full_name)) +
								 substring(@full_name, charindex(' ', @full_name)+1, 1) + '.' +
								 substring(@full_name, charindex(' ', @full_name, charindex(' ', @full_name)+1)+1,1)+'.');
print @full_name;

/*---------------------*/
DECLARE @next_month int = MONTH(GETDATE()) + 1;
select * from STUDENT where MONTH(STUDENT.BDAY) = @next_month;

/*---------------------*/
select 
							 DATENAME(weekday,PDATE) 
from PROGRESS where SUBJECT = '����'

/* ex_5 */
DECLARE @coun int;

set @coun = (select count(NOTE) from PROGRESS);

if @coun < 10
begin
print '��������� ������ ������ 10'
end

else if @coun > 10
begin
print '��������� ������ ������ 10'
end

print '���������� ������ = '+ cast(@coun as varchar);

/* ex_6 */
select	PROGRESS.IDSTUDENT,PROGRESS.SUBJECT, case	
			when AVG(PROGRESS.NOTE) = 4 then '���� 4'
			when AVG(PROGRESS.NOTE)	between 5 and 6 then '�����������������'
			when AVG(PROGRESS.NOTE) between 7 and 8 then '������'
			when AVG(PROGRESS.NOTE) between 9 and 10 then '�������'
			end
			as [������������]
from PROGRESS
group by idstudent, SUBJECT

/* ex_7 */
DROP TABLE #TEMP;
CREATE TABLE #TEMP
		(
			ID int identity(1,1),
			RANDOM_NUMBER int,
		);

DECLARE  @iter int = 0;
WHILE @iter < 10
	begin
	INSERT #TEMP(RANDOM_NUMBER)
			values(rand() * 1000);
	SET @iter = @iter + 1;
	end
SELECT * from #TEMP;

/* ex_8 */
DECLARE @par int = 1
print @par+1
print @par+2
RETURN
print @par+3

/* ex_9 */
begin try
insert PULPIT values(12, 'asd', 'test');
end try
begin catch
print '��� ��������� ������: ' + cast(ERROR_NUMBER() as varchar(10))
print '��������� �� ������: ' + ERROR_MESSAGE()
print '����� ������ � �������: ' + cast(ERROR_LINE() as varchar(10))
print '��� ��������� ��� NULL: ' + ERROR_PROCEDURE()
print '������� ����������� ������: ' + cast(ERROR_SEVERITY() as varchar(10))
print '����� ������: ' +  cast(ERROR_STATE() as varchar(10))
end catch