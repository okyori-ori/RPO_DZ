using System;
using System.IO;
using System.Windows.Forms;

namespace QuizApp
{
    public partial class Form1 : Form
    {
        // Массивы для хранения вопросов и ответов
        string[] questions = new string[5];
        string[][] answers = new string[5][];
        int[] correctAnswers = new int[5];

        int currentQuestion = 0;
        int score = 0;

        public Form1()
        {
            InitializeComponent();
            LoadQuestions();
            ShowQuestion();
        }

        private void LoadQuestions()
        {
            if (File.Exists("questions.txt"))
            {
                string[] lines = File.ReadAllLines("questions.txt");

                for (int i = 0; i < 5; i++)
                {
                    string[] parts = lines[i].Split('/');
                    questions[i] = parts[0];
                    answers[i] = new string[] { parts[1], parts[2], parts[3] };
                    correctAnswers[i] = int.Parse(parts[4]);
                }
            }
            else
            {
                MessageBox.Show("Ошибка нету файла ващето");
            }
        }

        private void ShowQuestion()
        {
            if (currentQuestion >= 5) return;

            lblQuestion.Text = questions[currentQuestion];
            rb1.Text = answers[currentQuestion][0];
            rb2.Text = answers[currentQuestion][1];
            rb3.Text = answers[currentQuestion][2];

            rb1.Checked = false;
            rb2.Checked = false;
            rb3.Checked = false;

            lblProgress.Text = $"Вопрос {currentQuestion + 1} из 5";
            progressBar.Value = currentQuestion;

            if (currentQuestion == 4)
            {
                btnNext.Text = "Результат";
            }
            else
            {
                btnNext.Text = "Далее";
            }
        }

        private void BtnNext_Click(object sender, EventArgs e)
        {
            int selected = -1;
            if (rb1.Checked) selected = 0;
            if (rb2.Checked) selected = 1;
            if (rb3.Checked) selected = 2;

            if (selected == -1)
            {
                MessageBox.Show("Выберите ответ!", "Внимание");
                return;
            }

            if (selected == correctAnswers[currentQuestion])
            {
                score++;
            }

            currentQuestion++;

            if (currentQuestion < 5)
            {
                ShowQuestion();
            }
            else
            {
                progressBar.Value = 5;
                MessageBox.Show($"Правильных ответов: {score} из 5", "Результат");
                this.Close();
            }
        }
    }
}