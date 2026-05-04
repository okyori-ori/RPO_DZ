using System;
using System.Collections.Generic;

class Task1
{
    public static void DrawSquare(int sideLength, char symbol)
    {
        if (sideLength <= 0)
        {
            Console.WriteLine("Длина стороны должна быть положительным числом");
            return;
        }

        for (int i = 0; i < sideLength; i++)
        {
            for (int j = 0; j < sideLength; j++)
            {
                Console.Write(symbol);
            }
            Console.WriteLine();
        }
    }
}
class Task2
{
    public static bool IsPalindrome(int number)
    {
        string numStr = number.ToString();
        char[] arr = numStr.ToCharArray();
        Array.Reverse(arr);
        string reversed = new string(arr);

        return numStr == reversed;
    }

  
    public static bool IsPalindromeMath(int number)
    {
        if (number < 0) return false;

        int original = number;
        int reversed = 0;

        while (number > 0)
        {
            reversed = reversed * 10 + number % 10;
            number /= 10;
        }

        return original == reversed;
    }
}
class Task3
{
    public static int[] FilterArray(int[] originalArray, int[] filterArray)
    {
        
        List<int> result = new List<int>();

        foreach (int item in originalArray)
        {
            bool found = false;

            
            foreach (int filter in filterArray)
            {
                if (item == filter)
                {
                    found = true;
                    break;
                }
            }

            
            if (!found)
            {
                result.Add(item);
            }
        }

        return result.ToArray();
    }
}
class Website
{
    private string name;
    private string path;
    private string description;
    private string ipAddress;

    // Методы для ввода данных
    public void InputData()
    {
        Console.WriteLine("Введите название сайта:");
        name = Console.ReadLine();

        Console.WriteLine("Введите путь к сайту:");
        path = Console.ReadLine();

        Console.WriteLine("Введите описание сайта:");
        description = Console.ReadLine();

        Console.WriteLine("Введите IP адрес сайта:");
        ipAddress = Console.ReadLine();
    }

    // Методы для вывода данных
    public void DisplayData()
    {
        Console.WriteLine("\n--- Информация о сайте ---");
        Console.WriteLine($"Название: {name}");
        Console.WriteLine($"Путь: {path}");
        Console.WriteLine($"Описание: {description}");
        Console.WriteLine($"IP адрес: {ipAddress}");
    }

    // Методы доступа к отдельным полям
    public void SetName(string newName)
    {
        name = newName;
    }

    public string GetName()
    {
        return name;
    }

    public void SetPath(string newPath)
    {
        path = newPath;
    }

    public string GetPath()
    {
        return path;
    }

    public void SetDescription(string newDescription)
    {
        description = newDescription;
    }

    public string GetDescription()
    {
        return description;
    }

    public void SetIpAddress(string newIpAddress)
    {
        ipAddress = newIpAddress;
    }

    public string GetIpAddress()
    {
        return ipAddress;
    }
}
class Magazine
{
    private string name;
    private int foundationYear;
    private string description;
    private string phone;
    private string email;

    // Методы для ввода данных
    public void InputData()
    {
        Console.WriteLine("Введите название журнала:");
        name = Console.ReadLine();

        Console.WriteLine("Введите год основания:");
        foundationYear = Convert.ToInt32(Console.ReadLine());

        Console.WriteLine("Введите описание журнала:");
        description = Console.ReadLine();

        Console.WriteLine("Введите контактный телефон:");
        phone = Console.ReadLine();

        Console.WriteLine("Введите контактный e-mail:");
        email = Console.ReadLine();
    }

    // Методы для вывода данных
    public void DisplayData()
    {
        Console.WriteLine("\n--- Информация о журнале ---");
        Console.WriteLine($"Название: {name}");
        Console.WriteLine($"Год основания: {foundationYear}");
        Console.WriteLine($"Описание: {description}");
        Console.WriteLine($"Контактный телефон: {phone}");
        Console.WriteLine($"Контактный e-mail: {email}");
    }

    // Методы доступа к отдельным полям
    public void SetName(string newName)
    {
        name = newName;
    }

    public string GetName()
    {
        return name;
    }

    public void SetFoundationYear(int newYear)
    {
        if (newYear > 0 && newYear <= DateTime.Now.Year)
        {
            foundationYear = newYear;
        }
        else
        {
            Console.WriteLine("Некорректный год основания!");
        }
    }

    public int GetFoundationYear()
    {
        return foundationYear;
    }

    public void SetDescription(string newDescription)
    {
        description = newDescription;
    }

    public string GetDescription()
    {
        return description;
    }

    public void SetPhone(string newPhone)
    {
        phone = newPhone;
    }

    public string GetPhone()
    {
        return phone;
    }

    public void SetEmail(string newEmail)
    {
        email = newEmail;
    }

    public string GetEmail()
    {
        return email;
    }
}
class Program
{
    static void Main(string[] args)
    {
        // Тест задания 1
        Console.WriteLine("=== Задание 1: Квадрат из символа ===");
        Task1.DrawSquare(5, '*');

        // Тест задания 2
        Console.WriteLine("\n=== Задание 2: Проверка палиндрома ===");
        Console.WriteLine($"1221 - палиндром? {Task2.IsPalindrome(1221)}");
        Console.WriteLine($"3443 - палиндром? {Task2.IsPalindrome(3443)}");
        Console.WriteLine($"7854 - палиндром? {Task2.IsPalindrome(7854)}");

        // Тест задания 3
        Console.WriteLine("\n=== Задание 3: Фильтрация массива ===");
        int[] original = { 1, 2, 6, -1, 88, 7, 6 };
        int[] filter = { 6, 88, 7 };
        int[] result = Task3.FilterArray(original, filter);

        Console.WriteLine("Оригинальный массив: " + string.Join(", ", original));
        Console.WriteLine("Массив для фильтрации: " + string.Join(", ", filter));
        Console.WriteLine("Результат: " + string.Join(", ", result));

        // Тест задания 4
        Console.WriteLine("\n=== Задание 4: Веб-сайт ===");
        Website site = new Website();
        site.InputData();
        site.DisplayData();

        // Тест задания 5
        Console.WriteLine("\n=== Задание 5: Журнал ===");
        Magazine magazine = new Magazine();
        magazine.InputData();
        magazine.DisplayData();
    }
}