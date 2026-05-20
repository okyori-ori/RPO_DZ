using System;

namespace DeliverySystem
{
  
    public abstract class Delivery
    {
        public string Address { get; set; }
        public string Recipient { get; set; }

  
        public abstract int BaseCost { get; }
        public abstract DateTime SendDate { get; set; }

 
        public abstract double CalculateCost();
        public abstract TimeSpan GetDeliveryTime();

   
        public DateTime GetDeliveryDate()
        {
            return SendDate.Add(GetDeliveryTime());
        }

     
        public virtual void ShowInfo()
        {
            Console.WriteLine($"Получатель: {Recipient}");
            Console.WriteLine($"Адрес: {Address}");
            Console.WriteLine($"Дата отправки: {SendDate:dd.MM.yyyy}");
            Console.WriteLine($"Стоимость: {CalculateCost():F2} руб.");
            Console.WriteLine($"Время доставки: {GetDeliveryTime().TotalHours:F1} ч.");
            Console.WriteLine($"Дата получения: {GetDeliveryDate():dd.MM.yyyy}");
        }
    }


    public class HomeDelivery : Delivery
    {
        private double weight;    // кг
        private double distance;  // км

        public HomeDelivery(string address, string recipient, double weight, double distance, DateTime sendDate)
        {
            Address = address;
            Recipient = recipient;
            this.weight = weight;
            this.distance = distance;
            SendDate = sendDate;
        }

        public override int BaseCost => 50;
        public override DateTime SendDate { get; set; }

        public override double CalculateCost() => BaseCost * weight * distance;

        public override TimeSpan GetDeliveryTime() => TimeSpan.FromHours(distance * 0.5 + weight * 0.1);
    }

    public class PickPointDelivery : Delivery
    {
        private double weight;
        private const double FixedCost = 200;

        public PickPointDelivery(string address, string recipient, double weight, DateTime sendDate)
        {
            Address = address;
            Recipient = recipient;
            this.weight = weight;
            SendDate = sendDate;
        }

        public override int BaseCost => 30;
        public override DateTime SendDate { get; set; }

        public override double CalculateCost() => FixedCost + BaseCost * weight;

        public override TimeSpan GetDeliveryTime() => TimeSpan.FromDays(2);
    }

    public class ExpressDelivery : HomeDelivery
    {
        public ExpressDelivery(string address, string recipient, double weight, double distance, DateTime sendDate)
            : base(address, recipient, weight, distance, sendDate) { }

        public override double CalculateCost() => base.CalculateCost() * 2;

        public override TimeSpan GetDeliveryTime() => TimeSpan.FromHours(base.GetDeliveryTime().TotalHours / 3);

        public override void ShowInfo()
        {
            Console.WriteLine("=== ЭКСПРЕСС ===");
            base.ShowInfo();
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Console.OutputEncoding = System.Text.Encoding.UTF8;

         
            Console.WriteLine("--- Примеры доставок ---\n");

            Delivery d1 = new HomeDelivery("ул. Ленина, 5", "Иванов И.И.", 10, 30, DateTime.Today);
            Delivery d2 = new PickPointDelivery("ул. Советская, 2", "Петрова А.А.", 5, DateTime.Today);
            Delivery d3 = new ExpressDelivery("пр. Мира, 10", "Сидоров С.С.", 8, 20, DateTime.Today);

            d1.ShowInfo();
            Console.WriteLine();
            d2.ShowInfo();
            Console.WriteLine();
            d3.ShowInfo();

           
            Console.WriteLine("\n Создайте свою доставку ");
            Console.Write("Тип (1-дом, 2-постамат, 3-экспресс): ");
            string type = Console.ReadLine();

            Console.Write("ФИО получателя: ");
            string recipient = Console.ReadLine();
            Console.Write("Адрес: ");
            string address = Console.ReadLine();
            Console.Write("Вес (кг): ");
            double weight = double.Parse(Console.ReadLine());

            Console.Write("Дата отправки (дд.мм.гггг), Enter - сегодня: ");
            string dateStr = Console.ReadLine();
            DateTime sendDate = string.IsNullOrEmpty(dateStr) ? DateTime.Today : DateTime.ParseExact(dateStr, "dd.MM.yyyy", null);

            Delivery userDelivery = null;
            if (type == "1")
            {
                Console.Write("Расстояние (км): ");
                double distance = double.Parse(Console.ReadLine());
                userDelivery = new HomeDelivery(address, recipient, weight, distance, sendDate);
            }
            else if (type == "2")
            {
                userDelivery = new PickPointDelivery(address, recipient, weight, sendDate);
            }
            else if (type == "3")
            {
                Console.Write("Расстояние (км): ");
                double distance = double.Parse(Console.ReadLine());
                userDelivery = new ExpressDelivery(address, recipient, weight, distance, sendDate);
            }

            if (userDelivery != null)
            {
                Console.WriteLine("\nВаша доставка:");
                userDelivery.ShowInfo();
            }

            Console.ReadKey();
        }
    }
}