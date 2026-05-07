import sys
import sqlite3
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QTableWidget, QTableWidgetItem, QPushButton, QLineEdit, QTextEdit,
    QLabel, QMessageBox, QGroupBox, QHeaderView
)
from PyQt6.QtCore import Qt
from PyQt6.QtGui import QFont


class TaskManager(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Менеджер задач")
        self.setMinimumSize(900, 600)
        self.setStyleSheet("background-color: #ecf0f1;")

        self.init_db()
        self.setup_ui()
        self.load_tasks()

    def init_db(self):
        """Инициализация базы данных"""
        self.conn = sqlite3.connect("tasks.db")
        self.cursor = self.conn.cursor()
        self.cursor.execute("""
            CREATE TABLE IF NOT EXISTS tasks (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT NOT NULL,
                description TEXT,
                status TEXT DEFAULT 'В ожидании'
            )
        """)
        self.conn.commit()

    def setup_ui(self):
        """Настройка интерфейса"""
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        main_layout = QVBoxLayout(central_widget)
        main_layout.setContentsMargins(20, 20, 20, 20)
        main_layout.setSpacing(20)

        # Заголовок
        title_label = QLabel("📋 Менеджер задач")
        title_font = QFont()
        title_font.setPointSize(24)
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        title_label.setStyleSheet("color: #2c3e50;")
        main_layout.addWidget(title_label)

        # Таблица задач
        self.task_table = QTableWidget()
        self.task_table.setColumnCount(4)
        self.task_table.setHorizontalHeaderLabels(["ID", "Название", "Описание", "Статус"])
        self.task_table.horizontalHeader().setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        self.task_table.horizontalHeader().setSectionResizeMode(1, QHeaderView.ResizeMode.Stretch)
        self.task_table.horizontalHeader().setSectionResizeMode(2, QHeaderView.ResizeMode.Stretch)
        self.task_table.horizontalHeader().setSectionResizeMode(3, QHeaderView.ResizeMode.ResizeToContents)
        self.task_table.setAlternatingRowColors(True)
        self.task_table.setStyleSheet("""
            QTableWidget {
                background-color: white;
                border: 1px solid #bdc3c7;
                border-radius: 5px;
            }
            QTableWidget::item {
                padding: 8px;
            }
        """)
        main_layout.addWidget(self.task_table)

        # Форма добавления
        form_group = QGroupBox("Добавление новой задачи")
        form_group.setStyleSheet("""
            QGroupBox {
                font-weight: bold;
                border: 2px solid #3498db;
                border-radius: 8px;
                margin-top: 12px;
                padding-top: 10px;
            }
            QGroupBox::title {
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 10px;
            }
        """)
        form_layout = QVBoxLayout(form_group)

        # Поле названия
        title_layout = QHBoxLayout()
        title_layout.addWidget(QLabel("Название:"))
        self.title_input = QLineEdit()
        self.title_input.setPlaceholderText("Введите название задачи")
        self.title_input.setStyleSheet("padding: 8px; border-radius: 4px; border: 1px solid #bdc3c7;")
        title_layout.addWidget(self.title_input)
        form_layout.addLayout(title_layout)

        # Поле описания
        desc_layout = QHBoxLayout()
        desc_layout.addWidget(QLabel("Описание:"))
        self.desc_input = QTextEdit()
        self.desc_input.setPlaceholderText("Введите описание задачи")
        self.desc_input.setMaximumHeight(80)
        self.desc_input.setStyleSheet("padding: 8px; border-radius: 4px; border: 1px solid #bdc3c7;")
        desc_layout.addWidget(self.desc_input)
        form_layout.addLayout(desc_layout)

        # Кнопки
        button_layout = QHBoxLayout()
        self.add_button = QPushButton("➕ Добавить задачу")
        self.add_button.setStyleSheet("""
            QPushButton {
                background-color: #27ae60;
                color: white;
                padding: 8px 16px;
                border-radius: 5px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: #2ecc71;
            }
        """)
        self.add_button.clicked.connect(self.add_task)

        self.delete_button = QPushButton("🗑 Удалить выбранную")
        self.delete_button.setStyleSheet("""
            QPushButton {
                background-color: #e74c3c;
                color: white;
                padding: 8px 16px;
                border-radius: 5px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: #c0392b;
            }
        """)
        self.delete_button.clicked.connect(self.delete_task)

        self.refresh_button = QPushButton("🔄 Обновить")
        self.refresh_button.setStyleSheet("""
            QPushButton {
                background-color: #3498db;
                color: white;
                padding: 8px 16px;
                border-radius: 5px;
            }
            QPushButton:hover {
                background-color: #2980b9;
            }
        """)
        self.refresh_button.clicked.connect(self.load_tasks)

        button_layout.addWidget(self.add_button)
        button_layout.addWidget(self.delete_button)
        button_layout.addWidget(self.refresh_button)
        button_layout.addStretch()
        form_layout.addLayout(button_layout)

        main_layout.addWidget(form_group)

     
        self.status_label = QLabel("Готово")
        self.status_label.setStyleSheet("color: #7f8c8d; padding: 5px;")
        main_layout.addWidget(self.status_label)

    def load_tasks(self):

        try:
            self.cursor.execute("SELECT * FROM tasks ORDER BY id")
            tasks = self.cursor.fetchall()

            self.task_table.setRowCount(len(tasks))

            for row, task in enumerate(tasks):
                self.task_table.setItem(row, 0, QTableWidgetItem(str(task[0])))
                self.task_table.setItem(row, 1, QTableWidgetItem(task[1]))
                self.task_table.setItem(row, 2, QTableWidgetItem(task[2] if task[2] else ""))
                self.task_table.setItem(row, 3, QTableWidgetItem(task[3]))


                status_item = self.task_table.item(row, 3)
                if task[3] == "Выполнено":
                    status_item.setForeground(Qt.GlobalColor.green)
                elif task[3] == "В работе":
                    status_item.setForeground(Qt.GlobalColor.blue)
                else:
                    status_item.setForeground(Qt.GlobalColor.darkGray)

            self.status_label.setText(f"Загружено задач: {len(tasks)}")
            self.task_table.resizeRowsToContents()

        except Exception as e:
            QMessageBox.critical(self, "Ошибка", f"Не удалось загрузить задачи: {str(e)}")

    def add_task(self):

        title = self.title_input.text().strip()
        description = self.desc_input.toPlainText().strip()

        # Обработка ошибок
        if not title:
            QMessageBox.warning(self, "Ошибка", "Название задачи не может быть пустым!")
            return

        if len(title) > 100:
            QMessageBox.warning(self, "Ошибка", "Название задачи не должно превышать 100 символов!")
            return

        try:
            self.cursor.execute(
                "INSERT INTO tasks (title, description) VALUES (?, ?)",
                (title, description)
            )
            self.conn.commit()

            self.title_input.clear()
            self.desc_input.clear()
            self.status_label.setText(f"Задача '{title}' добавлена")
            self.load_tasks()

        except Exception as e:
            QMessageBox.critical(self, "Ошибка", f"Не удалось добавить задачу: {str(e)}")

    def delete_task(self):

        selected_row = self.task_table.currentRow()
        if selected_row == -1:
            QMessageBox.warning(self, "Ошибка", "Выберите задачу для удаления!")
            return

        task_id_item = self.task_table.item(selected_row, 0)
        task_title_item = self.task_table.item(selected_row, 1)

        if not task_id_item or not task_title_item:
            return

        task_id = int(task_id_item.text())
        task_title = task_title_item.text()

        reply = QMessageBox.question(
            self, "Подтверждение",
            f"Вы уверены, что хотите удалить задачу '{task_title}'?",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No
        )

        if reply == QMessageBox.StandardButton.Yes:
            try:
                self.cursor.execute("DELETE FROM tasks WHERE id = ?", (task_id,))
                self.conn.commit()
                self.status_label.setText(f"Задача '{task_title}' удалена")
                self.load_tasks()
            except Exception as e:
                QMessageBox.critical(self, "Ошибка", f"Не удалось удалить задачу: {str(e)}")

    def closeEvent(self, event):

        try:
            self.conn.close()
        except:
            pass
        event.accept()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = TaskManager()
    window.show()
    sys.exit(app.exec())