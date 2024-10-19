using JobSearchApp.DataBase;
using JobSearchApp.model;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace JobSearchApp
{
    /// <summary>
    /// Логика взаимодействия для AddVacancyWindow.xaml
    /// </summary>
    public partial class AddVacancyWindow : Window
    {
        DatabaseManager dbManager;
        public event EventHandler<VacancyAddedEventArgs> VacancyAdded;
        private string path = "";

        public AddVacancyWindow(DatabaseManager dbManager)
        {
            InitializeComponent();

            this.dbManager = dbManager;
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            string projectFolder = Directory.GetParent(Directory.GetCurrentDirectory()).Parent.FullName;

            string fullPath = "";
            if (!(string.IsNullOrEmpty(this.JobTitle_textBox.Text) ||
               string.IsNullOrEmpty(this.CompanyName_textBox.Text) ||
               string.IsNullOrEmpty(path) ||
               string.IsNullOrEmpty(this.Salary_textBox.Text)))
            {
                fullPath = path;
            }
            else
            {
                MessageBox.Show("Все поля должны быть заполнены");
                return;
            }

            if (!Regex.IsMatch(this.Salary_textBox.Text, @"^\d+$") )
            {
                MessageBox.Show("Зарплата указана неверно ");
                return;
            }
            if(!File.Exists(fullPath))
            {
                MessageBox.Show("неверный путь к изображению");
                return;
            }

            int lastId;
            dbManager.InsertCompanyAndAd(Convert.ToInt32(this.Salary_textBox.Text), DateTime.Now, this.JobTitle_textBox.Text, this.CompanyName_textBox.Text, path, out lastId);

            string getValueQuery = $"SELECT AdCode, Salary, CreateDate, ProfessionType, Logotype, COMPANIES.Company FROM ADS inner join COMPANIES on ADS.Company = COMPANIES.Companyid WHERE ADS.AdCode = {lastId}";
            DataTable result = dbManager.ExecuteQuery(getValueQuery);

            DataRow row = result.Rows[0];  
            string companyName = row["Company"] as string;  
            string companyLogo = row["Logotype"] as string;  
            string professionType = row["ProfessionType"] as string;
            int salary = (int)row["Salary"];
            DateTime createDate = (DateTime)row["CreateDate"];
            int id = (int)row["AdCode"];
            Vacancy newVacancy = new Vacancy(
                companyName,
                companyLogo,
                professionType,
                salary,
                createDate,
                id
                );

            // Вызываем событие для сообщения о добавлении вакансии
            OnVacancyAdded(newVacancy);

            Close();
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        protected virtual void OnVacancyAdded(Vacancy newVacancy)
        {
            VacancyAdded?.Invoke(this, new VacancyAddedEventArgs(newVacancy));
        }
        public static string SelectImage()
        {
            OpenFileDialog openFileDialog = new OpenFileDialog
            {
                Filter = "Image files (*.png;*.jpeg;*.jpg;*.bmp;*.jfif)|*.png;*.jpeg;*.jpg;*.bmp;*.jfif", // Фильтр форматов изображений
                Title = "Select an Image"
            };

            if (openFileDialog.ShowDialog() == true)
            {
                return openFileDialog.FileName;
            }
            else
            {
                return null;
            }
        }
        public class VacancyAddedEventArgs : EventArgs
        {
            public Vacancy NewVacancy { get; }

            public VacancyAddedEventArgs(Vacancy newVacancy)
            {
                NewVacancy = newVacancy;
            }
        }

        private void ImgButton_Click(object sender, RoutedEventArgs e)
        {
            path = SelectImage();
        }
    }
}
