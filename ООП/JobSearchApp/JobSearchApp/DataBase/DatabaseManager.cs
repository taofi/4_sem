using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace JobSearchApp.DataBase
{
    public class DatabaseManager
    {
        private string connectionString;

         


        public DatabaseManager(string connectionString)
        {
            this.connectionString = connectionString;
            InitializeDatabase();
        }
        private void InitializeDatabase()
        {
            // Установка соединения с мастер базой для создания новой БД, если она не существует
            var masterConnection = new SqlConnection("Data Source=.;Integrated Security=True;Initial Catalog=master;");
            try
            {
                masterConnection.Open();
                var dbName = new SqlConnectionStringBuilder(connectionString).InitialCatalog;

                // Создание базы данных, если она не существует
                var sqlCreateDB = $"IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'{dbName}') " +
                                  $"CREATE DATABASE [{dbName}]";
                var createDBCommand = new SqlCommand(sqlCreateDB, masterConnection);
                createDBCommand.ExecuteNonQuery();

                // Соединение с только что созданной базой данных для создания таблиц
                using (var dbConnection = new SqlConnection(connectionString))
                {
                    dbConnection.Open();

                    // Создание таблицы ADS, если она не существует
                    var sqlCreateAdsTable = @"
                    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'ADS')
                    CREATE TABLE [dbo].[ADS] (
                        [AdCode] INT NOT NULL PRIMARY KEY IDENTITY,
                        [Salary] INT NOT NULL,
                        [CreateDate] DATETIME NOT NULL,
                        [ProfessionType] NVARCHAR(100) NOT NULL,
                        [Company] NVARCHAR(255) NOT NULL
                    );";

                    // Создание таблицы COMPANIES, если она не существует
                    var sqlCreateCompaniesTable = @"
                    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'COMPANIES')
                    CREATE TABLE [dbo].[COMPANIES] (
                        [CompanyId] INT NOT NULL PRIMARY KEY IDENTITY,
                        [Company] NVARCHAR(255) NOT NULL,
                        [Logotype] NVARCHAR(500) NULL
                    );";
                    var cmdCreateProcedure = new SqlCommand(@"
                 IF OBJECT_ID('InsertCompanyAndAd', 'P') IS NULL
            BEGIN
                EXEC('CREATE PROCEDURE InsertCompanyAndAd
                      @Salary INT,
                      @CreatedDate DATETIME,
                      @ProfessionType NVARCHAR(100),
                      @Company NVARCHAR(255),
                      @Logotype NVARCHAR(255),
                      @AdId INT OUTPUT
                      AS
                      BEGIN
                          INSERT INTO COMPANIES (Company, Logotype)
                          VALUES (@Company, @Logotype);

                          DECLARE @CompanyId INT = SCOPE_IDENTITY();

                          INSERT INTO ADS (Salary, CreateDate, ProfessionType, Company)
                          VALUES (@Salary, @CreatedDate, @ProfessionType, @CompanyId);

                          SET @AdId = SCOPE_IDENTITY();
                      END')
            END", dbConnection);

                    cmdCreateProcedure.ExecuteNonQuery();
                    var createAdsTableCommand = new SqlCommand(sqlCreateAdsTable, dbConnection);
                    createAdsTableCommand.ExecuteNonQuery();

                    var createCompaniesTableCommand = new SqlCommand(sqlCreateCompaniesTable, dbConnection);
                    createCompaniesTableCommand.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при инициализации базы данных: {ex.Message}", "Ошибка БД", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {
                masterConnection.Close();
            }
        }
        public DataTable ExecuteQuery(string query)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Создать новую бд чтобы работало
                    DataTable dataTable = new DataTable();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        dataTable.Load(reader);
                    }
                    return dataTable;
                }
            }
        }

        public int ExecuteNonQuery(string query)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    return command.ExecuteNonQuery();
                }
            }
        }

        public void ExecuteTransaction(params string[] queries)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlTransaction transaction = connection.BeginTransaction();

                try
                {
                    foreach (string query in queries)
                    {
                        using (SqlCommand command = new SqlCommand(query, connection, transaction))
                        {
                            command.ExecuteNonQuery();
                        }
                    }

                    transaction.Commit();
                    //MessageBox.Show("Транзакция завершена успешно.");
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Произошла ошибка: " + ex.Message + "Транзакция отменена.");
                    transaction.Rollback();
                }
            }
        }

        public void InsertCompanyAndAd(int salary, DateTime createdDate, string professionType, string company, string logotype, out int adId)
        {
            adId = -1; // Инициализируем значение выходного параметра

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "InsertCompanyAndAd";

                    // Добавляем параметры процедуры
                    command.Parameters.AddWithValue("@Salary", salary);
                    command.Parameters.AddWithValue("@CreatedDate", createdDate);
                    command.Parameters.AddWithValue("@ProfessionType", professionType);
                    command.Parameters.AddWithValue("@Company", company);
                    command.Parameters.AddWithValue("@Logotype", logotype);

                    // Добавляем выходной параметр
                    SqlParameter adIdParameter = command.Parameters.Add("@AdId", SqlDbType.Int);
                    adIdParameter.Direction = ParameterDirection.Output;

                    // Выполняем запрос
                    command.ExecuteNonQuery();

                    // Получаем значение выходного параметра
                    adId = (int)adIdParameter.Value;
                }
            }
        }
    }
}
