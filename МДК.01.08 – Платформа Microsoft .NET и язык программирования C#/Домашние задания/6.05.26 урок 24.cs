using System;
using System.Collections.Generic;
using System.Linq;

class Student
{
    public string Name { get; set; }
    public int Age { get; set; }
    public double AverageScore { get; set; } // средний балл

    public override string ToString()
    {
        return $"{Name}, {Age} лет, балл: {AverageScore}";
    }
}

class Program
{
    static void Main()
    {
       
        List<Student> students = new List<Student>
        {
            new Student { Name = "Анна Смирнова", Age = 20, AverageScore = 88.5 },
            new Student { Name = "Борис Кузнецов", Age = 22, AverageScore = 74.0 },
            new Student { Name = "Виктор Петров", Age = 24, AverageScore = 91.2 },
            new Student { Name = "Галина Иванова", Age = 19, AverageScore = 79.3 },
            new Student { Name = "Дмитрий Сидоров", Age = 26, AverageScore = 85.7 },
            new Student { Name = "Елена Козлова", Age = 23, AverageScore = 67.8 },
            new Student { Name = "Жанна Морозова", Age = 21, AverageScore = 94.0 },
            new Student { Name = "Игорь Новиков", Age = 27, AverageScore = 72.5 }
        };

       
        var goodStudents = students.Where(s => s.AverageScore >= 75 && s.AverageScore <= 90);
        Console.WriteLine("Хорошисты (балл 75-90):");
        foreach (var s in goodStudents)
            Console.WriteLine($"{s.Name} - {s.AverageScore}");
        Console.WriteLine();

        List<string> names = students.Select(s => s.Name).ToList();
        Console.WriteLine("Список имён всех студентов:");
        Console.WriteLine(string.Join(", ", names));
        Console.WriteLine();

     
        var byAge = students.OrderBy(s => s.Age);
        Console.WriteLine("Студенты по возрасту (от младшего):");
        foreach (var s in byAge)
            Console.WriteLine(s);
        Console.WriteLine();

     
        var rating = students
            .Where(s => s.Age < 25)
            .OrderByDescending(s => s.AverageScore)
            .Select(s => $"{s.Name} - {s.AverageScore}");
        Console.WriteLine("Рейтинг лучших (младше 25 лет):");
        foreach (var item in rating)
            Console.WriteLine(item);
    }
}