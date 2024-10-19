using System;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace Library
{
    internal class DataWriterClass
    {
        private string _path;
        public string Path { get { return _path; } }
        public DataWriterClass(string path)
        {
            _path=path;
        }

        public List<Book> LoadDataBook()
        {
            var fileExists = File.Exists(_path);
            if (!fileExists)
            {
                File.CreateText(_path).Dispose();
                return new List<Book>();
            }
            using (var reader = File.OpenText(_path))
            {
                var fileText = reader.ReadToEnd();
                return JsonConvert.DeserializeObject<List<Book>>(fileText);
            }
        }

        public void SaveDataBook(List<Book> accounts)
        {
            using (StreamWriter writer = File.CreateText(_path))
            {
                string output = JsonConvert.SerializeObject(accounts);
                writer.Write(output);
            }
        }

        public Dictionary<string, Author> LoadDataAuthor()
        {
            var fileExists = File.Exists(_path);
            if (!fileExists)
            {
                File.CreateText(_path).Dispose();
                return new Dictionary<string, Author>();
            }
            using (var reader = File.OpenText(_path))
            {
                var fileText = reader.ReadToEnd();
                return JsonConvert.DeserializeObject<Dictionary<string, Author>>(fileText);
            }
        }

        public void SaveDataAuthor(Dictionary<string, Author> accounts)
        {
            using (StreamWriter writer = File.CreateText(_path))
            {
                string output = JsonConvert.SerializeObject(accounts);
                writer.Write(output);
            }
        }
    }
}
