using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Library
{
    public static class ErrorProviderExtension
    {
        public static bool HasError(this ErrorProvider errorProvider, Control control)
        {
            return !String.IsNullOrEmpty(errorProvider.GetError(control));
        }
    }
}
