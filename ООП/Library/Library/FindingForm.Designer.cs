namespace Library
{
    partial class FindingForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FindingForm));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.PageMinBox = new System.Windows.Forms.NumericUpDown();
            this.PageMaxBox = new System.Windows.Forms.NumericUpDown();
            this.panel1 = new System.Windows.Forms.Panel();
            this.PageCountCheckBox = new System.Windows.Forms.CheckBox();
            this.panel2 = new System.Windows.Forms.Panel();
            this.PublisherCheckBox = new System.Windows.Forms.CheckBox();
            this.PublisherBox = new System.Windows.Forms.TextBox();
            this.panel3 = new System.Windows.Forms.Panel();
            this.PubliahingDateCheckBox = new System.Windows.Forms.CheckBox();
            this.PublihingDatePicker = new System.Windows.Forms.DateTimePicker();
            this.label6 = new System.Windows.Forms.Label();
            this.FindButton = new System.Windows.Forms.Button();
            this.panel4 = new System.Windows.Forms.Panel();
            this.panel5 = new System.Windows.Forms.Panel();
            this.UpdateButton = new System.Windows.Forms.Button();
            this.UploadDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.PublishDate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.UDK = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Publisher = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Author = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Name = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.BookDataGrid = new System.Windows.Forms.DataGridView();
            this.PageCount = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Format = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Size = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.AuthorListBox = new System.Windows.Forms.ListBox();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.toolStripButton3 = new System.Windows.Forms.ToolStripButton();
            this.toolStripButton1 = new System.Windows.Forms.ToolStripButton();
            this.toolStripButton2 = new System.Windows.Forms.ToolStripButton();
            this.toolStripButton4 = new System.Windows.Forms.ToolStripButton();
            this.toolStripButton5 = new System.Windows.Forms.ToolStripButton();
            this.toolStripButton6 = new System.Windows.Forms.ToolStripButton();
            this.label7 = new System.Windows.Forms.Label();
            this.BookCountBox = new System.Windows.Forms.TextBox();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.LastActionBox = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.AuthorCountBox = new System.Windows.Forms.TextBox();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.toolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
            ((System.ComponentModel.ISupportInitialize)(this.PageMinBox)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.PageMaxBox)).BeginInit();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            this.panel3.SuspendLayout();
            this.panel4.SuspendLayout();
            this.panel5.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.BookDataGrid)).BeginInit();
            this.toolStrip1.SuspendLayout();
            this.statusStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(4, 9);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(104, 25);
            this.label1.TabIndex = 0;
            this.label1.Text = "Издатель";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.Location = new System.Drawing.Point(4, 9);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(129, 25);
            this.label2.TabIndex = 1;
            this.label2.Text = "Год издания";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label3.Location = new System.Drawing.Point(6, 12);
            this.label3.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(186, 25);
            this.label3.TabIndex = 2;
            this.label3.Text = "Диапазон страниц";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label4.Location = new System.Drawing.Point(6, 37);
            this.label4.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(43, 25);
            this.label4.TabIndex = 3;
            this.label4.Text = "min";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label5.Location = new System.Drawing.Point(6, 102);
            this.label5.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(49, 25);
            this.label5.TabIndex = 4;
            this.label5.Text = "max";
            // 
            // PageMinBox
            // 
            this.PageMinBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.PageMinBox.Location = new System.Drawing.Point(11, 67);
            this.PageMinBox.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.PageMinBox.Maximum = new decimal(new int[] {
            10000,
            0,
            0,
            0});
            this.PageMinBox.Name = "PageMinBox";
            this.PageMinBox.Size = new System.Drawing.Size(180, 30);
            this.PageMinBox.TabIndex = 5;
            // 
            // PageMaxBox
            // 
            this.PageMaxBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.PageMaxBox.Location = new System.Drawing.Point(11, 132);
            this.PageMaxBox.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.PageMaxBox.Maximum = new decimal(new int[] {
            10000,
            0,
            0,
            0});
            this.PageMaxBox.Name = "PageMaxBox";
            this.PageMaxBox.Size = new System.Drawing.Size(180, 30);
            this.PageMaxBox.TabIndex = 6;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.PageCountCheckBox);
            this.panel1.Controls.Add(this.PageMaxBox);
            this.panel1.Controls.Add(this.PageMinBox);
            this.panel1.Controls.Add(this.label5);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Location = new System.Drawing.Point(11, 189);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(209, 185);
            this.panel1.TabIndex = 7;
            // 
            // PageCountCheckBox
            // 
            this.PageCountCheckBox.AutoSize = true;
            this.PageCountCheckBox.Location = new System.Drawing.Point(191, 20);
            this.PageCountCheckBox.Name = "PageCountCheckBox";
            this.PageCountCheckBox.Size = new System.Drawing.Size(18, 17);
            this.PageCountCheckBox.TabIndex = 7;
            this.PageCountCheckBox.UseVisualStyleBackColor = true;
            this.PageCountCheckBox.CheckedChanged += new System.EventHandler(this.PageCountCheckBox_CheckedChanged);
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.PublisherCheckBox);
            this.panel2.Controls.Add(this.PublisherBox);
            this.panel2.Controls.Add(this.label1);
            this.panel2.Location = new System.Drawing.Point(11, 10);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(209, 80);
            this.panel2.TabIndex = 8;
            // 
            // PublisherCheckBox
            // 
            this.PublisherCheckBox.AutoSize = true;
            this.PublisherCheckBox.Location = new System.Drawing.Point(191, 14);
            this.PublisherCheckBox.Name = "PublisherCheckBox";
            this.PublisherCheckBox.Size = new System.Drawing.Size(18, 17);
            this.PublisherCheckBox.TabIndex = 9;
            this.PublisherCheckBox.UseVisualStyleBackColor = true;
            this.PublisherCheckBox.CheckedChanged += new System.EventHandler(this.PublisherCheckBox_CheckedChanged);
            // 
            // PublisherBox
            // 
            this.PublisherBox.Location = new System.Drawing.Point(9, 37);
            this.PublisherBox.Name = "PublisherBox";
            this.PublisherBox.Size = new System.Drawing.Size(179, 30);
            this.PublisherBox.TabIndex = 1;
            this.PublisherBox.TextChanged += new System.EventHandler(this.PublisherBox_TextChanged);
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.PubliahingDateCheckBox);
            this.panel3.Controls.Add(this.PublihingDatePicker);
            this.panel3.Controls.Add(this.label2);
            this.panel3.Location = new System.Drawing.Point(11, 96);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(209, 77);
            this.panel3.TabIndex = 9;
            // 
            // PubliahingDateCheckBox
            // 
            this.PubliahingDateCheckBox.AutoSize = true;
            this.PubliahingDateCheckBox.Location = new System.Drawing.Point(191, 14);
            this.PubliahingDateCheckBox.Name = "PubliahingDateCheckBox";
            this.PubliahingDateCheckBox.Size = new System.Drawing.Size(18, 17);
            this.PubliahingDateCheckBox.TabIndex = 8;
            this.PubliahingDateCheckBox.UseVisualStyleBackColor = true;
            this.PubliahingDateCheckBox.CheckedChanged += new System.EventHandler(this.PubliahingDateCheckBox_CheckedChanged);
            // 
            // PublihingDatePicker
            // 
            this.PublihingDatePicker.Location = new System.Drawing.Point(8, 37);
            this.PublihingDatePicker.Name = "PublihingDatePicker";
            this.PublihingDatePicker.Size = new System.Drawing.Size(200, 30);
            this.PublihingDatePicker.TabIndex = 2;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(3, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(69, 25);
            this.label6.TabIndex = 11;
            this.label6.Text = "Автор";
            this.label6.Click += new System.EventHandler(this.label6_Click);
            // 
            // FindButton
            // 
            this.FindButton.Location = new System.Drawing.Point(11, 639);
            this.FindButton.Name = "FindButton";
            this.FindButton.Size = new System.Drawing.Size(128, 34);
            this.FindButton.TabIndex = 12;
            this.FindButton.Text = "Найти";
            this.FindButton.UseVisualStyleBackColor = true;
            this.FindButton.Click += new System.EventHandler(this.button1_Click);
            // 
            // panel4
            // 
            this.panel4.Controls.Add(this.panel5);
            this.panel4.Controls.Add(this.FindButton);
            this.panel4.Controls.Add(this.panel3);
            this.panel4.Controls.Add(this.panel2);
            this.panel4.Controls.Add(this.panel1);
            this.panel4.Location = new System.Drawing.Point(12, 36);
            this.panel4.Name = "panel4";
            this.panel4.Size = new System.Drawing.Size(236, 676);
            this.panel4.TabIndex = 13;
            this.panel4.Paint += new System.Windows.Forms.PaintEventHandler(this.panel4_Paint);
            // 
            // panel5
            // 
            this.panel5.Controls.Add(this.UpdateButton);
            this.panel5.Controls.Add(this.label6);
            this.panel5.Location = new System.Drawing.Point(11, 380);
            this.panel5.Name = "panel5";
            this.panel5.Size = new System.Drawing.Size(210, 255);
            this.panel5.TabIndex = 14;
            // 
            // UpdateButton
            // 
            this.UpdateButton.Location = new System.Drawing.Point(0, 215);
            this.UpdateButton.Name = "UpdateButton";
            this.UpdateButton.Size = new System.Drawing.Size(128, 34);
            this.UpdateButton.TabIndex = 13;
            this.UpdateButton.Text = "Обновить";
            this.UpdateButton.UseVisualStyleBackColor = true;
            this.UpdateButton.Click += new System.EventHandler(this.UpdateButton_Click);
            // 
            // UploadDate
            // 
            this.UploadDate.HeaderText = "День загрузки";
            this.UploadDate.MinimumWidth = 6;
            this.UploadDate.Name = "UploadDate";
            this.UploadDate.ReadOnly = true;
            this.UploadDate.Width = 125;
            // 
            // PublishDate
            // 
            this.PublishDate.HeaderText = "Дата издания";
            this.PublishDate.MinimumWidth = 6;
            this.PublishDate.Name = "PublishDate";
            this.PublishDate.ReadOnly = true;
            this.PublishDate.Width = 125;
            // 
            // UDK
            // 
            this.UDK.HeaderText = "УДК";
            this.UDK.MinimumWidth = 6;
            this.UDK.Name = "UDK";
            this.UDK.ReadOnly = true;
            this.UDK.Width = 125;
            // 
            // Publisher
            // 
            this.Publisher.HeaderText = "Издатель";
            this.Publisher.MinimumWidth = 6;
            this.Publisher.Name = "Publisher";
            this.Publisher.ReadOnly = true;
            this.Publisher.Width = 125;
            // 
            // Author
            // 
            this.Author.HeaderText = "Автор";
            this.Author.MinimumWidth = 6;
            this.Author.Name = "Author";
            this.Author.ReadOnly = true;
            this.Author.Width = 125;
            // 
            // Name
            // 
            this.Name.HeaderText = "Название";
            this.Name.MinimumWidth = 6;
            this.Name.Name = "Name";
            this.Name.ReadOnly = true;
            this.Name.Width = 125;
            // 
            // BookDataGrid
            // 
            this.BookDataGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.BookDataGrid.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Name,
            this.Author,
            this.Publisher,
            this.UDK,
            this.PublishDate,
            this.UploadDate,
            this.PageCount,
            this.Format,
            this.Size});
            this.BookDataGrid.Location = new System.Drawing.Point(254, 36);
            this.BookDataGrid.Name = "BookDataGrid";
            this.BookDataGrid.RowHeadersWidth = 51;
            this.BookDataGrid.RowTemplate.Height = 24;
            this.BookDataGrid.Size = new System.Drawing.Size(934, 676);
            this.BookDataGrid.TabIndex = 13;
            this.BookDataGrid.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick);
            // 
            // PageCount
            // 
            this.PageCount.HeaderText = "Количество страниц";
            this.PageCount.MinimumWidth = 6;
            this.PageCount.Name = "PageCount";
            this.PageCount.ReadOnly = true;
            this.PageCount.Width = 125;
            // 
            // Format
            // 
            this.Format.HeaderText = "Формат";
            this.Format.MinimumWidth = 6;
            this.Format.Name = "Format";
            this.Format.ReadOnly = true;
            this.Format.Width = 125;
            // 
            // Size
            // 
            this.Size.HeaderText = "Размер";
            this.Size.MinimumWidth = 6;
            this.Size.Name = "Size";
            this.Size.ReadOnly = true;
            this.Size.Width = 125;
            // 
            // AuthorListBox
            // 
            this.AuthorListBox.FormattingEnabled = true;
            this.AuthorListBox.ItemHeight = 25;
            this.AuthorListBox.Location = new System.Drawing.Point(26, 420);
            this.AuthorListBox.Name = "AuthorListBox";
            this.AuthorListBox.Size = new System.Drawing.Size(204, 179);
            this.AuthorListBox.TabIndex = 14;
            // 
            // toolStrip1
            // 
            this.toolStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripButton3,
            this.toolStripButton1,
            this.toolStripButton2,
            this.toolStripButton4,
            this.toolStripButton5,
            this.toolStripButton6});
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(1200, 27);
            this.toolStrip1.TabIndex = 15;
            this.toolStrip1.Text = "toolStrip1";
            this.toolStrip1.ItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.toolStrip1_ItemClicked);
            this.toolStrip1.DoubleClick += new System.EventHandler(this.toolStrip1_DoubleClick);
            this.toolStrip1.MouseEnter += new System.EventHandler(this.toolStrip1_MouseEnter);
            this.toolStrip1.MouseLeave += new System.EventHandler(this.toolStrip1_MouseLeave);
            this.toolStrip1.MouseHover += new System.EventHandler(this.toolStrip1_MouseHover);
            // 
            // toolStripButton3
            // 
            this.toolStripButton3.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButton3.Image = ((System.Drawing.Image)(resources.GetObject("toolStripButton3.Image")));
            this.toolStripButton3.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.toolStripButton3.Name = "toolStripButton3";
            this.toolStripButton3.Size = new System.Drawing.Size(29, 24);
            this.toolStripButton3.Text = "toolStripButton3";
            this.toolStripButton3.Visible = false;
            this.toolStripButton3.Click += new System.EventHandler(this.toolStripButton3_Click);
            // 
            // toolStripButton1
            // 
            this.toolStripButton1.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButton1.Image = ((System.Drawing.Image)(resources.GetObject("toolStripButton1.Image")));
            this.toolStripButton1.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.toolStripButton1.Name = "toolStripButton1";
            this.toolStripButton1.Size = new System.Drawing.Size(29, 24);
            this.toolStripButton1.Text = "toolStripButton1";
            this.toolStripButton1.Click += new System.EventHandler(this.toolStripButton1_Click);
            // 
            // toolStripButton2
            // 
            this.toolStripButton2.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButton2.Image = ((System.Drawing.Image)(resources.GetObject("toolStripButton2.Image")));
            this.toolStripButton2.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.toolStripButton2.Name = "toolStripButton2";
            this.toolStripButton2.Size = new System.Drawing.Size(29, 24);
            this.toolStripButton2.Text = "toolStripButton2";
            this.toolStripButton2.Click += new System.EventHandler(this.toolStripButton2_Click);
            // 
            // toolStripButton4
            // 
            this.toolStripButton4.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButton4.Image = ((System.Drawing.Image)(resources.GetObject("toolStripButton4.Image")));
            this.toolStripButton4.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.toolStripButton4.Name = "toolStripButton4";
            this.toolStripButton4.Size = new System.Drawing.Size(29, 24);
            this.toolStripButton4.Text = "toolStripButton4";
            this.toolStripButton4.Click += new System.EventHandler(this.toolStripButton4_Click);
            // 
            // toolStripButton5
            // 
            this.toolStripButton5.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButton5.Image = ((System.Drawing.Image)(resources.GetObject("toolStripButton5.Image")));
            this.toolStripButton5.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.toolStripButton5.Name = "toolStripButton5";
            this.toolStripButton5.Size = new System.Drawing.Size(29, 24);
            this.toolStripButton5.Text = "toolStripButton5";
            this.toolStripButton5.Click += new System.EventHandler(this.toolStripButton5_Click);
            // 
            // toolStripButton6
            // 
            this.toolStripButton6.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButton6.Image = ((System.Drawing.Image)(resources.GetObject("toolStripButton6.Image")));
            this.toolStripButton6.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.toolStripButton6.Name = "toolStripButton6";
            this.toolStripButton6.Size = new System.Drawing.Size(29, 24);
            this.toolStripButton6.Text = "toolStripButton6";
            this.toolStripButton6.Click += new System.EventHandler(this.toolStripButton6_Click);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(249, 2);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(174, 25);
            this.label7.TabIndex = 16;
            this.label7.Text = "Количество книг:";
            // 
            // BookCountBox
            // 
            this.BookCountBox.Location = new System.Drawing.Point(417, 2);
            this.BookCountBox.Name = "BookCountBox";
            this.BookCountBox.ReadOnly = true;
            this.BookCountBox.Size = new System.Drawing.Size(62, 30);
            this.BookCountBox.TabIndex = 17;
            this.BookCountBox.Text = "0";
            // 
            // timer1
            // 
            this.timer1.Enabled = true;
            this.timer1.Interval = 1000;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // LastActionBox
            // 
            this.LastActionBox.Location = new System.Drawing.Point(804, 2);
            this.LastActionBox.Name = "LastActionBox";
            this.LastActionBox.ReadOnly = true;
            this.LastActionBox.Size = new System.Drawing.Size(183, 30);
            this.LastActionBox.TabIndex = 19;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(485, 5);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(209, 25);
            this.label8.TabIndex = 20;
            this.label8.Text = "Количество авторов:";
            // 
            // AuthorCountBox
            // 
            this.AuthorCountBox.Location = new System.Drawing.Point(689, 1);
            this.AuthorCountBox.Name = "AuthorCountBox";
            this.AuthorCountBox.ReadOnly = true;
            this.AuthorCountBox.Size = new System.Drawing.Size(62, 30);
            this.AuthorCountBox.TabIndex = 21;
            this.AuthorCountBox.Text = "0";
            // 
            // statusStrip1
            // 
            this.statusStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripStatusLabel1});
            this.statusStrip1.Location = new System.Drawing.Point(0, 729);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(1200, 26);
            this.statusStrip1.TabIndex = 22;
            this.statusStrip1.Text = "statusStrip1";
            this.statusStrip1.ItemClicked += new System.Windows.Forms.ToolStripItemClickedEventHandler(this.statusStrip1_ItemClicked);
            // 
            // toolStripStatusLabel1
            // 
            this.toolStripStatusLabel1.Name = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Size = new System.Drawing.Size(151, 20);
            this.toolStripStatusLabel1.Text = "toolStripStatusLabel1";
            this.toolStripStatusLabel1.Click += new System.EventHandler(this.toolStripStatusLabel1_Click);
            // 
            // FindingForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(12F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1200, 755);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.AuthorCountBox);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.LastActionBox);
            this.Controls.Add(this.BookCountBox);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.toolStrip1);
            this.Controls.Add(this.AuthorListBox);
            this.Controls.Add(this.BookDataGrid);
            this.Controls.Add(this.panel4);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
           // this.Name = "FindingForm";
            this.Text = "Form2";
            ((System.ComponentModel.ISupportInitialize)(this.PageMinBox)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.PageMaxBox)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.panel4.ResumeLayout(false);
            this.panel5.ResumeLayout(false);
            this.panel5.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.BookDataGrid)).EndInit();
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.NumericUpDown PageMinBox;
        private System.Windows.Forms.NumericUpDown PageMaxBox;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.TextBox PublisherBox;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.DateTimePicker PublihingDatePicker;
        private System.Windows.Forms.Button FindButton;
        private System.Windows.Forms.Panel panel4;
        private System.Windows.Forms.DataGridViewTextBoxColumn UploadDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn PublishDate;
        private System.Windows.Forms.DataGridViewTextBoxColumn UDK;
        private System.Windows.Forms.DataGridViewTextBoxColumn Publisher;
        private System.Windows.Forms.DataGridViewTextBoxColumn Author;
        private System.Windows.Forms.DataGridViewTextBoxColumn Name;
        private System.Windows.Forms.DataGridView BookDataGrid;
        private System.Windows.Forms.DataGridViewTextBoxColumn PageCount;
        private System.Windows.Forms.DataGridViewTextBoxColumn Format;
        private System.Windows.Forms.DataGridViewTextBoxColumn Size;
        private System.Windows.Forms.CheckBox PageCountCheckBox;
        private System.Windows.Forms.CheckBox PublisherCheckBox;
        private System.Windows.Forms.CheckBox PubliahingDateCheckBox;
        private System.Windows.Forms.Button UpdateButton;
        private System.Windows.Forms.Panel panel5;
        private System.Windows.Forms.ListBox AuthorListBox;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripButton toolStripButton1;
        private System.Windows.Forms.ToolStripButton toolStripButton2;
        private System.Windows.Forms.ToolStripButton toolStripButton3;
        private System.Windows.Forms.ToolStripButton toolStripButton4;
        private System.Windows.Forms.ToolStripButton toolStripButton5;
        private System.Windows.Forms.ToolStripButton toolStripButton6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox BookCountBox;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.TextBox LastActionBox;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox AuthorCountBox;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel toolStripStatusLabel1;
    }
}