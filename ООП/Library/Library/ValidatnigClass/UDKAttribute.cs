using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace Library.ValidatnigClass
{
    internal class UDKAttribute : ValidationAttribute
    {
        public override bool IsValid(object value)
        {
            string id = value.ToString();
            if (Regex.IsMatch(id, @"^\d+(\.\d+)*$"))
                return true;
            else
                ErrorMessage = "Удк. Некорректно введенны данные!";
            return false;
        }
    }
}
