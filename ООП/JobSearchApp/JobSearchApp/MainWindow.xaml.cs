using JobSearchApp.model;
using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using static JobSearchApp.AddVacancyWindow;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Data.Odbc;
using System.Configuration;
using JobSearchApp.DataBase;
using System.Reflection;

namespace JobSearchApp
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        DatabaseManager dbManager;
        private ObservableCollection<Vacancy> _vacancies;
        public ObservableCollection<Vacancy> Vacancies {
            get
            {
                return _vacancies;
            } 
            set
            {
                this.listBox.ItemsSource = value;
                _vacancies = value;
                OnPropertyChanged("Vacancies");

                Serializer.Serializer.SerializationList(_vacancies, "Serializer/serializeList.json");
            }

        }
        private void Control_MouseDown(object sender, MouseButtonEventArgs e)
        {
            textBlock1.Text = textBlock1.Text + "sender: " + sender.ToString() + "\n";
            textBlock1.Text = textBlock1.Text + "source: " + e.Source.ToString() + "\n\n";
            e.Handled = false;
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public void OnPropertyChanged([CallerMemberName] string propName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propName));
        }
        public MainWindow()
        {
            InitializeComponent();

            Vacancies = new ObservableCollection<Vacancy>();

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            dbManager = new DatabaseManager(connectionString);

            
            string getValuesQuery = "SELECT AdCode, Salary, CreateDate, ProfessionType, Logotype, COMPANIES.Company FROM ADS inner join COMPANIES on ADS.Company = COMPANIES.Companyid";
            DataTable result = dbManager.ExecuteQuery(getValuesQuery);

            foreach(DataRow row in result.Rows)
            {
                string companyName = row["Company"] as string;
                string companyLogo = row["Logotype"] as string;
                string professionType = row["ProfessionType"] as string;
                int salary = (int)row["Salary"];
                DateTime createDate = (DateTime)row["CreateDate"];
                int id = (int)row["AdCode"];
                Vacancy obj = new Vacancy(
                    companyName,
                    companyLogo,
                    professionType,
                    salary,
                    createDate,
                    id
                    );
                Vacancies.Add(obj);
            }
            DataContext = this;
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            AddVacancyWindow addVacancyWindow = new AddVacancyWindow(dbManager);
            addVacancyWindow.Owner = this;
            addVacancyWindow.VacancyAdded += AddVacancyWindow_VacancyAdded; // Подписываемся на событие
            addVacancyWindow.ShowDialog();
        }
        private void AddVacancyWindow_VacancyAdded(object sender, VacancyAddedEventArgs e)
        {
            Vacancies.Add(e.NewVacancy);

            //Serializer.Serializer.SerializationList(Vacancies, "Serializer/serializeList.json");
        }
        private void EditButton_Click(object sender, RoutedEventArgs e)
        {
            Vacancy selectedVacancy = listBox.SelectedItem as Vacancy;

            if (selectedVacancy != null)
            {
                EditVacancyWindow editVacancyWindow = new EditVacancyWindow(selectedVacancy);
                editVacancyWindow.Owner = this;

                editVacancyWindow.VacancyEdited += (source, editedArgs) =>
                {
                    int index = Vacancies.IndexOf(selectedVacancy);
                    if (index != -1)
                    {
                        string getCompanyIdQuery = $"SELECT Company FROM ADS WHERE AdCode = '{editedArgs.EditedVacancy.Id}'";
                        DataTable result = dbManager.ExecuteQuery(getCompanyIdQuery);

                        int companyId = -1;
                        companyId = Convert.ToInt32(result.Rows[0]["Company"]);

                        string updateAdsQuery = $"UPDATE ADS SET Company = {companyId}, ProfessionType = '{editedArgs.EditedVacancy.JobTitle}', Salary = {editedArgs.EditedVacancy.Salary}, " +
                        $"CreateDate = '{editedArgs.EditedVacancy.DateAdded}' " +
                        $"WHERE AdCode = {editedArgs.EditedVacancy.Id}";

                        string updateCompaniesQuery = $"UPDATE COMPANIES SET Logotype = '{editedArgs.EditedVacancy.CompanyLogo}', Company = '{editedArgs.EditedVacancy.CompanyName}' WHERE CompanyId = {companyId}";
                        dbManager.ExecuteTransaction(updateAdsQuery, updateCompaniesQuery);

                        Vacancies[index] = editedArgs.EditedVacancy;

                        listBox.Items.Refresh();
                    }
                };
                editVacancyWindow.ShowDialog();
            }
            else
            {
                MessageBox.Show("Please select a vacancy to edit.", "No Vacancy Selected", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            //Serializer.Serializer.SerializationList(Vacancies, "Serializer/serializeList.json");
        }
        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            Vacancy selectedVacancy = listBox.SelectedItem as Vacancy;

            if (selectedVacancy != null)
            {
                MessageBoxResult result = MessageBox.Show("Are you sure you want to delete this vacancy?", "Confirm Delete", MessageBoxButton.YesNo, MessageBoxImage.Question);

                if (result == MessageBoxResult.Yes)
                {
                    Vacancies.Remove(selectedVacancy);

                    string deleteQuery = $"DELETE ADS WHERE AdCode = {selectedVacancy.Id}";
                    int affectedRows = dbManager.ExecuteNonQuery(deleteQuery);
                }
            }
            else
            {
                MessageBox.Show("Please select a vacancy to delete.", "No Vacancy Selected", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            //Serializer.Serializer.SerializationList(Vacancies, "Serializer/serializeList.json");
        }
        private void ApplySalaryFilter_Click(object sender, RoutedEventArgs e)
        {

            if(minSalaryTextBox.Text == "" && maxSalaryTextBox.Text == "")
            {
                string getValuesQuery = "SELECT AdCode, Salary, CreateDate, ProfessionType, Logotype, COMPANIES.Company FROM ADS inner join COMPANIES on ADS.Company = COMPANIES.Companyid";
                DataTable result = dbManager.ExecuteQuery(getValuesQuery);

                Vacancies.Clear();
                foreach (DataRow row in result.Rows)
                {
                    string companyName = row["Company"] as string;
                    string companyLogo = row["Logotype"] as string;
                    string professionType = row["ProfessionType"] as string;
                    int salary = (int)row["Salary"];
                    DateTime createDate = (DateTime)row["CreateDate"];
                    int id = (int)row["AdCode"];
                    Vacancy obj = new Vacancy(
                        companyName,
                        companyLogo,
                        professionType,
                        salary,
                        createDate,
                        id
                        );
                    Vacancies.Add(obj);
                }
                listBox.ItemsSource = Vacancies;
            }
            else if (int.TryParse(minSalaryTextBox.Text, out int minSalary) && int.TryParse(maxSalaryTextBox.Text, out int maxSalary))
            {
                string filterQuery = $"SELECT AdCode, Salary, CreateDate, ProfessionType, Logotype, COMPANIES.Company FROM ADS inner join COMPANIES on ADS.Company = COMPANIES.Companyid where ADS.Salary < {maxSalary} and ADS.Salary > {minSalary}";
                DataTable result = dbManager.ExecuteQuery(filterQuery);

                Vacancies.Clear();
                foreach (DataRow row in result.Rows)
                {
                    string companyName = row["Company"] as string;
                    string companyLogo = row["Logotype"] as string;
                    string professionType = row["ProfessionType"] as string;
                    int salary = (int)row["Salary"];
                    DateTime createDate = (DateTime)row["CreateDate"];
                    int id = (int)row["AdCode"];
                    Vacancy obj = new Vacancy(
                        companyName,
                        companyLogo,
                        professionType,
                        salary,
                        createDate,
                        id
                        );
                    Vacancies.Add(obj);
                }
                listBox.ItemsSource = Vacancies;

                /*var filteredVacancies = Vacancies.Where(v => v.Salary >= minSalary && v.Salary <= maxSalary);
                listBox.ItemsSource = filteredVacancies;*/
            }
            else
            {
                MessageBox.Show("Please enter valid salary values.", "Invalid Input", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }
        private void ApplySort_Click(object sender, RoutedEventArgs e)
        {
            string selectedSortBy = (sortByComboBox.SelectedItem as ComboBoxItem)?.Content.ToString();

            switch (selectedSortBy)
            {
                case "Alphabetical Order":
                    listBox.Items.SortDescriptions.Clear();
                    listBox.Items.SortDescriptions.Add(new SortDescription("JobTitle", ListSortDirection.Ascending));
                    break;
                case "Price: Low to High":
                    listBox.Items.SortDescriptions.Clear();
                    listBox.Items.SortDescriptions.Add(new SortDescription("Salary", ListSortDirection.Ascending));
                    break;
                case "Price: High to Low":
                    listBox.Items.SortDescriptions.Clear();
                    listBox.Items.SortDescriptions.Add(new SortDescription("Salary", ListSortDirection.Descending));
                    break;
                case "Date Added: Newest First":
                    listBox.Items.SortDescriptions.Clear();
                    listBox.Items.SortDescriptions.Add(new SortDescription("DateAdded", ListSortDirection.Descending));
                    break;
                case "Date Added: Oldest First":
                    listBox.Items.SortDescriptions.Clear();
                    listBox.Items.SortDescriptions.Add(new SortDescription("DateAdded", ListSortDirection.Ascending));
                    break;
            }
        }
        private void SearchButton_Click(object sender, RoutedEventArgs e)
        {
            string searchText = searchTextBox.Text.ToLower();

            //var filteredVacancies = Vacancies.Where(v => v.JobTitle.ToLower().Contains(searchText));
            var filteredVacancies = Vacancies.Where(v => v.CompanyName.ToLower().Contains(searchText));
            listBox.ItemsSource = filteredVacancies;
        }

        private ObservableCollection<Vacancy> favorites = new ObservableCollection<Vacancy>();

       


        private void listBox_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Vacancy selectedVacancy = listBox.SelectedItem as Vacancy;

            if (selectedVacancy != null && e.ChangedButton == MouseButton.Left)
            {
                VacancyDetailsWindow vacancyDetailsWindow = new VacancyDetailsWindow(selectedVacancy);
                vacancyDetailsWindow.Owner = this;
                vacancyDetailsWindow.ShowDialog();
            }
        }

        

        

      

    }
}
