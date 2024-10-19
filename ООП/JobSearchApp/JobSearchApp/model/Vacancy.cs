using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace JobSearchApp.model
{
    public class Vacancy
    {
        private string _companyLogo;
        private string _jobTitle;
        private int _salary;
        private DateTime _date;
        private string _companyName;
        private int _id;
        public string CompanyLogo { get; set; }
        public string JobTitle { get; set; }
        public int Salary { get; set; }
        public DateTime DateAdded { get; set; }
        public string CompanyName { get; set; }
        public int Id { get; set; }
        public event PropertyChangedEventHandler PropertyChanged;

        public void OnPropertyChanged([CallerMemberName] string propName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propName));
        }
        public Vacancy(string companyName, string companyLogo, string jobTitle, int salary, DateTime dateAdded, int id)
        {
            Id = id;
            CompanyLogo = companyLogo;
            JobTitle = jobTitle;
            Salary = salary;
            DateAdded = dateAdded;
            CompanyName = companyName;
        }
    }
}
