use VOR_MyBase

SELECT *
  FROM [dbo].[Предприятие]


Create VIEW [Company]
as select Название_предприятия[Name], Банковские_реквизиты[Requisites], ID_Контактного_лица[Contact person ID]
	from [dbo].[Предприятие];

select * from [Company];

drop view[Company];


Create VIEW[Количество_анализов]
as select Название_показателя, COUNT(Название_показателя)[Количество]
	from Анализ
		group by Название_показателя;

select * from [Количество_анализов];

drop view[Количество_анализов];

create VIEW[Предприятия ооо]
as select Название_предприятия, Банковские_реквизиты 
from Предприятие 
where Предприятие.Название_предприятия like 'ооо%'

INSERT [Предприятия ооо] values('оао компи', 123);

select * from [Предприятия ооо];
select * from Предприятие;

drop view[Предприятия ооо];

create VIEW[Предприятия только ооо]
as select Название_предприятия, Банковские_реквизиты 
from Предприятие 
where Предприятие.Название_предприятия like 'ооо%' WITH CHECK OPTION

INSERT [Предприятия только ооо] values('оао коми', 123);

select * from [Предприятия только ооо];

drop view[Предприятия только ооо];


ALTER VIEW [Количество_анализов] with SCHEMABINDING
as select Название_показателя, COUNT(Название_показателя)[Количество]
	from dbo.Анализ
		group by Название_показателя;

ALTER TABLE Анализ DROP COLUMN Название_показателя;