#include <iostream>
#include <vector>
#include <fstream>
#include <sstream>
#include <map>
#include <algorithm>

using namespace std;

struct Transaction {
    int id;
    string type;
    string category;
    double amount;
    string date;
    string description;
};

vector<Transaction> transactions;
int nextId = 1;

//  ВСПОМОГАТЕЛЬНЫЕ 

void clearInput() {
    cin.clear();
    cin.ignore(10000, '\n');
}

// ДОБАВЛЕНИЕ

void addTransaction() {
    Transaction t;
    t.id = nextId++;

    cout << "Тип (income/expense): ";
    cin >> t.type;

    cout << "Категория: ";
    cin >> t.category;

    cout << "Сумма: ";
    while (!(cin >> t.amount)) {
        cout << "Ошибка! Введите число: ";
        clearInput();
    }

    cout << "Дата (YYYY-MM-DD): ";
    cin >> t.date;

    cin.ignore();
    cout << "Описание: ";
    getline(cin, t.description);

    transactions.push_back(t);
    cout << "Добавлено!\n";
}

//ПРОСМОТР 

void showAll() {
    if (transactions.empty()) {
        cout << "Нет данных\n";
        return;
    }

    for (const auto& t : transactions) {
        cout << "ID: " << t.id
            << " | " << t.type
            << " | " << t.category
            << " | " << t.amount
            << " | " << t.date
            << " | " << t.description << endl;
    }
}

//  ФИЛЬТР 

void filterByType() {
    string type;
    cout << "Тип: ";
    cin >> type;

    for (const auto& t : transactions) {
        if (t.type == type) {
            cout << t.id << " | " << t.amount << " | " << t.category << endl;
        }
    }
}

void filterByDate() {
    string start, end;
    cout << "С (YYYY-MM-DD): ";
    cin >> start;
    cout << "По (YYYY-MM-DD): ";
    cin >> end;

    for (const auto& t : transactions) {
        if (t.date >= start && t.date <= end) {
            cout << t.id << " | " << t.amount << " | " << t.date << endl;
        }
    }
}

// ПОИСК 

void searchByCategory() {
    string cat;
    cout << "Категория: ";
    cin >> cat;

    for (const auto& t : transactions) {
        if (t.category == cat) {
            cout << t.id << " | " << t.amount << endl;
        }
    }
}

//  УДАЛЕНИЕ 
void deleteTransaction() {
    int id;
    cout << "ID: ";
    cin >> id;

    for (auto it = transactions.begin(); it != transactions.end(); ++it) {
        if (it->id == id) {
            transactions.erase(it);
            cout << "Удалено\n";
            return;
        }
    }
    cout << "Не найдено\n";
}

// СТАТИСТИКА 

void showStats() {
    double income = 0, expense = 0;
    map<string, double> categories;

    for (const auto& t : transactions) {
        if (t.type == "income") income += t.amount;
        else expense += t.amount;

        categories[t.category] += t.amount;
    }

    cout << "Доходы: " << income << endl;
    cout << "Расходы: " << expense << endl;
    cout << "Баланс: " << income - expense << endl;

    cout << "\nПо категориям:\n";
    for (auto& [cat, sum] : categories) {
        cout << cat << ": " << sum << endl;
    }
}

// СОРТИРОВКА

void sortByAmount() {
    sort(transactions.begin(), transactions.end(),
        [](const Transaction& a, const Transaction& b) {
            return a.amount < b.amount;
        });
    cout << "Отсортировано по сумме\n";
}

void sortByDate() {
    sort(transactions.begin(), transactions.end(),
        [](const Transaction& a, const Transaction& b) {
            return a.date < b.date;
        });
    cout << "Отсортировано по дате\n";
}

// ФАЙЛ

void saveToFile() {
    ofstream file("data.csv");

    for (const auto& t : transactions) {
        file << t.id << ","
            << t.type << ","
            << t.category << ","
            << t.amount << ","
            << t.date << ","
            << t.description << "\n";
    }
}

void loadFromFile() {
    ifstream file("data.csv");
    if (!file) return;

    string line;
    while (getline(file, line)) {
        stringstream ss(line);
        Transaction t;
        string temp;

        getline(ss, temp, ',');
        t.id = stoi(temp);

        getline(ss, t.type, ',');
        getline(ss, t.category, ',');

        getline(ss, temp, ',');
        t.amount = stod(temp);

        getline(ss, t.date, ',');
        getline(ss, t.description);

        transactions.push_back(t);
        nextId = max(nextId, t.id + 1);
    }
}

// МЕНЮ

void menu() {
	setlocale(LC_ALL, "Russian");
    int choice;

    while (true) {
        cout << "\n--- Учет финансов ---\n";
        cout << "1. Добавить\n";
        cout << "2. Показать все\n";
        cout << "3. Фильтр по типу\n";
        cout << "4. Фильтр по дате\n";
        cout << "5. Поиск по категории\n";
        cout << "6. Удалить\n";
        cout << "7. Статистика\n";
        cout << "8. Сортировка по сумме\n";
        cout << "9. Сортировка по дате\n";
        cout << "0. Выход\n";
        cout << "Выбор: ";

        if (!(cin >> choice)) {
            clearInput();
            cout << "Ошибка ввода!\n";
            continue;
        }

        switch (choice) {
        case 1: addTransaction(); break;
        case 2: showAll(); break;
        case 3: filterByType(); break;
        case 4: filterByDate(); break;
        case 5: searchByCategory(); break;
        case 6: deleteTransaction(); break;
        case 7: showStats(); break;
        case 8: sortByAmount(); break;
        case 9: sortByDate(); break;
        case 0: saveToFile(); return;
        default: cout << "Ошибка!\n";
        }
    }
}

// MAIN 

int main() {
    loadFromFile();
    menu();
    return 0;
}