using System;

namespace UniversitySystem
{
    
    struct Book
    {
        
        public string Title { get; set; }
        public string Author { get; set; }

       
        public Book(string title, string author)
        {
            Title = title;
            Author = author;
        }

        
        public void Print()
        {
            Console.WriteLine($"\"{Title}\" - {Author}");
        }
    }

   
    class Student
    {
       
        private static int _totalStudents = 0;

       
        public static int TotalStudents
        {
            get { return _totalStudents; }
        }

        
        public string Name { get; set; }
        public Book FavoriteBook { get; set; }

    
        public Student(string name, Book favoriteBook)
        {
            Name = name;
            FavoriteBook = favoriteBook;
            _totalStudents++; 
        }

       
        public void Print()
        {
            Console.WriteLine($"Студент: {Name}");
            Console.Write("  Любимая книга: ");
            FavoriteBook.Print();
        }
    }

    class Program
    {
        static void Main(string[] args)
        {


            
            Console.WriteLine($"1. Начальное количество студентов: {Student.TotalStudents}\n");

    
            Console.WriteLine("2. Создаем профили студентов:\n");

            // Создаем книги
            Book book1 = new Book("Преступление и наказание", "Ф.М. Достоевский");
            Book book2 = new Book("Война и мир", "Л.Н. Толстой");
            Book book3 = new Book("Мастер и Маргарита", "М.А. Булгаков");

 
            Student student1 = new Student("Иван Петров", book1);
            Console.WriteLine($"Создан студент: {student1.Name}");
            Console.WriteLine($"Всего студентов: {Student.TotalStudents}\n");

            Student student2 = new Student("Мария Иванова", book2);
            Console.WriteLine($"Создан студент: {student2.Name}");
            Console.WriteLine($"Всего студентов: {Student.TotalStudents}\n");

            Student student3 = new Student("Алексей Сидоров", book3);
            Console.WriteLine($"Создан студент: {student3.Name}");
            Console.WriteLine($"Всего студентов: {Student.TotalStudents}\n");

   
            Console.WriteLine("Оригинальные данные:");
            student3.Print();
            Console.WriteLine();

          
            Student copiedStudent = student3;

         
            Book copiedBook = student3.FavoriteBook;


            Console.WriteLine("Вносим изменения в КОПИИ:");
            copiedStudent.Name = "ИЗМЕНЕННОЕ ИМЯ (Скопированный студент)";
            copiedBook.Title = "ИЗМЕНЕННОЕ НАЗВАНИЕ (Скопированная книга)";
            Console.WriteLine("  - Изменено имя у скопированного студента");
            Console.WriteLine("  - Изменено название у скопированной книги\n");

  
            Console.WriteLine("Оригинальные данные ПОСЛЕ изменений в копиях:");
            student3.Print();
            Console.WriteLine();


            Console.WriteLine("=== ОБЪЯСНЕНИЕ РЕЗУЛЬТАТОВ ===");
            Console.WriteLine();
            Console.WriteLine("Почему изменилось имя оригинального студента?");
            Console.WriteLine("  - Student - это КЛАСС (ссылочный тип)");
            Console.WriteLine("  - При копировании copiedStudent = student3 копируется ССЫЛКА на объект");
            Console.WriteLine("  - И copiedStudent, и student3 указывают на ОДИН И ТОТ ЖЕ объект в памяти");
            Console.WriteLine("  - Изменяя данные через copiedStudent, мы меняем оригинальный объект\n");

            Console.WriteLine("Почему НЕ изменилось название оригинальной книги?");
            Console.WriteLine("  - Book - это СТРУКТУРА (тип-значение)");
            Console.WriteLine("  - При копировании copiedBook = student3.FavoriteBook создается ПОЛНАЯ КОПИЯ");
            Console.WriteLine("  - copiedBook - это НЕЗАВИСИМЫЙ объект в памяти");
            Console.WriteLine("  - Изменение copiedBook НЕ влияет на оригинальную книгу студента\n");

            Console.WriteLine("=== ДОПОЛНИТЕЛЬНАЯ ДЕМОНСТРАЦИЯ ===");
            Console.WriteLine();

       
            Console.WriteLine("Создадим двух студентов с одной и той же книгой:");
            Book sharedBook = new Book("1984", "Дж. Оруэлл");
            Student studentA = new Student("Студент A", sharedBook);
            Student studentB = new Student("Студент B", sharedBook);

            Console.WriteLine($"Студент A: {studentA.Name}, книга: {studentA.FavoriteBook.Title}");
            Console.WriteLine($"Студент B: {studentB.Name}, книга: {studentB.FavoriteBook.Title}");
  
            Console.WriteLine("\nПосле изменения книги у студента A:");
            Console.WriteLine($"Студент A: {studentA.Name}, книга: {studentA.FavoriteBook.Title}");
            Console.WriteLine($"Студент B: {studentB.Name}, книга: {studentB.FavoriteBook.Title}");
            Console.WriteLine("\nКнига студента B НЕ изменилась, т.к. структура скопировалась!");

            Console.WriteLine("\nНажмите любую клавишу для выхода...");
            Console.ReadKey();
        }
    }
}