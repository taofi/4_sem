
--ex2
use VOR_MyBase;
begin try
	begin tran
		delete Анализ where Значение_показателя = 11;
		insert into Анализ values(4,'Убытки','ооо стройбат', 11, '1990-10-11');
		update Анализ set Название_предприятия = '30' where Значение_показателя = 11;
	commit tran;
end try

begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0 rollback tran;
end catch;

--ex3


DECLARE @savepoint varchar(30);
begin try
	begin tran

		update Анализ set Значение_показателя = '30' where Значение_показателя='10';		
		set @savepoint = 'save3'; save transaction @savepoint;

		insert into Анализ values(12,'Убытки','ооо стройбат', 12, '1990-11-1');							
		set @savepoint = 'save2'; save transaction @savepoint;

		delete Анализ where ID_Анализа = 12;									
		set @savepoint = 'save1'; save transaction @savepoint;

	commit tran;
end try

begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0
		begin
			print 'Контрольная точка: ' + @savepoint;
			rollback tran @savepoint;
		
			commit tran;
		end;
end catch;	

insert into Анализ values(12,'Убытки','ооо стройбат', 12, '1990-11-1');	

--ex4

	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID 'SID', 'insert Предприятие' 'результат', * from Предприятие 
	                                                                where Название_предприятия = 'ооо сто2';
								 									             
	select @@SPID 'SID', 'update Анализ'  'результат',  * from Анализ   where  ID_Анализа = 2;
	commit; 
	-------------------------- t2 -----------------

--- B --	
	begin transaction 
	select @@SPID 'SID';
	INSERT into Предприятие values('ооо сто2',123, 1);   
	update Анализ set Значение_показателя = '15' where ID_Анализа = 2;	
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;

	delete Предприятие where Название_предприятия = 'ооо сто2';

--ex5


-- A ---
    set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from Анализ where Значение_показателя = 10;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select 'update Анализ'  'результат', count(*) from Анализ   where  Значение_показателя= 10;
	commit; 

	--- B ---	
	begin transaction 	

	-------------------------- t1 --------------------
    update Анализ set Значение_показателя = 30 where Значение_показателя = 10;	

      commit; 
	-------------------------- t2 --------------------	

--ex6 

-- A ---
    set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select * from Анализ where Название_предприятия = 'ооо сто';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
          when Название_предприятия = 'ооо сто' then 'insert  Анализ'  else ' ' 
end 'результат', Название_предприятия from Анализ  where Значение_показателя = 20;
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert Анализ values (20,  'Убытки',  'ооо сто',  20,  '01.12.2014');
          commit; 
	-------------------------- t2 --------------------

--ex7


 -- A ---
          set transaction isolation level SERIALIZABLE 
	begin transaction 
	delete Анализ where Название_предприятия = 'ооо сто';  
          insert Анализ values (15,  'Убытки',  'ооо банк',  20,  '01.12.2014');
          update Анализ set Название_предприятия = 'ооо сто' where ID_Анализа = 15;
          select  Название_предприятия from Анализ  where Значение_показателя = 20;
	-------------------------- t1 -----------------
	 select  Название_предприятия from Анализ  where Значение_показателя = 20;
	-------------------------- t2 ------------------ 
	commit; 	

	--- B ---	
	begin transaction 	  
	delete Анализ where Название_предприятия = 'ооо сто';  
          insert Анализ values (15,  'Убытки',  'ооо банк',  20,  '01.12.2014');
          update Анализ set Название_предприятия = 'ооо сто' where ID_Анализа = 15;
          select  Название_предприятия from Анализ  where Значение_показателя = 20;
          -------------------------- t1 --------------------
          commit; 
          select  Название_предприятия from Анализ  where Значение_показателя = 20;
      -------------------------- t2 --------------------

--ex8

delete Анализ where ID_Анализа = 18;

begin tran
		insert Анализ values (18,  'Убытки',  'ооо банк',  20,  '01.12.2014');
		begin tran
		update Анализ set Название_предприятия ='ооо сто' where Название_предприятия='ооо банк';
		commit
		if @@TRANCOUNT > 0 rollback;
select
		(select count(*) from Анализ where Название_предприятия ='ооо сто')