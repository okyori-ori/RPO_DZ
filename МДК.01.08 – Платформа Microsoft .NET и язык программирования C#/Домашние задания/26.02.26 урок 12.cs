using System;
using System.Collections.Generic;

class Game
{
    static void Main()
    {
        int px = 5, py = 5, mx, my, turns = 0;
        var rand = new Random();
        var map = new Dictionary<string, char>(); 

        do { mx = rand.Next(10); my = rand.Next(10); } while (mx == px && my == py);

        while (turns < 20)
        {
            Console.Clear();
            Console.WriteLine($"Ход {turns + 1}/20\n");
            map.Clear();
            map[$"{px},{py}"] = 'P';
            map[$"{mx},{my}"] = 'M';

            for (int y = 0; y < 10; y++)
            {
                for (int x = 0; x < 10; x++)
                {
                    string key = $"{x},{y}";
                    if (map.ContainsKey(key)) Console.Write($"{map[key]} ");
                    else Console.Write(". ");
                }
                Console.WriteLine();
            }

            if (turns >= 19)
            {
                Console.WriteLine("\nПОБЕДА! +20 ходов");
                break;
            }

     
            var key = Console.ReadKey(true).Key;
            int nx = px, ny = py;
            if (key == ConsoleKey.W) ny--;
            else if (key == ConsoleKey.S) ny++;
            else if (key == ConsoleKey.A) nx--;
            else if (key == ConsoleKey.D) nx++;
            else if (key == ConsoleKey.Q) break;

            if (nx >= 0 && nx < 10 && ny >= 0 && ny < 10) { px = nx; py = ny; }

         
            if (px > mx) mx++;
            else if (px < mx) mx--;
            if (py > my) my++;
            else if (py < my) my--;

            if (px == mx && py == my)
            {
                Console.Clear();
                Console.WriteLine($"ПОРАЖЕНИЕ! {turns + 1} ходов");
                break;
            }

            turns++;
        }

        Console.ReadKey();
    }
}