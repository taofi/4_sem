using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace calculator
{
    internal class Calculator
    {
        
        public delegate void CalculatorDelegate(TextBox textBox1, TextBox textBox2, TextBox textBox3, ComboBox comboBox1, ComboBox comboBox2);
        static public void Clear(TextBox textBox1, TextBox textBox2, TextBox textBox3, ComboBox comboBox1, ComboBox comboBox2)
        {
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
            textBox1.BackColor = Color.White;
            textBox2.BackColor = Color.White;
            comboBox1.BackColor = Color.White;
            comboBox2.BackColor = Color.White;
        }
        static public void Calculate(TextBox textBox1, TextBox textBox2, TextBox textBox3, ComboBox comboBox1, ComboBox comboBox2)
        {
            try
            {
                textBox1.BackColor = Color.White;
                textBox2.BackColor = Color.White;
                comboBox1.BackColor = Color.White;
                comboBox2.BackColor = Color.White;
                int a, b;
                if (comboBox2.Text == "")
                {
                    comboBox2.BackColor = Color.Red;
                    throw new Exception("Выбирите систему счисления");
                }
                int notation = Convert.ToInt32(comboBox2.Text);
                a = Convert.ToInt32(textBox1.Text);
                b = Convert.ToInt32(textBox2.Text);


                switch (comboBox1.Text)
                {
                    case "&":
                        textBox3.Text = Convert.ToString(a & b, notation);
                        break;
                    case "|":
                        textBox3.Text = Convert.ToString(a | b, notation);
                        break;
                    case "^":
                        textBox3.Text = Convert.ToString(a ^ b, notation);
                        break;
                    case "~":
                        textBox3.Text = Convert.ToString(~a, notation);
                        break;
                    default:
                        comboBox1.BackColor = Color.Red;
                        throw new Exception("Выберите операцию");
                }
            }

            catch (FormatException)
            {
                if (!int.TryParse(textBox1.Text, out _))
                    textBox1.BackColor = Color.Red;
                if (!int.TryParse(textBox2.Text, out _))
                    textBox2.BackColor = Color.Red;
                MessageBox.Show("Введены данные неверного формата");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
