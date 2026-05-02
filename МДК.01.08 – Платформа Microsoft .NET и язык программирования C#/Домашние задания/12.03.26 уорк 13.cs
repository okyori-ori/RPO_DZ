using System;


//class Person
//{
//    string name;
//    int age;

//    public Person(string name)
//    {
//        this.name = name;
//        Console.WriteLine("Person(string name)");
//    }
//    public Person(string name, int age) : this(name)
//    {
//        this.age = age;
//        Console.WriteLine("Person(string name, int age)");

//    }

//}

//class Employee : Person
//{
//    string company;

//    public Employee(string name, int age, string company) : base(name, age)
//    {
//        this.company = company;
//        Console.WriteLine("Employee (string name, int age, string company");
//    }
//}

//sealed class Admin
//{

//}

//class Program
//{
//    static void Main(string[] args)
//    {
//        Employee tom = new Employee("tom", 22, "Micrososf");
//    }
//}

class Rectangle
{
    public double width;
    public double height;
    public Rectangle(double width, double height)
    {
       this.width = width;
       this.height = height;
    }
    


    public  double GetArea()
    {
        return width * height;
    }
    public double GetPerimeter()
    {
        return 2 *(width / height);
    }
    public double GetWidth()
    {
        return width;
    }

    public double GetHeight()
    {
        return height;
    }
}
class main
{
    static void Main(string[] args)
    {
        Rectangle rect1 = new Rectangle(3, 5);
        Rectangle rest2 = new Rectangle(4, 5);

        Console.WriteLine($"Первый прямоуголник\n" +
            $"Ширина {rect1.GetWidth()}\n" +
            $"Высота {rect1.GetHeight()}\n" +
            $"Площадь {rect1.GetArea()}\n " +
            $"Периметор {rect1.GetPerimeter()}");
        Console.WriteLine($"Первый прямоуголник\n" +
            $"Ширина {rest2.GetWidth()}\n" +
            $"Высота {rest2.GetHeight()}\n" +
            $"Площадь {rest2.GetArea()}\n " +
            $"Периметор {rest2.GetPerimeter()}");
    }
}