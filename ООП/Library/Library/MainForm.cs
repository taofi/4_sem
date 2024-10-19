using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Policy;
using System.Security.Principal;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Library
{
    public partial class MainForm : Form
    {
        DataWriterClass authorWriter;
        DataWriterClass bookWriter;
        private event Action BookAdd;
        private event Action AuthorAdd;
        
        public MainForm()
        {
            InitializeComponent();
            authorWriter = new DataWriterClass("../../Base/authors.json");
            bookWriter = new DataWriterClass("../../Base/books.json");
            AuthorBase.Author = authorWriter.LoadDataAuthor();
            BookBase.Books = bookWriter.LoadDataBook();
            UpdateAuthorList();
            UpdateBookList();
        }
        public void SaveData()
        {
            bookWriter.SaveDataBook(BookBase.Books);
            authorWriter.SaveDataAuthor(AuthorBase.Author);
        }
        public void UpdateAuthorList()
        {
            AuthorListBox.Items.Clear();
            BookAuthorBox.Items.Clear();
            foreach (KeyValuePair<string, Author> kvp in AuthorBase.Author)
            {
                AuthorListBox.Items.Add(kvp.Value.ToString());
                BookAuthorBox.Items.Add(kvp.Value.ToString());
            }
        }
        public void UpdateBookList()
        {
            BookListBox.Items.Clear();
            
            foreach (Book book in BookBase.Books)
            {
                BookListBox.Items.Add(book.ToString());
            }
        }
        public string RadioButtonCheck()
        {
            if(FormatPDFButton.Checked)
                return FormatPDFButton.Text;
            else if(FormatMOBIButton.Checked)
                return FormatMOBIButton.Text;
            else if(FormatEPUBButton.Checked)
                return FormatEPUBButton.Text;
            return FormatDOCXButton.Text;
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void label8_Click(object sender, EventArgs e)
        {

        }
        private void BookNameBox_Validating(object sender, EventArgs e)
        {
            ValidatingClass.NotEmptyValidating(BookNameBox, BookNameErrorProvider);
        }
        private void BookNameBox_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void Submit_Click(object sender, EventArgs e)
        {
            if(BookNameErrorProvider.HasError(BookNameBox))
            {
                MessageBox.Show("Заполните все поля корректно!");
            }
        }

        private void BookYDK_Validating(object sender, CancelEventArgs e)
        {
            ValidatingClass.NotEmptyValidating(BookYDKBox, BookYDKErrorProvider);
            ValidatingClass.YDKValidation(BookYDKBox, BookYDKErrorProvider);
        }

        
        private void BookAuthor_Validating(object sender, CancelEventArgs e)
        {
            ValidatingClass.NotEmptyValidating(BookAuthorBox, BookAuthorErrorProvider);
        }

        private void BookPublisher_Validating(object sender, CancelEventArgs e)
        {
            ValidatingClass.NotEmptyValidating(BookPublisherBox, BookPublisherErrorProvider);
        }

        private void BookSizeTrack_Scroll(object sender, EventArgs e)
        {
            BookSizeBox.Text = $"{BookSizeTrack.Value}";
        }

        private void AuthorFirstNameBox_TextChanged(object sender, EventArgs e)
        {

        }

        private void AuthorFirstNameBox_Validating(object sender, CancelEventArgs e)
        {
            ValidatingClass.NotEmptyValidating(AuthorFirstNameBox, AuthorFirstNameErrorProvider);
        }

        private void AuthorSecondNameBox_Validating(object sender, CancelEventArgs e)
        {
            ValidatingClass.NotEmptyValidating(AuthorSecondNameBox, AuthorSecondNameErrorProvider);
        }

        private void AuthorSurnameBox_Validating(object sender, CancelEventArgs e)
        {
            ValidatingClass.NotEmptyValidating(AuthorSurnameBox, AuthorSurenameErrorProvider);
        }

        private void AuthorIDBox_Validating(object sender, CancelEventArgs e)
        {
            ValidatingClass.NotEmptyValidating(AuthorIDBox, AuthorIDErrorProvider);
        }

        private void BookSave_Click(object sender, EventArgs e)
        {
            try
            {

                Book book = ObjMaker.BookCreate(BookNameBox, BookYDKBox, BookPublisherBox, BookDatePicker, BookUploadDateBox, RadioButtonCheck(), BookAuthorBox, (int)BookPageCounterBox.Value, BookSizeTrack.Value);
               // Book book = new Book(BookNameBox.Text, BookAuthorBox.Text, BookPublisherBox.Text, BookYDKBox.Text, BookDatePicker.Value, BookUploadDateBox.Value, (int)BookPageCounterBox.Value, RadioButtonCheck(), BookSizeTrack.Value);
                UpdateBookList();
                SaveData();
                BookAdd?.Invoke();
            }
            catch(Exception ex) 
            {
                MessageBox.Show(ex.Message, "Ошибка!");
            }
           
        }


        private void BookSizeBox_MaskInputRejected(object sender, MaskInputRejectedEventArgs e)
        {
            
        }

        private void AuthorAgeBox_ValueChanged(object sender, EventArgs e)
        {

        }

        private void AuthorSave_Click(object sender, EventArgs e)
        {
            AuthorFirstNameBox_Validating(null, null);
            AuthorIDBox_Validating(null, null);
            AuthorSecondNameBox_Validating(null, null);
            AuthorSurnameBox_Validating(null, null);
            try
            {
                ObjMaker.AuthorCreate(AuthorFirstNameBox, AuthorSecondNameBox, AuthorSurnameBox, AuthorIDBox, AuthorCountryBox, AuthorAgeBox);
                UpdateAuthorList();
                SaveData();
                AuthorAdd?.Invoke();
            }
            catch (Exception ex) 
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void AuthorLoad_Click(object sender, EventArgs e)
        {
            try
            {
                string id = AuthorBase.GetId(AuthorListBox.Text);
                if (id == null)
                {
                    throw new Exception("Выберите автора");
                }
                Author author = AuthorBase.Find(id);
                AuthorFirstNameBox.Text = author.firstName;
                AuthorSecondNameBox.Text = author.secondName;
                AuthorSurnameBox.Text = author.surname;
                AuthorIDBox.Text = author.id;
                AuthorCountryBox.Text = author.country;
                AuthorAgeBox.Value = author.age;
            }
            catch (Exception ex) 
            {
                MessageBox.Show(ex.Message);
            }
            
        }

        private void BookSizeBox_Validating(object sender, CancelEventArgs e)
        {
            BookSizeTrack.Value = int.Parse(BookSizeBox.Text);
        }

        private void BookLoad_Click(object sender, EventArgs e)
        {
            try
            {
                int index = BookListBox.SelectedIndex;
                if (index >= 0)
                {
                    Book book = BookBase.Books[index];
                    BookAuthorBox.Text = book.Author;
                    BookYDKBox.Text = book.UDK;
                    BookDatePicker.Value = book.publishDate;
                    BookNameBox.Text = book.Name;
                    BookPublisherBox.Text = book.Publisher;
                    BookPageCounterBox.Value = book.pageCount;
                    BookSizeTrack.Value = book.size;
                    BookUploadDateBox.Value = book.uploadDate;
        

                    FormatPDFButton.Checked = false;
                    FormatMOBIButton.Checked = false;
                    FormatDOCXButton.Checked = false;
                    FormatPDFButton.Checked = false;
                    if (book.format == "pdf")
                        FormatPDFButton.Checked = true;
                    else if (book.format == "mobi")
                        FormatMOBIButton.Checked= true;
                    else if (book.format == "docx")
                        FormatDOCXButton.Checked = true;
                    else if(book.format == "epub")
                        FormatEPUBButton.Checked = true;
                }
                else
                    throw new Exception("Выберите книгу для загрузки");
            }
            catch (Exception ex) 
            {
                MessageBox.Show(ex.Message);
            }
            
        }

        private void BookClear_Click(object sender, EventArgs e)
        {
            BookPublisherBox.Text = string.Empty;
            BookAuthorBox.Text = string.Empty;
            BookYDKBox.Text = string.Empty;
            BookNameBox.Text = string.Empty;
            
        }

        private void AuthorClear_Click(object sender, EventArgs e)
        {
            AuthorFirstNameBox.Text = string.Empty;
            AuthorIDBox.Text = string.Empty;
            AuthorSecondNameBox.Text= string.Empty;
            AuthorSurnameBox.Text = string.Empty;
        }

        private void BookSizeTrack_ValueChanged(object sender, EventArgs e)
        {
            BookSizeBox.Text = $"{BookSizeTrack.Value}";
        }

        private void оПрограммеToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Version: 1.1\nVorovich Kirill Sergeevich");
        }

        private void поискToolStripMenuItem_Click(object sender, EventArgs e)
        {
            
        }

        private void названиюToolStripMenuItem_Click(object sender, EventArgs e)
        {
            BookBase.Books = BookBase.Books.OrderBy(b => b.Name).ToList();
            UpdateBookList();
        }

        private void датаЗагрузкиToolStripMenuItem_Click(object sender, EventArgs e)
        {
            BookBase.Books = BookBase.Books.OrderBy(b => b.uploadDate).ToList();
            UpdateBookList();
        }

        private void сортировкуToolStripMenuItem_Click(object sender, EventArgs e)
        {
            bookWriter.SaveDataBook(BookBase.Books);
        }

        private void поискToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            
            try
            {
                if (BookBase.FindBooks == null)
                {
                    throw new Exception("Нет результатов поиска для сохронения");
                }
                DataWriterClass findingResoult = new DataWriterClass($"../../Base/findResoult{DateTime.Now}.json");
                findingResoult.SaveDataBook(BookBase.FindBooks);
            }
            catch(Exception ex) 
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void издательToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FindingForm findingForm = new FindingForm();
            BookAdd += findingForm.updateBookCount;
            AuthorAdd += findingForm.UpdateAuthorList;
            findingForm.Save += SaveData;
            findingForm.PublisherActiv();
            findingForm.Show();
        }

        private void датаПубликацииToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FindingForm findingForm = new FindingForm();
            BookAdd += findingForm.updateBookCount;
            AuthorAdd += findingForm.UpdateAuthorList;
            findingForm.Save += SaveData;
            findingForm.DateActiv();
            findingForm.Show();
        }

        private void диапозонСтраницToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FindingForm findingForm = new FindingForm();
            BookAdd += findingForm.updateBookCount;
            AuthorAdd += findingForm.UpdateAuthorList;
            findingForm.Save += SaveData;
            findingForm.PageActiv();
            findingForm.Show();
        }
    }
}
