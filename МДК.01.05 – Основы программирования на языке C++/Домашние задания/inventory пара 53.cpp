#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

enum ItemType {
    armor,
    weapon,
    potion,
    other
};

enum Rarity {
    usually,
    rare,
    epic,
    legendary   // исправлено название
};

string typeToString(ItemType type) {
    switch (type) {
    case armor:  return "Броня";
    case weapon: return "Оружие";
    case potion: return "Зелье";
    case other:  return "Другое";
    }
    return "Неизвестно";
}

// ИСПРАВЛЕНО: правильные строки для редкости
string rarityToString(Rarity rarity) {
    switch (rarity) {
    case usually:   return "Обычный";
    case rare:      return "Редкий";
    case epic:      return "Эпический";
    case legendary: return "Легендарный";
    }
    return "Неизвестно";
}

struct Item {
    int id;
    string name;
    ItemType type;
    Rarity rarity;
    int value;
    double weight;
};

double getTotalWeight(const vector<Item>& inventory) {
    double total = 0;
    for (const auto& item : inventory) {
        total += item.weight;
    }
    return total;
}

void listItems(const vector<Item>& inventory) {
    if (inventory.empty()) {
        cout << "Инвентарь пуст.\n";
        return;
    }
    cout << "ID | Название | Тип | Редкость | Цена | Вес\n";
    cout << "--------------------------------------------\n";
    for (const auto& item : inventory) {
        cout << item.id << " | " << item.name << " | "
            << typeToString(item.type) << " | " << rarityToString(item.rarity)
            << " | " << item.value << " | " << item.weight << endl;
    }
}

bool addItem(vector<Item>& inventory, const Item& item, double maxWeight) {
    if (getTotalWeight(inventory) + item.weight > maxWeight) {
        cout << "Инвентарь переполнен! Нельзя добавить " << item.name << "\n";
        return false;
    }
    inventory.push_back(item);
    cout << "Предмет \"" << item.name << "\" успешно добавлен.\n";
    return true;
}

// ========== НОВЫЕ ФУНКЦИИ ==========

// Поиск по ID (возвращает индекс, -1 если не найден)
int findItemById(const vector<Item>& inventory, int id) {
    for (size_t i = 0; i < inventory.size(); ++i) {
        if (inventory[i].id == id)
            return i;
    }
    return -1;
}

// Поиск по имени (возвращает первый найденный индекс, -1 если нет)
int findItemByName(const vector<Item>& inventory, const string& name) {
    for (size_t i = 0; i < inventory.size(); ++i) {
        if (inventory[i].name == name)
            return i;
    }
    return -1;
}

// Удаление по ID
bool removeItemById(vector<Item>& inventory, int id) {
    int index = findItemById(inventory, id);
    if (index == -1) {
        cout << "Предмет с ID " << id << " не найден.\n";
        return false;
    }
    cout << "Удалён предмет: " << inventory[index].name << "\n";
    inventory.erase(inventory.begin() + index);
    return true;
}

// Удаление по имени (удаляет только первый найденный)
bool removeItemByName(vector<Item>& inventory, const string& name) {
    int index = findItemByName(inventory, name);
    if (index == -1) {
        cout << "Предмет с именем \"" << name << "\" не найден.\n";
        return false;
    }
    cout << "Удалён предмет: " << inventory[index].name << "\n";
    inventory.erase(inventory.begin() + index);
    return true;
}

// Демонстрация работы
int main() {
    vector<Item> inventory;
    double maxWeight = 100.0;

    // Создаём предметы
    Item sword = { 1, "Стальной меч", weapon, usually, 50, 5.0 };
    Item dragonArmor = { 2, "Драконья броня", armor, epic, 2500, 52.0 };
    Item healthPotion = { 3, "Лечебное зелье", potion, rare, 200, 1.0 };

    addItem(inventory, sword, maxWeight);
    addItem(inventory, dragonArmor, maxWeight);
    addItem(inventory, healthPotion, maxWeight);

    cout << "\n=== Весь инвентарь ===\n";
    listItems(inventory);

    // Поиск по ID
    cout << "\n=== Поиск предмета с ID = 2 ===\n";
    int idx = findItemById(inventory, 2);
    if (idx != -1)
        cout << "Найден: " << inventory[idx].name << endl;
    else
        cout << "Не найден\n";

    // Поиск по имени
    cout << "\n=== Поиск предмета с именем \"Лечебное зелье\" ===\n";
    idx = findItemByName(inventory, "Лечебное зелье");
    if (idx != -1)
        cout << "Найден: " << inventory[idx].name << endl;

    // Удаление по ID
    cout << "\n=== Удаление предмета с ID = 1 ===\n";
    removeItemById(inventory, 1);
    cout << "\nИнвентарь после удаления:\n";
    listItems(inventory);

    // Удаление по имени
    cout << "\n=== Удаление предмета с именем \"Лечебное зелье\" ===\n";
    removeItemByName(inventory, "Лечебное зелье");
    cout << "\nИнвентарь после удаления:\n";
    listItems(inventory);

    return 0;
}