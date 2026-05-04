namespace QuizApp
{
    partial class Form1
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            // Создаём элементы управления
            this.lblQuestion = new System.Windows.Forms.Label();
            this.groupBox = new System.Windows.Forms.GroupBox();
            this.rb1 = new System.Windows.Forms.RadioButton();
            this.rb2 = new System.Windows.Forms.RadioButton();
            this.rb3 = new System.Windows.Forms.RadioButton();
            this.lblProgress = new System.Windows.Forms.Label();
            this.progressBar = new System.Windows.Forms.ProgressBar();
            this.btnNext = new System.Windows.Forms.Button();

            // Настройка формы
            this.SuspendLayout();
            this.Text = "Викторина";
            this.Size = new System.Drawing.Size(500, 400);
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;

            // Label для вопроса
            this.lblQuestion.Location = new System.Drawing.Point(30, 30);
            this.lblQuestion.Size = new System.Drawing.Size(420, 50);
            this.lblQuestion.Font = new System.Drawing.Font("Microsoft Sans Serif", 11, System.Drawing.FontStyle.Bold);
            this.lblQuestion.Text = "Вопрос";

            // GroupBox
            this.groupBox.Text = "Выберите ответ";
            this.groupBox.Location = new System.Drawing.Point(30, 100);
            this.groupBox.Size = new System.Drawing.Size(420, 120);

            // RadioButton 1
            this.rb1.Location = new System.Drawing.Point(20, 30);
            this.rb1.Size = new System.Drawing.Size(380, 25);
            this.rb1.Text = "Ответ 1";

            // RadioButton 2
            this.rb2.Location = new System.Drawing.Point(20, 60);
            this.rb2.Size = new System.Drawing.Size(380, 25);
            this.rb2.Text = "Ответ 2";

            // RadioButton 3
            this.rb3.Location = new System.Drawing.Point(20, 90);
            this.rb3.Size = new System.Drawing.Size(380, 25);
            this.rb3.Text = "Ответ 3";

            // Добавляем RadioButton в GroupBox
            this.groupBox.Controls.Add(this.rb1);
            this.groupBox.Controls.Add(this.rb2);
            this.groupBox.Controls.Add(this.rb3);

            // Прогресс текст
            this.lblProgress.Location = new System.Drawing.Point(30, 240);
            this.lblProgress.Size = new System.Drawing.Size(200, 25);
            this.lblProgress.Text = "Вопрос 1 из 5";

            // ProgressBar
            this.progressBar.Location = new System.Drawing.Point(30, 270);
            this.progressBar.Size = new System.Drawing.Size(420, 25);
            this.progressBar.Minimum = 0;
            this.progressBar.Maximum = 5;
            this.progressBar.Value = 0;

            // Кнопка
            this.btnNext.Text = "Далее";
            this.btnNext.Location = new System.Drawing.Point(360, 310);
            this.btnNext.Size = new System.Drawing.Size(90, 30);
            this.btnNext.BackColor = System.Drawing.Color.LightBlue;
            this.btnNext.Click += new System.EventHandler(this.BtnNext_Click);

            // Добавляем всё на форму
            this.Controls.Add(this.lblQuestion);
            this.Controls.Add(this.groupBox);
            this.Controls.Add(this.lblProgress);
            this.Controls.Add(this.progressBar);
            this.Controls.Add(this.btnNext);

            this.ResumeLayout(false);
        }

        
        private System.Windows.Forms.Label lblQuestion;
        private System.Windows.Forms.RadioButton rb1;
        private System.Windows.Forms.RadioButton rb2;
        private System.Windows.Forms.RadioButton rb3;
        private System.Windows.Forms.Button btnNext;
        private System.Windows.Forms.Label lblProgress;
        private System.Windows.Forms.ProgressBar progressBar;
        private System.Windows.Forms.GroupBox groupBox;
    }
}