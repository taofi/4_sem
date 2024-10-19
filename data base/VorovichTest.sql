--������ ������ ��������� ������� 4

create database AudBD
go

use AudBD;

create table AUD_TYPE(
	Kod_AUD int primary key,
	Name_AUD nvarchar(30) 
)

create table AUD(
	Kod_A int primary key,
	Tip_AUD int foreign key REFERENCES AUD_TYPE(Kod_AUD),
	Vmest_AUD int default 20 check ( Vmest_AUD >= 20) not null
)

insert into AUD_TYPE(Kod_AUD, Name_AUD) values (1, '������������ �����')
insert into AUD_TYPE(Kod_AUD, Name_AUD) values (2, '������������ �����')
insert into AUD_TYPE(Kod_AUD, Name_AUD) values (3, '���������')
insert into AUD_TYPE(Kod_AUD, Name_AUD) values (4, '������������ ����� �������')
insert into AUD_TYPE(Kod_AUD, Name_AUD) values (5, '�����������')
insert into AUD_TYPE(Kod_AUD, Name_AUD) values (6, '�����')
insert into AUD_TYPE(Kod_AUD, Name_AUD) values (7, '������������ ����� ���������')

insert into AUD(Kod_A, Tip_AUD, Vmest_AUD) values(100, 1, 30)
insert into AUD(Kod_A, Tip_AUD, Vmest_AUD) values(102, 2, 25)
insert into AUD(Kod_A, Tip_AUD, Vmest_AUD) values(103, 1, 35)
insert into AUD(Kod_A, Tip_AUD, Vmest_AUD) values(104, 3, 50)
insert into AUD(Kod_A, Tip_AUD, Vmest_AUD) values(105, 6, 35)
insert into AUD(Kod_A, Tip_AUD, Vmest_AUD) values(106, 7, 20)
insert into AUD(Kod_A, Tip_AUD, Vmest_AUD) values(107, 4, 45)
insert into AUD(Kod_A, Tip_AUD, Vmest_AUD) values(108, 5, 30)
 

 select Kod_A, Name_AUD
 from AUD_TYPE inner join AUD
 on Kod_AUD = Tip_AUD where Name_AUD like '%���������%'


 select b.Tip_AUD, b.Vmest_AUD from
	AUD as b 
	where b.Vmest_AUD = (select top(1) ��.Vmest_AUD from AUD as ��
									where ��.Tip_AUD = b.Tip_AUD
									order by ��.Vmest_AUD desc) order by b.Vmest_AUD 

