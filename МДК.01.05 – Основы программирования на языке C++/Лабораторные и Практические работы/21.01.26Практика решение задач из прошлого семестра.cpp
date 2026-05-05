#include <iostream>
#include <cstdlib>
using namespace std;

// Задача 1
void atm() {
    double balance = 1000;
    int choice;
    double amount;

    do {
        cout << "\n1.Снять 2.Пополнить 3.Баланс 0.Выход\n";
        cin >> choice;

        switch (choice) {
        case 1:
            cin >> amount;
            if (amount > 0 && amount <= balance)
                balance -= amount;
            else cout << "Ошибка\n";
            break;
        case 2:
            cin >> amount;
            if (amount > 0)
                balance += amount;
            else cout << "Ошибка\n";
            break;
        case 3:
            cout << balance << endl;
        }
    } while (choice != 0);
}

// Задача 2 
void stepsWeek() {
    int arr[7];

    for (int i = 0; i < 7; i++) cin >> arr[i];

    int max = arr[0], min = arr[0], sum = 0;

    for (int i = 0; i < 7; i++) {
        if (arr[i] > max) max = arr[i];
        if (arr[i] < min) min = arr[i];
        sum += arr[i];
    }

    cout << max << " " << min << " " << sum / 7.0 << endl;
}

//  Задача 3 
void gradesPtr() {
    int arr[] = { 5,4,3,2,5,3,4 };
    int n = 7;

    int sum = 0, pass = 0, fail = 0;

    for (int* p = arr; p < arr + n; p++) {
        sum += *p;
        if (*p >= 3) pass++;
        else fail++;
    }

    cout << sum / (double)n << endl;
}

// Задача 4 
void palindrome() {
    int n;
    cin >> n;

    int* arr = new int[n];
    for (int i = 0; i < n; i++) cin >> arr[i];

    bool ok = true;
    for (int i = 0; i < n / 2; i++) {
        if (arr[i] != arr[n - i - 1]) {
            ok = false;
            break;
        }
    }

    cout << (ok ? "Yes" : "No") << endl;
    delete[] arr;
}

//  Задача 5 
void elevator() {
    int current = 1, target;
    cin >> target;

    if (target < 1 || target > 9) {
        cout << "Ошибка\n";
        return;
    }

    cout << abs(target - current) << endl;
}

//Задача 6 
void rps() {
    int wins = 0, games = 0, choice;

    do {
        cin >> choice;
        if (choice == 0) break;

        int comp = rand() % 3 + 1;

        if ((choice == 1 && comp == 2) || (choice == 2 && comp == 3) || (choice == 3 && comp == 1))
            wins++;

        games++;
    } while (true);

    cout << wins << "/" << games << endl;
}

// Задача 7 
void diary() {
    string subj[] = { "Math","Phys","Hist" };
    int grades[] = { 5,3,4 };

    int sum = 0, min = grades[0], idx = 0;

    for (int i = 0; i < 3; i++) {
        sum += grades[i];
        if (grades[i] < min) {
            min = grades[i];
            idx = i;
        }
    }

    cout << sum / 3.0 << " " << subj[idx] << endl;
}

// --- Задача 8 ---
void restaurant() {
    double prices[] = { 5.5, 12, 4 };
    int choice;
    double total = 0;

    do {
        cin >> choice;
        if (choice >= 1 && choice <= 3)
            total += prices[choice - 1];
    } while (choice != 0);

    cout << total << endl;
}

// Задача 9
void removeDuplicates() {
    int n;
    cin >> n;

    int* arr = new int[n];
    for (int i = 0; i < n; i++) cin >> arr[i];

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; ) {
            if (arr[i] == arr[j]) {
                for (int k = j; k < n - 1; k++)
                    arr[k] = arr[k + 1];
                n--;
            }
            else j++;
        }
    }

    for (int i = 0; i < n; i++) cout << arr[i] << " ";
    delete[] arr;
}

// Задача 10
struct Character {
    int hp;
    int mana;
    int lvl;
};

void rpg() {
    Character c = { 100, 50, 1 };
    int cmd;

    do {
        cin >> cmd;

        switch (cmd) {
        case 1: c.hp -= 10; break;
        case 2: c.mana -= 5; break;
        case 3: c.lvl++; break;
        }

        if (c.hp < 0) c.hp = 0;
        if (c.mana < 0) c.mana = 0;

        cout << c.hp << " " << c.mana << " " << c.lvl << endl;

    } while (cmd != 0);
}

// Главное меню 
int main() {
    setlocale(LC_ALL, "ru");
    int task;

    do {
        cout << "\nВыбери задачу (1-10, 0-выход): ";
        cin >> task;

        switch (task) {
        case 1: atm(); break;
        case 2: stepsWeek(); break;
        case 3: gradesPtr(); break;
        case 4: palindrome(); break;
        case 5: elevator(); break;
        case 6: rps(); break;
        case 7: diary(); break;
        case 8: restaurant(); break;
        case 9: removeDuplicates(); break;
        case 10: rpg(); break;
        }

    } while (task != 0);
}