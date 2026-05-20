using System;

// Абстрактный класс
public abstract class BankAccount
{
    public string AccountNumber;
    public int Balance;

    public BankAccount(string number, int balance)
    {
        AccountNumber = number;
        Balance = balance;
    }

    public void Deposit(int amount)
    {
        Balance += amount;
        Console.WriteLine("Пополнение: +" + amount + " | Баланс: " + Balance);
    }

    public abstract void Withdraw(int amount);

    public void DisplayBalance()
    {
        Console.WriteLine("Счет: " + AccountNumber + " | Баланс: " + Balance);
    }
}

// Сберегательный (не ниже минимума)
public class SavingsAccount : BankAccount
{
    int minBalance;

    public SavingsAccount(string number, int balance, int min) : base(number, balance)
    {
        minBalance = min;
    }

    public override void Withdraw(int amount)
    {
        if (Balance - amount >= minBalance)
        {
            Balance -= amount;
            Console.WriteLine("Снятие: -" + amount + " | Баланс: " + Balance);
        }
        else
        {
            Console.WriteLine("Ошибка: ниже минимума " + minBalance);
        }
    }
}

public class CheckingAccount : BankAccount
{
    int fee;

    public CheckingAccount(string number, int balance, int fee) : base(number, balance)
    {
        this.fee = fee;
    }

    public override void Withdraw(int amount)
    {
        if (Balance >= amount + fee)
        {
            Balance -= (amount + fee);
            Console.WriteLine("Снятие: -" + amount + " (комиссия " + fee + ") | Баланс: " + Balance);
        }
        else
        {
            Console.WriteLine("Ошибка: недостаточно средств");
        }
    }
}


public class CreditAccount : BankAccount
{
    int limit;

    public CreditAccount(string number, int balance, int limit) : base(number, balance)
    {
        this.limit = limit;
    }

    public override void Withdraw(int amount)
    {
        if (Balance - amount >= -limit)
        {
            Balance -= amount;
            Console.WriteLine("Снятие: -" + amount + " | Баланс: " + Balance);
        }
        else
        {
            Console.WriteLine("Ошибка: превышен кредитный лимит " + limit);
        }
    }
}

class Program
{
    static void Main()
    {
      
        SavingsAccount s = new SavingsAccount("SAV-1", 500, 100);
        s.DisplayBalance();
        s.Withdraw(300); // OK
        s.Withdraw(150); // ошибка

        Console.WriteLine();
        CheckingAccount c = new CheckingAccount("CHK-1", 200, 15);
        c.DisplayBalance();
        c.Withdraw(100); // OK (100+15=115)
        c.Withdraw(80);  // ошибка

        Console.WriteLine();


        CreditAccount cr = new CreditAccount("CRD-1", 100, 300);
        cr.DisplayBalance();
        cr.Withdraw(200); // OK -> -100
        cr.Withdraw(250); // ошибка (ниже -300)
   
    }
}