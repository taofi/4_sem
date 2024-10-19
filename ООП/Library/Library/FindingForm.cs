using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Serialization;

namespace Library
{
    public partial class FindingForm : Form
    {
        protected int gridIndex;
        protected int sortIndex;
        private bool toolStripFixed = false;
        public event Action Save;
        public FindingForm()
        {
     
            InitializeComponent();
            UpdateAuthorList();
            sortIndex = 0;

            PublisherBox.Enabled = PublisherCheckBox.Checked;

            PublihingDatePicker.Enabled = PubliahingDateCheckBox.Checked;

            PageMinBox.Enabled = PageCountCheckBox.Checked;
            PageMaxBox.Enabled = PageCountCheckBox.Checked;

            toolStripStatusLabel1.Text = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");
            updateBookCount();
        }
        public void updateBookCount()
        {
            int last = int.Parse(BookCountBox.Text);
            if(last == 0)
            {
                BookCountBox.Text = $"{BookBase.Books.Count}";
                return;
            }
            if (last > BookBase.Books.Count)
                LastActionBox.Text = "Книга удалена";
            else
                LastActionBox.Text = "Книга добавлена";
            BookCountBox.Text = $"{BookBase.Books.Count}";
        }
        public void updateAuthorCount()
        {
            int last = int.Parse(AuthorCountBox.Text);
            if (last == 0)
            {
                AuthorCountBox.Text = $"{AuthorBase.Author.Count}";
                return;
            }
            LastActionBox.Text = "Автор добавлен";
            AuthorCountBox.Text = $"{AuthorBase.Author.Count}";
        }
        public void PublisherActiv()
        {
            PublisherCheckBox.Checked = true;
            PublisherBox.Enabled = PublisherCheckBox.Checked;
        }
        public void DateActiv()
        {
            PubliahingDateCheckBox.Checked = true;
            PublihingDatePicker.Enabled = PubliahingDateCheckBox.Checked;
        }
        public void PageActiv()
        {
            PageCountCheckBox.Checked = true;
            PageMinBox.Enabled = PageCountCheckBox.Checked;
            PageMaxBox.Enabled = PageCountCheckBox.Checked;
        }
        public void UpdateGrid()
        {
            List<Book> books = BookBase.FindBooks;
            DataGridView dgv = BookDataGrid;
            dgv.Rows.Clear();
            for (int i = 0; i < books.Count; i++)
            {

                int index = BookDataGrid.Rows.Add();
                dgv.Rows[index].Cells["Name"].Value = books[index].Name;
                dgv.Rows[index].Cells["Author"].Value = books[index].Author;
                dgv.Rows[index].Cells["Publisher"].Value = books[index].Publisher;
                dgv.Rows[index].Cells["UDK"].Value = books[index].UDK;
                dgv.Rows[index].Cells["PublishDate"].Value = books[index].publishDate.ToString();
                dgv.Rows[index].Cells["UploadDate"].Value = books[index].uploadDate.ToString();
                dgv.Rows[index].Cells["PageCount"].Value = books[index].pageCount;
                dgv.Rows[index].Cells["Format"].Value = books[index].format;
                dgv.Rows[index].Cells["Size"].Value = books[index].size;
            }
            gridIndex = 0;
            if(books.Count >= 0)
                dgv.Rows[gridIndex].Selected = true;
            
        }
        public void Search()
        {
            
            
            string publisher = PublisherBox.Text;
            DateTime dateTime = PublihingDatePicker.Value;
            int Min = (int)PageMinBox.Value;
            int Max = (int)PageMaxBox.Value;
            List<Book> books = BookBase.Books;
            int indexSelected = AuthorListBox.SelectedIndex;
            if (indexSelected >= 0)
            {
                string id = AuthorBase.GetId(AuthorListBox.Text);
                books = AuthorBase.Find(id).books;
            }
            if (PublisherCheckBox.Checked && !string.IsNullOrEmpty(publisher))
            {
                if (publisher[0] == '~')
                {
                    publisher = publisher.Remove(0, 1);
                    books = books.Where(b => Regex.IsMatch(b.Publisher, publisher)).ToList();
                }
                else
                    books = books.Where(b => b.Publisher == publisher).ToList();
            }
            if (PubliahingDateCheckBox.Checked)
                books = books.Where(b => b.uploadDate == dateTime).ToList();
            if (PageCountCheckBox.Checked)
                books = books.Where(b => b.pageCount >= Min && b.pageCount <= Max).ToList();

            BookBase.FindBooks = books;

            
            
        }
        public void UpdateAuthorList()
        {
            updateAuthorCount();
            AuthorListBox.Items.Clear();
          //  LastActionBox.Text = "Автор добавлен";
            foreach (KeyValuePair<string, Author> kvp in AuthorBase.Author)
            {
                AuthorListBox.Items.Add(kvp.Value.ToString());
            }
        }
        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Search();
            UpdateGrid();
        }

