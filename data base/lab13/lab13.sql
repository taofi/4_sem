use UNIVER;
go
--ex1
Create procedure PSubject
as 
	begin
		declare @k int = (select count(*) from SUBJECT);
		select Subject[���], Subject_name[����������], Pulpit[�������] from SUBJECT;
		return @k;
	end;

declare @k int = 0;
EXEC @k = PSubject;
print '���-�� ���������' + cast(@k as varchar(3))

---ex2
Alter procedure PSubject @p varchar(20) = null, @c int output
as 
	begin
		declare @k int = (select count(*) from SUBJECT);
		print '���������: @p= '+ @p +', @c= '+cast(@c as varchar(3))
		select Subject[���], Subject_name[����������], Pulpit[�������] from SUBJECT
		where PULPIT = @p;
		set @c = @@ROWCOUNT
		return @k;
	end;
drop procedure PSubject

declare @k int = 0, @r int = 0, @p varchar(20) = '����';
EXEC @k = PSubject @p, @r output;
print '���-�� ��������� ' + cast(@k as varchar(3));
print '�� ������� ���� ' + cast(@r as varchar(3));

--ex3

drop table #SUBJECT;
create table #SUBJECT(
	��� varchar(10) primary key,
	���������� varchar(50),
	������� varchar(10)
);

alter procedure PSUBJECT @p varchar(20)
as begin
	select * from SUBJECT where SUBJECT.PULPIT = @p;
end;

insert #SUBJECT exec PSUBJECT @p = '����'; 
SELECT * from #SUBJECT;

--ex4-
drop procedure PAUDITORIUM_INSERT;
create procedure PAUDITORIUM_INSERT @a char(20), @n varchar(50),  @c int=0, @t char(10)
as 
begin try
	insert into AUDITORIUM(AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
		values (@a, @n, @c, @t)
	return 1;
end try
begin catch
	print '����� ������: ' + cast(error_number() as varchar(6));	
	print '���������: ' + error_message();
	print '�������: ' + cast(error_severity() as varchar(6));
	print '�����: ' + cast(error_state() as varchar(8));
	print '����� ������: ' + cast(error_line() as varchar(8));
	if error_procedure() is not null   
		print '��� ���������: ' + error_procedure();
	return -1;
end catch;

DECLARE @rc int; 
exec @rc=PAUDITORIUM_INSERT @a='207-7', @n='������������', @c=60, @t='��';
print '�����: '+cast(@rc as varchar(3));
delete AUDITORIUM where AUDITORIUM='207-7';

select * from AUDITORIUM

--ex5
drop procedure SUBJECT_REPORT
create procedure SUBJECT_REPORT @p char(10)
as 
declare @rc int = 0;
begin try
	if not exists (select SUBJECT from SUBJECT where PULPIT = @p)
	raiserror('������', 11, 1);
	declare @slist char(300) = '', @subj char(10);
	declare SUBJECTS cursor for select SUBJECT from SUBJECT where PULPIT = @p;
	open SUBJECTS;
	fetch SUBJECTS into @subj;
	while (@@FETCH_STATUS = 0)
	begin
		set @slist = rtrim(@subj) + ', ' + @slist;
		set @rc += 1;
		fetch SUBJECTS into @subj;
	end;
	print '������� ' + rtrim(@p) + ':';
	print rtrim(@slist);
	close SUBJECTS;
	deallocate SUBJECTS;
	return @rc;
end try
begin catch
	print '����� ������: ' + cast(error_number() as varchar(6));	
	print '���������: ' + error_message();
	print '�������: ' + cast(error_severity() as varchar(6));
	print '�����: ' + cast(error_state() as varchar(8));
	print '����� ������: ' + cast(error_line() as varchar(8));
	if error_procedure() is not null   
		print '��� ���������: ' + error_procedure();
	return @rc;
end catch;
go

declare @rc int;
exec @rc = SUBJECT_REPORT '����';
print '����������: ' + cast(@rc as varchar);

--ex6--

drop procedure PAUDITORIUM_INSERTX;
create procedure PAUDITORIUM_INSERTX 
@aud char(20), @name varchar(50), @capacity int = 0,
@type char(10), @typename varchar(70)
as begin try
	set transaction isolation level SERIALIZABLE
	begin tran
		insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values (@type, @typename)
		exec PAUDITORIUM_INSERT @aud, @type, @capacity, @name
	commit tran
end try
begin catch
	print '�����:  ' + cast(ERROR_NUMBER() as varchar)
	print '�������: ' + cast(ERROR_SEVERITY() as varchar)
	print '���������:   ' + cast(ERROR_MESSAGE() as varchar)
	if @@TRANCOUNT > 0 
		rollback tran
	return -1
end catch

exec PAUDITORIUM_INSERTX @aud = '207-1', @name = '207', 
@capacity = 50, @type = '207', @typename = '207'
delete AUDITORIUM where AUDITORIUM_TYPE='207';
delete AUDITORIUM_TYPE where AUDITORIUM_TYPE='207'
select * from AUDITORIUM;
