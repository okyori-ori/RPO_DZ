using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
//List<string> people = new List<string>() {"Tom", "Bob", "Sam"};

//Console.WriteLine(people);

//string firstPerson = people[0];
//Console.WriteLine(firstPerson);
//Dictionary<int, string> pub = new Dictionary<int, string>()
//{
//    {5, "Tomm" },
//    {2, "Sam" }
//};
//Console.WriteLine(pub[2]);

//var mike = new KeyValuePair<int, string>(56, "Mike");
//var employees = new List<KeyValuePair<int, string>>()
//{
//    mike
//};
//var user = new Queue<string>();

//user.Enqueue("Tom");
//user.Enqueue("Bob");
//user.Enqueue("Sam");

//var firstPerso = user.Peek();
//Console.WriteLine(firstPerso);

//var person1 = user.Dequeue();
//Console.WriteLine(person1);
//var person2 = user.Dequeue();
//Console.WriteLine(person2);
//var person3 = user.Dequeue();
//Console.WriteLine(person3);
class Storage
{
    static Dictionary<string, int> item = new Dictionary<string, int>();
    static void Main(string[] args)
    {
        do {
            Console.WriteLine("Выбери дейстиве");
            Console.WriteLine("1. Посмотреть все довары \n" +
                "2. Добавть товар \n" +
                "3. Удалить товар \n" +
                "4. Изменить товар \n");
            int dod = Convert.ToInt16(Console.ReadLine());
            switch (dod)
            {
                case 1:
                    Show_item(item);
                    break;
                case 2:
                    add_item();
                    break;

                case 3:
                    del_item(item);
                    break;
                case 4:
                    //izmenil_item
                    break;
            }
        } while (true);
        static void Show_item(Dictionary<string, int> item)
        {
            Console.WriteLine("Вот все товары ");
            if(item.Count == 0)
            {
                Console.WriteLine("Товаров нет");
            }
            else
            {
                foreach(var i in item)
                {
                    Console.WriteLine($"Товар: {i.Key}, Цена: {i.Value} рублей");
                }
            }
        }
        static void add_item()
        {
            Console.WriteLine("Впишите название а потом цену товара через Enter");
            string name = Convert.ToString(Console.ReadLine());
            int price = Convert.ToInt32(Console.ReadLine());
            item.Add(name, price);
                
        }
        static void del_item(Dictionary<string, int> item)
        {
            Console.WriteLine("Удвлить товар \n" +
                "Впеши название товара который хочешь удалить");
            string deliItem = Convert.ToString(Console.ReadLine());
            foreach(var i in item)
            {
                if (deliItem == i.Key)
                {
                    item.Remove(i.Key);

                }
                else
                {
                    Console.WriteLine("Не найден товар");
                }
            }

        }
        static void Izmenit_item()
        {
            if (item.Count == 0)
            {
                Console.WriteLine("Нет товаров для изменения!");
                return;
            }

            Console.Write("Введите название товара для изменения цены: ");
            string name = Console.ReadLine();

            if (item.ContainsKey(name))
            {
                Console.WriteLine($"Текущая цена товара '{name}': {item[name]} руб.");
                Console.Write("Введите новую цену: ");
                int newPrice = Convert.ToInt32(Console.ReadLine());

                item[name] = newPrice;  // Изменяем цену
                Console.WriteLine("Цена товара успешно обновлена!");
            }
            else
            {
                Console.WriteLine("Товар не найден!");
            }
        }





    }   
}