--ex1
 
create function COUNT_STUDENTS(@faculty varchar(20)) returns int
as begin 
declare @ret int = 0;
set @ret = (select count(IDSTUDENT) from 
			GROUPS inner join FACULTY 
			on GROUPS.FACULTY = FACULTY.FACULTY inner join STUDENT
			on STUDENT.IDGROUP = GROUPS.IDGROUP where GROUPS.FACULTY = @faculty);
return @ret;
end;

--DROP FUNCTION COUNT_STUDENTS;

declare @faculty_name char(10) = 'ХТиТ';
declare @f_result int = dbo.COUNT_STUDENTS(@faculty_name);
print 'Количество студентов факультета ' + rtrim(@faculty_name) + ': ' + cast(@f_result as varchar);


--ex2
go
create function FSUBJECTS(@p varchar(20)) returns varchar(300)
as begin
DECLARE Discipline CURSOR LOCAL for select [SUBJECT_NAME] from [SUBJECT] where [SUBJECT].PULPIT = @p;
DECLARE @subject varchar(60), @subject_ot varchar(300) ='';
OPEN Discipline;
FETCH Discipline into @subject;
while @@FETCH_STATUS = 0
	begin
		set @subject_ot = RTRIM(@subject) +', ' +  @subject_ot;
		FETCH  Discipline into @subject;
	end;
CLOSE Discipline;
set @subject_ot = '•Дисциплины: ' + @subject_ot;
return @subject_ot;
end;

--DROP FUNCTION FSUBJECTS;

select PULPIT.PULPIT 'Кафедра', dbo.FSUBJECTS(PULPIT.PULPIT) 'Дисцплины кафедры' from PULPIT;


--ex3
go
create function FFACPUL(@faculty varchar(20), @pulpit varchar(20)) returns table
as return 
	select FACULTY.FACULTY,PULPIT.PULPIT from
		FACULTY left outer join PULPIT
		on FACULTY.FACULTY = PULPIT.FACULTY
		where FACULTY.FACULTY = isnull(@faculty,FACULTY.FACULTY)and
			PULPIT.PULPIT = isnull(@pulpit,PULPIT.PULPIT);

--DROP FUNCTION FFACPUL;

select * from dbo.FFACPUL(NULL,NULL);
select * from dbo.FFACPUL('ТТЛП',NULL);
select * from dbo.FFACPUL(NULL,'ИСиТ');
select * from dbo.FFACPUL('ЛХ','ТиП');
select * from dbo.FFACPUL('ЛХ','ПИ');

--ex4
go
create function FTEACHER (@pulpit varchar(20)) returns int
as begin
		declare @result int = 0;
		set @result  = (select count(*) from
									TEACHER inner join PULPIT
									on TEACHER.PULPIT = PULPIT.PULPIT
									where PULPIT.PULPIT = isnull(@pulpit,PULPIT.PULPIT));
		return @result;
end;

--DROP FUNCTION FTEACHER;

select PULPIT, dbo.FTEACHER(PULPIT.PULPIT) 'Количество преподавателей ☺' from PULPIT;
select dbo.FTEACHER(NULL) 'Всего преподавателей';

--ex6
drop function if exists FACULTY_REPORT
go
CREATE FUNCTION dbo.FACULTY_REPORT(@c INT) 
RETURNS @fr TABLE
(
    [Факультет] VARCHAR(50), 
    [Количество кафедр] INT, 
    [Количество групп] INT, 
    [Количество студентов] INT, 
    [Количество специальностей] INT
)
AS 
BEGIN 
    DECLARE cc CURSOR STATIC FOR 
        SELECT FACULTY 
        FROM FACULTY 
        WHERE dbo.COUNT_STUDENTS(FACULTY) > @c; 

    DECLARE @f VARCHAR(30);
    OPEN cc;  
    FETCH cc INTO @f;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT @fr VALUES
        ( 
            @f, 
            dbo.FTEACHER(@f),
            (SELECT COUNT(IDGROUP) FROM GROUPS WHERE FACULTY = @f),
            dbo.COUNT_STUDENTS(@f),
            (SELECT COUNT(PROFESSION) FROM PROFESSION WHERE FACULTY = @f)
        ); 
        FETCH cc INTO @f;  
    END;   
    CLOSE cc;
    DEALLOCATE cc;
    RETURN; 
END;
GO


SELECT * FROM dbo.FACULTY_REPORT(10);


