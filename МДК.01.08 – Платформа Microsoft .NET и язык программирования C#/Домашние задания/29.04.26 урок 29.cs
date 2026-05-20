using System;


public interface Attackable
{
    void TakeDamage(int damage);
    bool IsAlive();
}


public interface Attacker
{
    void Attack(Attackable target);
}


public class Warrior : Attackable, Attacker
{
    public int Health;
    public int Strength;

    public Warrior(int health, int strength)
    {
        Health = health;
        Strength = strength;
    }

    public void Attack(Attackable target)
    {
        target.TakeDamage(Strength);
        Console.WriteLine($"Воин нанёс {Strength} урона.");
    }

    public void TakeDamage(int damage)
    {
        Health -= damage;
        Console.WriteLine($"Воин получил {damage} урона. Осталось здоровья: {Health}");
    }

    public bool IsAlive() => Health > 0;
}


public class Mage : Attackable, Attacker
{
    public int Health;
    public int Mana;
    public int SpellPower;

    public Mage(int health, int mana, int spellPower)
    {
        Health = health;
        Mana = mana;
        SpellPower = spellPower;
    }

    public void Attack(Attackable target)
    {
        if (Mana >= 10)
        {
            target.TakeDamage(SpellPower);
            Mana -= 10;
            Console.WriteLine($"Маг нанёс {SpellPower} урона заклинанием. Осталось маны: {Mana}");
        }
        else
        {
            target.TakeDamage(1);
            Console.WriteLine("Маг не хватает маны, нанёс 1 урон.");
        }
    }

    public void TakeDamage(int damage)
    {
        Health -= damage;
        Console.WriteLine($"Маг получил {damage} урона. Осталось здоровья: {Health}");
    }

    public bool IsAlive() => Health > 0;
}


class Program
{
    static void Main()
    {
     
        Warrior warrior = new Warrior(100, 20);
        Mage mage = new Mage(80, 30, 25);

        Console.WriteLine(" БОЙ НАЧАЛСЯ \n");

        
        while (warrior.IsAlive() && mage.IsAlive())
        {
            warrior.Attack(mage);
            if (!mage.IsAlive()) break;

            mage.Attack(warrior);
        }

        Console.WriteLine("\n БОЙ ОКОНЧЕН ");
        if (warrior.IsAlive())
            Console.WriteLine("Победил Воин!");
        else if (mage.IsAlive())
            Console.WriteLine("Победил Маг!");
        else
            Console.WriteLine("Ничья (оба мертвы)");

        Console.ReadKey();
    }
}