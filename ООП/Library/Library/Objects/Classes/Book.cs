using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;
using Library.ValidatnigClass;

namespace Library
{
    [Serializable]
    internal class Book
    {
        [Required(ErrorMessage = "Поле Имя должно быть заполнено")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Поле Автор должно быть заполнено")]
        public string Author { get; set; }
        [Required(ErrorMessage = "Поле Издатель должно быть заполнено")]
        public string Publisher { get; set; }
        [Required(ErrorMessage = "Поле Удк должно быть заполнено")]
        [UDKAttribute]
        public string UDK { get; set; }
        public DateTime publishDate { get; set; }
        public DateTime uploadDate { get; set; }
        public int pageCount { get; set; }
        public string format { get; set; }
        public int size { get; set; }

        public Book(string name, string author, string publisher, string uDK, DateTime publishDate, DateTime uploadDate, int pageCount, string format, int size)
        {
            Name=name;
            Author=author;
            Publisher=publisher;
            UDK=uDK;
            this.publishDate=publishDate;
            this.uploadDate=uploadDate;
            this.pageCount=pageCount;
            this.format=format;
            this.size=size;
        }

        public string ToString()
        {
            return $"{Name} {Author} {publishDate} {uploadDate}";
        }
    }
}
