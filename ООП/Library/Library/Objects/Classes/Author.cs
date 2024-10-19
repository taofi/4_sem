using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    [Serializable]
    internal class Author
    {

        [Required(ErrorMessage = "Поле id должно быть заполнено")]
        public string id { get; set; }
        [Required(ErrorMessage = "Поле Имя должно быть заполнено")]
        public string firstName { get; set; }
        [Required(ErrorMessage = "Поле Фамилия должно быть заполнено")]
        public string secondName { get; set; }
        [Required(ErrorMessage = "Поле Отчество должно быть заполнено")]
        public string surname { get; set; }
        public int age { get; set; }
        public string country { get; set; }
        public List<Book> books { get; set; }
        public Author(string Id, string Firstname, string Secondname, string Surname, int Age, string Country)
        {
            id = Id;
            firstName = Firstname;
            secondName = Secondname;
            surname = Surname;
            age = Age;
            country = Country;
            books = new List<Book>();
        }
        public void Add(Book book)
        { 
            if (books == null)
                books = new List<Book>();
            books.Add(book); 
        }
        public string ToString()
        {
            return $"id:{id}; {firstName} {secondName} {surname}";
        }
    }
}
