insert into COMPANIES values ('EPAM','photo/pict3.jpg')
delete COMPANIES where Company = 'LeverX'
insert into ADS values (10000,'2024-04-18','IT','EPAM')

select * from COMPANIES inner join ADS on COMPANIES.Company = ADS.Company


CREATE PROCEDURE InsertAndReturnId
    @Salary int,
	@CreatedDate Date,
	@ProfessionType varchar(100),
	@Company varchar(50)

AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @InsertedId INT;

    INSERT INTO ADS 
    VALUES (@Salary,@CreatedDate,@ProfessionType,@Company);

    SET @InsertedId = SCOPE_IDENTITY();

    SELECT @InsertedId AS InsertedId;
END;


CREATE PROCEDURE InsertCompanyAndAd
    @Salary int,
	@CreatedDate Date,
	@ProfessionType varchar(100),
	@Company varchar(50),
	@Logotype varchar(100),
	@AdId int OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CompanyId INT;

    -- Проверяем наличие компании в таблице COMPANIES
    IF NOT EXISTS (SELECT 1 FROM COMPANIES WHERE Company = @Company)
    BEGIN
        -- Добавляем новую компанию, если она отсутствует
        INSERT INTO COMPANIES (Company, Logotype)
        VALUES (@Company, @Logotype);
    END

    -- Добавляем объявление в таблицу ADS
    INSERT INTO ADS 
    VALUES (@Salary,@CreatedDate,@ProfessionType,@Company);

    -- Получаем идентификатор добавленного объявления
    SET @AdId = SCOPE_IDENTITY();
END;

declare @LastAdId int;
exec InsertCompanyAndAd 3300,'2024-04-10','IT','ITechArt','photo/pict3.jpg',@LastAdId OUTPUT
select @LastAdId
