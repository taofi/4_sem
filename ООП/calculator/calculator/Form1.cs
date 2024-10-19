using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static calculator.Calculator;

namespace calculator
{
    internal partial class Form1 : Form
    {
        static public event CalculatorDelegate CalEvent;
        static public event CalculatorDelegate ClearEvent;
        public Form1()
        {
            InitializeComponent();
            textBox3.ReadOnly = true;
            CalEvent += Calculate;
            ClearEvent += Clear;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            CalEvent?.Invoke(textBox1, textBox2, textBox3, comboBox1, comboBox2);
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            ClearEvent?.Invoke(textBox1, textBox2, textBox3, comboBox1, comboBox2);
        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged_1(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
