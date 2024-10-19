
--ex2
use VOR_MyBase;
begin try
	begin tran
		delete ������ where ��������_���������� = 11;
		insert into ������ values(4,'������','��� ��������', 11, '1990-10-11');
		update ������ set ��������_����������� = '30' where ��������_���������� = 11;
	commit tran;
end try

begin catch
	print '������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0 rollback tran;
end catch;

--ex3


DECLARE @savepoint varchar(30);
begin try
	begin tran

		update ������ set ��������_���������� = '30' where ��������_����������='10';		
		set @savepoint = 'save3'; save transaction @savepoint;

		insert into ������ values(12,'������','��� ��������', 12, '1990-11-1');							
		set @savepoint = 'save2'; save transaction @savepoint;

		delete ������ where ID_������� = 12;									
		set @savepoint = 'save1'; save transaction @savepoint;

	commit tran;
end try

begin catch
	print '������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0
		begin
			print '����������� �����: ' + @savepoint;
			rollback tran @savepoint;
		
			commit tran;
		end;
end catch;	

insert into ������ values(12,'������','��� ��������', 12, '1990-11-1');	

--ex4

	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID 'SID', 'insert �����������' '���������', * from ����������� 
	                                                                where ��������_����������� = '��� ���2';
								 									             
	select @@SPID 'SID', 'update ������'  '���������',  * from ������   where  ID_������� = 2;
	commit; 
	-------------------------- t2 -----------------

--- B --	
	begin transaction 
	select @@SPID 'SID';
	INSERT into ����������� values('��� ���2',123, 1);   
	update ������ set ��������_���������� = '15' where ID_������� = 2;	
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;

	delete ����������� where ��������_����������� = '��� ���2';

--ex5


-- A ---
    set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from ������ where ��������_���������� = 10;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select 'update ������'  '���������', count(*) from ������   where  ��������_����������= 10;
	commit; 

	--- B ---	
	begin transaction 	

	-------------------------- t1 --------------------
    update ������ set ��������_���������� = 30 where ��������_���������� = 10;	

      commit; 
	-------------------------- t2 --------------------	

--ex6 

-- A ---
    set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select * from ������ where ��������_����������� = '��� ���';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
          when ��������_����������� = '��� ���' then 'insert  ������'  else ' ' 
end '���������', ��������_����������� from ������  where ��������_���������� = 20;
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert ������ values (20,  '������',  '��� ���',  20,  '01.12.2014');
          commit; 
	-------------------------- t2 --------------------

--ex7


 -- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
	delete ������ where ��������_����������� = '��� ���';  
          insert ������ values (15,  '������',  '��� ����',  20,  '01.12.2014');
          update ������ set ��������_����������� = '��� ���' where ID_������� = 15;
          select  ��������_����������� from ������  where ��������_���������� = 20;
	-------------------------- t1 -----------------
	 select  ��������_����������� from ������  where ��������_���������� = 20;
	-------------------------- t2 ------------------ 
	commit; 	

	--- B ---	
	begin transaction 	  
	delete ������ where ��������_����������� = '��� ���';  
          insert ������ values (15,  '������',  '��� ����',  20,  '01.12.2014');
          update ������ set ��������_����������� = '��� ���' where ID_������� = 15;
          select  ��������_����������� from ������  where ��������_���������� = 20;
          -------------------------- t1 --------------------
          commit; 
          select  ��������_����������� from ������  where ��������_���������� = 20;
      -------------------------- t2 --------------------

--ex8

delete ������ where ID_������� = 18;

begin tran
		insert ������ values (18,  '������',  '��� ����',  20,  '01.12.2014');
		begin tran
		update ������ set ��������_����������� ='��� ���' where ��������_�����������='��� ����';
		commit
		if @@TRANCOUNT > 0 rollback;
select
		(select count(*) from ������ where ��������_����������� ='��� ���')