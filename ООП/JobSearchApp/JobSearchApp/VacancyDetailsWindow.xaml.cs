﻿using JobSearchApp.model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
    /// Логика взаимодействия для VacancyDetailsWindow.xaml
    /// </summary>
    public partial class VacancyDetailsWindow : Window
    {
        public VacancyDetailsWindow(Vacancy vacancy)
        {
            InitializeComponent();

            companyLogoImage.Source = new BitmapImage(new Uri(vacancy.CompanyLogo, UriKind.Absolute));
            companyNameTextBlock.Text = vacancy.CompanyName;
            jobTitleTextBlock.Text = vacancy.JobTitle;
            salaryTextBlock.Text = $"${vacancy.Salary:N0}";
            dateAddedTextBlock.Text = vacancy.DateAdded.ToShortDateString();
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
