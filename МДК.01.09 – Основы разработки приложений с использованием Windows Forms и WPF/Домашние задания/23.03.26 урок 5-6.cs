using System;

class Order
{
    private static int nextid = 1;
    private int orderId;

    public Order()
    {
        orderId = nextid;
        nextid++
    }
    public void DisplayInfo()
    {
        Console.WriteLine($"Order #{orderId}");
    }
    public int GetOrderId()
    {
        return orderId;
    }

}
class DatabaseConnector
{
    private static string connectionString;
    static DatabaseConnector()
    {
        connectionString = "Sever ";
        Console.WriteLine("Static constructor called");

    }
    public DatabaseConnector()
    {
        Console.WriteLine("Instance created");
    }
    public void Connect()
    {
        Console.WriteLine($"Connectung to database with: {connectionString}");
    }
}
class Program
{
    static void Main(string[] args)
    {
        // Проверка Задачи 1
        Console.WriteLine("=== Задача 1: Генератор уникальных ID ===\n");

        Order order1 = new Order();
        Order order2 = new Order();
        Order order3 = new Order();
        Order order4 = new Order();

        Console.WriteLine("Создано 4 заказа:");
        order1.DisplayInfo();
        order2.DisplayInfo();
        order3.DisplayInfo();
        order4.DisplayInfo();

        Console.WriteLine("\n" + new string('-', 50) + "\n");

        // Проверка Задачи 2
        Console.WriteLine("=== Задача 2: Статический конструктор ===\n");

        Console.WriteLine("Создаем первый экземпляр DatabaseConnector...");
        DatabaseConnector db1 = new DatabaseConnector();
        db1.Connect();

        Console.WriteLine("\nСоздаем второй экземпляр DatabaseConnector...");
        DatabaseConnector db2 = new DatabaseConnector();
        db2.Connect();

        Console.WriteLine("\nСоздаем третий экземпляр DatabaseConnector...");
        DatabaseConnector db3 = new DatabaseConnector();
        db3.Connect();

        Console.WriteLine("\n" + new string('-', 50));
        Console.WriteLine("\nВажно: Статический конструктор вызвался только ОДИН раз");
        Console.WriteLine("(при первом обращении к классу), а обычные конструкторы");
        Console.WriteLine("вызываются при создании каждого нового экземпляра.");
    }
}