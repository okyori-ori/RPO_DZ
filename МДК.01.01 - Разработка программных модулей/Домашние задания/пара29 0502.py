import psycopg2

conn = psycopg2.connect(
    host="localhost",
    database="your_database",
    user="your_user",
    password="your_password",
    port=5432
)
cur = conn.cursor()

cur.execute("""
    CREATE TABLE IF NOT EXISTS categories (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        description TEXT
    )
""")
conn.commit()


print("=== Все категории ===")
cur.execute("SELECT * FROM categories")
rows = cur.fetchall()
for row in rows:
    print(f"ID: {row[0]}, Name: {row[1]}, Description: {row[2]}")
print()

print("=== Добавление категории ===")
cur.execute(
    "INSERT INTO categories (name, description) VALUES (%s, %s) RETURNING *",
    ("Электроника", "Телефоны, ноутбуки, планшеты")
)
conn.commit()
new_row = cur.fetchone()
print(f"Добавлено: ID: {new_row[0]}, Name: {new_row[1]}, Description: {new_row[2]}")
print()

print("=== Обновление категории ===")
cur.execute(
    "UPDATE categories SET description = %s WHERE name = %s RETURNING *",
    ("Смартфоны, ноутбуки, планшеты и аксессуары", "Электроника")
)
conn.commit()
updated_row = cur.fetchone()
print(f"Обновлено: ID: {updated_row[0]}, Name: {updated_row[1]}, Description: {updated_row[2]}")
print()


print("=== Удаление категории ===")
cur.execute(
    "DELETE FROM categories WHERE name = %s RETURNING *",
    ("Электроника",)
)
conn.commit()
deleted_row = cur.fetchone()
print(f"Удалено: ID: {deleted_row[0]}, Name: {deleted_row[1]}, Description: {deleted_row[2]}")
print()

cur.close()
conn.close()