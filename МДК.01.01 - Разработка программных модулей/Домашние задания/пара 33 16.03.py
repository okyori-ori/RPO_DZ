import sqlite3
from typing import List, Dict, Optional


class RecipeRepository:
    def __init__(self, db_name: str = "recipes.db"):
        self.conn = sqlite3.connect(db_name)
        self.cur = self.conn.cursor()
        self._create_table()

    def _create_table(self):
        self.cur.execute("""
            CREATE TABLE IF NOT EXISTS recipes (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT NOT NULL,
                category TEXT NOT NULL,
                ingredients TEXT,
                instructions TEXT
            )
        """)
        self.conn.commit()

    def get_all(self) -> List[Dict]:
        self.cur.execute("SELECT * FROM recipes")
        rows = self.cur.fetchall()
        recipes = []
        for row in rows:
            recipes.append({
                "id": row[0],
                "title": row[1],
                "category": row[2],
                "ingredients": row[3],
                "instructions": row[4]
            })
        return recipes

    def get_by_category(self, category: str) -> List[Dict]:
        self.cur.execute("SELECT * FROM recipes WHERE category = ?", (category,))
        rows = self.cur.fetchall()
        recipes = []
        for row in rows:
            recipes.append({
                "id": row[0],
                "title": row[1],
                "category": row[2],
                "ingredients": row[3],
                "instructions": row[4]
            })
        return recipes

    def add(self, title: str, category: str, ingredients: str, instructions: str) -> Dict:
        self.cur.execute(
            "INSERT INTO recipes (title, category, ingredients, instructions) VALUES (?, ?, ?, ?)",
            (title, category, ingredients, instructions)
        )
        self.conn.commit()
        return {
            "id": self.cur.lastrowid,
            "title": title,
            "category": category,
            "ingredients": ingredients,
            "instructions": instructions
        }

    def delete(self, recipe_id: int) -> bool:
        self.cur.execute("SELECT * FROM recipes WHERE id = ?", (recipe_id,))
        exists = self.cur.fetchone()
        if not exists:
            return False
        self.cur.execute("DELETE FROM recipes WHERE id = ?", (recipe_id,))
        self.conn.commit()
        return True

    def close(self):
        self.cur.close()
        self.conn.close()




def main():
    repo = RecipeRepository()

    print("=== ДОБАВЛЕНИЕ РЕЦЕПТОВ ===")
    repo.add("Борщ", "Первое блюдо", "свекла, капуста, картошка, мясо", "Варить 1 час")
    repo.add("Оливье", "Салат", "колбаса, огурцы, яйца, майонез", "Нарезать и перемешать")
    repo.add("Плов", "Второе блюдо", "рис, морковь, лук, мясо", "Жарить, тушить 40 мин")
    repo.add("Суп куриный", "Первое блюдо", "курица, вермишель, морковь", "Варить 30 мин")
    print("Рецепты добавлены\n")

    print("=== ВСЕ РЕЦЕПТЫ ===")
    all_recipes = repo.get_all()
    for recipe in all_recipes:
        print(f"{recipe['id']}. {recipe['title']} ({recipe['category']})")
    print()

    print("=== РЕЦЕПТЫ ПО КАТЕГОРИИ: Первое блюдо ===")
    first_dishes = repo.get_by_category("Первое блюдо")
    for recipe in first_dishes:
        print(f"{recipe['id']}. {recipe['title']}")
    print()

    print("=== УДАЛЕНИЕ РЕЦЕПТА С ID = 2 (Оливье) ===")
    if repo.delete(2):
        print("Рецепт успешно удалён\n")
    else:
        print("Рецепт не найден\n")

    print("=== ВСЕ РЕЦЕПТЫ ПОСЛЕ УДАЛЕНИЯ ===")
    all_recipes = repo.get_all()
    for recipe in all_recipes:
        print(f"{recipe['id']}. {recipe['title']} ({recipe['category']})")

    repo.close()


if __name__ == "__main__":
    main()