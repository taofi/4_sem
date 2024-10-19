using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    internal class BookBase
    {
        private static List<Book> _books;
        public static List<Book> FindBooks { get; set; }
        static BookBase()
        {
            Books = new List<Book>();
            FindBooks = null;
        }

        internal static List<Book> Books { get => _books; set => _books=value; }

        static public void Add(Book book)
        {
            Books.Add(book);
        }
    }
}
