using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Net.Mime.MediaTypeNames;

namespace Library
{
    public class ValidatingClass
    {
        public static void NotEmptyValidating(TextBox box, ErrorProvider error)
        {
            string text = box.Text;

            if (String.IsNullOrEmpty(text))
            {
                error.SetError(box, "Поле не указано!");
            }
            else
            {
                error.Clear();
            }
        }
        public static void NotEmptyValidating(ComboBox box, ErrorProvider error)
        {
            string text = box.Text;

            if (String.IsNullOrEmpty(text))
            {
                error.SetError(box, "Поле не указано!");
            }
            else
            {
                error.Clear();
            }
        }
        public static void YDKValidation(TextBox box, ErrorProvider error)
        {
            var regex = new Regex(@"^(\d{1,3}\.){0,4}\d{1,3}$");
            string text = box.Text;
            if (!regex.IsMatch(text))
            {
                error.SetError(box, "Не верный формат поля");
            }
        }
    }
}
