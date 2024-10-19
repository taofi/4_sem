using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    internal class AuthorBase
    {
        private static Dictionary<string, Author> _author;

        internal static Dictionary<string, Author> Author { get => _author; set => _author=value; }

        static AuthorBase()
        {
            Author = new Dictionary<string, Author>();
        }
        static public Author Find(string id)
        {
            if (Author.ContainsKey(id))
                return Author[id];
            else
                return null;
        }
        static public void Add(string id, Author author)
        {
            if(Author.ContainsKey(id))
                Author[id] = author;
            else
                Author.Add(id, author);
        }
        public static string GetId(string str)
        {
            if (string.IsNullOrEmpty(str))
                return null;
            string[] parts = str.Split(new char[] { ':', ';' }, StringSplitOptions.RemoveEmptyEntries);
            string id = parts[1].Trim();
            return id;
        }
    }
}
