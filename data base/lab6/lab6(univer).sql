use UNIVER;


select AUDITORIUM.AUDITORIUM_TYPE, 
	MAX(AUDITORIUM_CAPACITY)[Максимальная вместимость],
	MIN(AUDITORIUM_CAPACITY)[ Минимальная вместимось],
	AVG(AUDITORIUM_CAPACITY)[Средняя вместимость],
	SUM(AUDITORIUM_CAPACITY)[Суммарная вместимость аудитории],
	COUNT(AUDITORIUM_CAPACITY)[Количество аудиторий]
from AUDITORIUM inner join AUDITORIUM_TYPE
	on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE
	group by AUDITORIUM.AUDITORIUM_TYPE


select *
from (select case
                 when (PROGRESS.NOTE between 4 and 7) then '4-7'
                 when (PROGRESS.NOTE between 8 and 10) then '8-10'
                 when (PROGRESS.NOTE between 1 and 3) then '1-3'
				 end [NOTE],
				 count(*)[Количество]
		from PROGRESS
		group by case
				   when (PROGRESS.NOTE between 4 and 7) then '4-7'
                 when (PROGRESS.NOTE between 8 and 10) then '8-10'
                 when (PROGRESS.NOTE between 1 and 3) then '1-3'
                   end
     ) as a 
order by case a.NOTE
			   when '4-7' then 2
               when '8-10' then 1
               when '1-3' then 3
               end


select a.FACULTY,
       G.PROFESSION,
	   G.IDGROUP,
       round(avg(cast(NOTE AS float(4))), 2) as [Средняя оценка]
from FACULTY a
         inner join GROUPS G on a.FACULTY = G.FACULTY
         inner join STUDENT S on G.IDGROUP = S.IDGROUP
         inner join PROGRESS P on S.IDSTUDENT = P.IDSTUDENT
group by a.FACULTY, G.PROFESSION, G.IDGROUP
order by [Средняя оценка] desc



select a.FACULTY,
       G.PROFESSION,
	   G.IDGROUP,
	   P.SUBJECT,
       round(avg(cast(NOTE AS float(4))), 2) as [Средняя оценка]
from FACULTY a
         inner join GROUPS G on a.FACULTY = G.FACULTY
         inner join STUDENT S on G.IDGROUP = S.IDGROUP
         inner join PROGRESS P on S.IDSTUDENT = P.IDSTUDENT
where P.SUBJECT like 'СУБД' or P.SUBJECT like 'ОАиП'
group by a.FACULTY, G.PROFESSION, G.YEAR_FIRST, P.SUBJECT, G.IDGROUP
order by [Средняя оценка] desc



SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT,FACULTY.FACULTY, AVG(PROGRESS.NOTE) AS [средняя оценка]
FROM GROUPS
INNER JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
INNER JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
WHERE FACULTY.FACULTY like 'ТОВ'
GROUP BY GROUPS.PROFESSION, PROGRESS.SUBJECT, FACULTY.FACULTY



select PROGRESS.[SUBJECT], 
	   count(PROGRESS.NOTE) as [Количество 8, 9]
from
PROGRESS 
group by PROGRESS.[SUBJECT], PROGRESS.NOTE
having PROGRESS.NOTE in (8,9)
