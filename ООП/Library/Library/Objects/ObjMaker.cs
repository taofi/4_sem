using Newtonsoft.Json.Bson;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Library
{
    internal class ObjMaker
    {
        public static Book BookCreate(TextBox Name, TextBox Udk, TextBox Publisher, DateTimePicker DatePublish, DateTimePicker DateUplaod, string format, ComboBox Author, int PageCount, int size)
        {
           
            Book book = new Book(Name.Text, Author.Text, Publisher.Text, Udk.Text, DatePublish.Value, DateUplaod.Value, PageCount, format, size);
            var Results = new List<ValidationResult>();
            var Context = new ValidationContext(book);
            if (!Validator.TryValidateObject(book, Context, Results, true))
            {

                //BookBase.Books.Remove(BookBase.Books.Last());
                string errorMessage = "";
                foreach (var error in Results)
                    errorMessage += error.ErrorMessage + '\n';

                throw new Exception(errorMessage);
            }
            else
            {
                BookBase.Add(book);
                string id = AuthorBase.GetId(Author.Text);
                Author author = AuthorBase.Find(id);
                author.books.Add(book);
              
            }
           // author.Add(book);
            //BookBase.Add(book);
            return book;
        }

        public static Author AuthorCreate(TextBox FirstName, TextBox SecondName, TextBox Surname, TextBox ID, ComboBox Country, NumericUpDown Age)
        {
            Author author = new Author(ID.Text, FirstName.Text, SecondName.Text, Surname.Text, Convert.ToInt32(Age.Value), Country.Text);
            var Results = new List<ValidationResult>();
            var Context = new ValidationContext(author);
            if (!Validator.TryValidateObject(author, Context, Results, true))
            {
                string errorMessage = "";
                foreach (var error in Results)
                    errorMessage += error.ErrorMessage + '\n';

                throw new Exception(errorMessage);
            }
            else
            {
                AuthorBase.Add(ID.Text, author);
            }
            return author;
        }
    }
}
