using System;
using System.Collections.Generic;
using System.IO;
using System.Windows;

namespace QuizApp
{
    public partial class MainWindow : Window
    {
        class Question
        {
            public string Text { get; set; }
            public string[] Answers { get; set; }
            public int Correct { get; set; }
        }
        List<Question> questions = new List<Question>();
        int current = 0;
        int score = 0;

        public MainWindow()
        {
            InitializeComponent();
            LoadQuestions();
            ShowQuestion();
        }

        void LoadQuestions()
        {
            string path = "questions.txt";


            string[] lines = File.ReadAllLines(path);

            foreach (string line in lines)
            {
                string[] parts = line.Split('/');


                questions.Add(new Question
                {
                    Text = parts[0],
                    Answers = new string[] { parts[1], parts[2], parts[3] },
                    Correct = int.Parse(parts[4])
                });
            }

            progressBar.Maximum = questions.Count;
        }

        void ShowQuestion()
        {
            if (current >= questions.Count)
                return;

            var q = questions[current];

            txtQuestion.Text = q.Text;
            rb1.Content = q.Answers[0];
            rb2.Content = q.Answers[1];
            rb3.Content = q.Answers[2];

            rb1.IsChecked = false;
            rb2.IsChecked = false;
            rb3.IsChecked = false;

            lblProgress.Content = $"Вопрос {current + 1} из {questions.Count}";
            progressBar.Value = current;
        }

        void btnNext_Click(object sender, RoutedEventArgs e)
        {
            int selected = -1;

            if (rb1.IsChecked == true) selected = 0;
            if (rb2.IsChecked == true) selected = 1;
            if (rb3.IsChecked == true) selected = 2;

            if (selected == -1)
            {
                MessageBox.Show("Выберите ответ!");
                return;
            }

            if (selected == questions[current].Correct)
                score++;

            current++;

            if (current < questions.Count)
            {
                ShowQuestion();

                if (current == questions.Count - 1)
                    btnNext.Content = "Результат";
            }
            else
            {
                progressBar.Value = questions.Count;

                MessageBox.Show(
                    $"Правильных ответов: {score} из {questions.Count}",
                    "Результат");

                Close();
            }
        }
    }
}