using JobSearchApp.model;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
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
    public partial class EditVacancyWindow : Window
    {
        public event EventHandler<VacancyEditedEventArgs> VacancyEdited;
        private string path = "";

        private Vacancy _originalVacancy;
        private Vacancy _editedVacancy;

        public EditVacancyWindow(Vacancy vacancy)
        {
            InitializeComponent();

            Cursor = new Cursor(
                Application.GetResourceStream(
                    new Uri("photo/dog.cur", UriKind.Relative)).Stream);
            // Клонируем выбранную вакансию для редактирования
            _originalVacancy = vacancy;
            _editedVacancy = new Vacancy(vacancy.CompanyName,vacancy.CompanyLogo, vacancy.JobTitle, vacancy.Salary, vacancy.DateAdded, vacancy.Id);

            // Заполняем поля формы данными выбранной вакансии
            companyNameTextBox.Text = _editedVacancy.CompanyName;
            path = _editedVacancy.CompanyLogo;
            jobTitleTextBox.Text = _editedVacancy.JobTitle;
            salaryTextBox.Text = _editedVacancy.Salary.ToString();
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            string projectFolder = Directory.GetParent(Directory.GetCurrentDirectory()).Parent.FullName;
            string fullPath;
            if (string.IsNullOrEmpty(companyNameTextBox.Text) ||
               string.IsNullOrEmpty(path) ||
               string.IsNullOrEmpty(jobTitleTextBox.Text) ||
               string.IsNullOrEmpty(salaryTextBox.Text))
            {
                MessageBox.Show("Все поля должны быть заполнены!");
                return;
            }
            else
            {
                fullPath = System.IO.Path.Combine(projectFolder, path);
            }

            if (!Regex.IsMatch(this.salaryTextBox.Text, @"^\d+$") || !File.Exists(fullPath))
            {
                MessageBox.Show("Поля заполнены некорректно");
                return;
            }

            // Обновляем данные выбранной вакансии данными из формы 
            _editedVacancy.CompanyName = companyNameTextBox.Text;
            _editedVacancy.CompanyLogo = path;
            _editedVacancy.JobTitle = jobTitleTextBox.Text;
            int salary;
            if (int.TryParse(salaryTextBox.Text, out salary))
            {
                _editedVacancy.Salary = salary;
            }
            _editedVacancy.DateAdded =  DateTime.Now;


            // Вызываем событие для сообщения о сохранении изменений
            OnVacancyEdited(_editedVacancy);

            Close();
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }


        // Метод для вызова события VacancyEdited
        protected virtual void OnVacancyEdited(Vacancy editedVacancy)
        {
            VacancyEdited?.Invoke(this, new VacancyEditedEventArgs(editedVacancy));
        }

        public class VacancyEditedEventArgs : EventArgs
        {
            public Vacancy EditedVacancy { get; }

            public VacancyEditedEventArgs(Vacancy editedVacancy)
            {
                EditedVacancy = editedVacancy;
            }
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
        private void ImgButton_Click(object sender, RoutedEventArgs e)
        {
            path = SelectImage();
        }
    }
}
