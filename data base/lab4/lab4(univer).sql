use UNIVER

select AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
	from AUDITORIUM_TYPE inner join AUDITORIUM
	on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE;

select AUDITORIUM_TYPE.AUDITORIUM_TYPENAME, AUDITORIUM.AUDITORIUM_NAME
	from AUDITORIUM_TYPE inner join AUDITORIUM
	on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE AND AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%���������%';

select FACULTY.FACULTY as ���������, PULPIT.PULPIT as �������, GROUPS.PROFESSION as �������������, SUBJECT.SUBJECT as ����������, STUDENT.NAME as ���,
	case
        when PROGRESS.NOTE = 6 then '�����'
        when PROGRESS.NOTE = 7 then '����'
        when PROGRESS.NOTE = 8 then '������'
        else '�� �������'
    end as [������]
	from PROGRESS inner join STUDENT
	on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
		inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
	inner join SUBJECT on PROGRESS.SUBJECT=SUBJECT.SUBJECT
	inner join PULPIT on SUBJECT.PULPIT=PULPIT.PULPIT
	inner join FACULTY on PULPIT.FACULTY=FACULTY.FACULTY
	where PROGRESS.NOTE between 6 and 8
	order by PROGRESS.NOTE

select PULPIT.PULPIT as �������, isnull(TEACHER.TEACHER_NAME, '***') as �������������
from PULPIT left outer join TEACHER
on PULPIT.PULPIT = TEACHER.PULPIT




select ISNULL(PROGRESS.SUBJECT, '***') as ����������, STUDENT.NAME as ���, ISNULL(PROGRESS.NOTE,'-') as ������
from STUDENT full outer join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
order by PROGRESS.SUBJECT

select ISNULL(PROGRESS.SUBJECT, '***') as ����������, STUDENT.NAME as ���, ISNULL(PROGRESS.NOTE,'-') as ������
from PROGRESS full outer join STUDENT
on PROGRESS.IDSTUDENT=STUDENT.IDSTUDENT 
order by PROGRESS.SUBJECT

select ISNULL(PROGRESS.SUBJECT, '***') as ����������, STUDENT.NAME as ���, ISNULL(PROGRESS.NOTE,'-') as ������
from STUDENT left outer join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
order by PROGRESS.SUBJECT

select ISNULL(PROGRESS.SUBJECT, '***') as ����������, STUDENT.NAME as ���, ISNULL(PROGRESS.NOTE,'-') as ������
from STUDENT right outer join PROGRESS
on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
order by PROGRESS.SUBJECT

select count(*)
from STUDENT full outer join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where PROGRESS.IDSTUDENT is null

select count(*)
from STUDENT left outer join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where PROGRESS.IDSTUDENT is null

select count(*)
from STUDENT right outer join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where PROGRESS.IDSTUDENT is null

select AUDITORIUM.AUDITORIUM,AUDITORIUM.AUDITORIUM_TYPE
	from AUDITORIUM_TYPE cross join AUDITORIUM
	where AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE