use VOR_MyBase

SELECT *
  FROM [dbo].[�����������]


Create VIEW [Company]
as select ��������_�����������[Name], ����������_���������[Requisites], ID_�����������_����[Contact person ID]
	from [dbo].[�����������];

select * from [Company];

drop view[Company];


Create VIEW[����������_��������]
as select ��������_����������, COUNT(��������_����������)[����������]
	from ������
		group by ��������_����������;

select * from [����������_��������];

drop view[����������_��������];

create VIEW[����������� ���]
as select ��������_�����������, ����������_��������� 
from ����������� 
where �����������.��������_����������� like '���%'

INSERT [����������� ���] values('��� �����', 123);

select * from [����������� ���];
select * from �����������;

drop view[����������� ���];

create VIEW[����������� ������ ���]
as select ��������_�����������, ����������_��������� 
from ����������� 
where �����������.��������_����������� like '���%' WITH CHECK OPTION

INSERT [����������� ������ ���] values('��� ����', 123);

select * from [����������� ������ ���];

drop view[����������� ������ ���];


ALTER VIEW [����������_��������] with SCHEMABINDING
as select ��������_����������, COUNT(��������_����������)[����������]
	from dbo.������
		group by ��������_����������;

ALTER TABLE ������ DROP COLUMN ��������_����������;