        private void PublisherCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            PublisherBox.Enabled = PublisherCheckBox.Checked;
        }

        private void PubliahingDateCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            PublihingDatePicker.Enabled = PubliahingDateCheckBox.Checked;
        }

        private void PageCountCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            PageMinBox.Enabled = PageCountCheckBox.Checked;
            PageMaxBox.Enabled = PageCountCheckBox.Checked;
        }

        private void panel4_Paint(object sender, PaintEventArgs e)
        {

        }

        private void UpdateButton_Click(object sender, EventArgs e)
        {
         
            UpdateAuthorList();
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void toolStripButton3_Click(object sender, EventArgs e)
        {
            Search();
            UpdateGrid();
            UpdateAuthorList();
        }

        private void toolStripButton5_Click(object sender, EventArgs e)
        {
            if(gridIndex - 1 >= 0)
            {
                BookDataGrid.Rows[gridIndex].Selected = false;
                gridIndex--;
                BookDataGrid.Rows[gridIndex].Selected = true;
            }
        }

        private void toolStripButton6_Click(object sender, EventArgs e)
        {
            if (gridIndex + 1 < BookBase.FindBooks.Count)
            {
                BookDataGrid.Rows[gridIndex].Selected = false;
                gridIndex++;
                BookDataGrid.Rows[gridIndex].Selected = true;
            }
        }

        private void toolStripButton2_Click(object sender, EventArgs e)
        {
            BookDataGrid.Rows.Clear();
            BookBase.FindBooks = new List<Book>();
        }

        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            sortIndex++;
            if(sortIndex == 3)
                sortIndex = 0;
            switch(sortIndex)
            {
                case 0:
                    BookBase.FindBooks = BookBase.FindBooks.OrderByDescending(b => b.Name).ToList();
                    break;
                case 1:
                    BookBase.FindBooks = BookBase.FindBooks.OrderByDescending(b => b.publishDate).ToList();
                    break;
                case 2:
                    BookBase.FindBooks = BookBase.FindBooks.OrderByDescending(b => b.Author).ToList();
                    break;
            }

            UpdateGrid();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            toolStripStatusLabel1.Text = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");
        }

        private void toolStripButton4_Click(object sender, EventArgs e)
        {
            DataGridView dgv = BookDataGrid;
            for (int i = 0; i < BookBase.FindBooks.Count; i++) 
            {
                if (dgv.Rows[i].Selected) 
                {
                    BookBase.Books.Remove(BookBase.FindBooks[i]);
                    foreach (KeyValuePair<string, Author> kvp in AuthorBase.Author)
                    {
                        if(kvp.Value.books.Remove(BookBase.FindBooks[i]))
                            break;
                    }
                }
            }
            updateBookCount();
            UpdateGrid();
            Save?.Invoke();
        }

        private void toolStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            
        }

        private void toolStrip1_MouseHover(object sender, EventArgs e)
        {
            
        }

        private void toolStrip1_MouseLeave(object sender, EventArgs e)
        {
            if(!toolStripFixed)
            foreach(ToolStripItem item in toolStrip1.Items) 
            {
                item.Visible = false;
            }
        }

        private void toolStrip1_MouseEnter(object sender, EventArgs e)
        {
            foreach (ToolStripItem item in toolStrip1.Items)
            {
                item.Visible = true;
            }
        }

        private void toolStrip1_DoubleClick(object sender, EventArgs e)
        {
            if (toolStripFixed)
                toolStripFixed = false;
            else
                toolStripFixed = true;
        }

        private void statusStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void PublisherBox_TextChanged(object sender, EventArgs e)
        {

        }

        private void toolStripStatusLabel1_Click(object sender, EventArgs e)
        {

        }
    }
}
