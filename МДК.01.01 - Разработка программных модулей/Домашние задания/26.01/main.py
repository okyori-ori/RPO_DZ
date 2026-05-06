import sys
from PySide6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout,
                               QHBoxLayout, QLabel, QPushButton, QScrollArea, QFrame)
from PySide6.QtCore import Signal, Qt
from PySide6.QtGui import QFont


class MusicWidget(QFrame):
    musicSelected = Signal(dict)

    def __init__(self, title: str, artist: str, genre: str, parent=None):
        super().__init__(parent)

        self.track_data = {
            'title': title,
            'artist': artist,
            'genre': genre
        }

        main_layout = QHBoxLayout(self)
        main_layout.setContentsMargins(10, 10, 10, 10)
        main_layout.setSpacing(15)

        info_layout = QVBoxLayout()
        info_layout.setSpacing(5)

        self.title_label = QLabel(title)
        title_font = QFont()
        title_font.setPointSize(14)
        title_font.setBold(True)
        self.title_label.setFont(title_font)

        self.artist_label = QLabel(f"🎤 {artist}")
        artist_font = QFont()
        artist_font.setPointSize(11)
        self.artist_label.setFont(artist_font)

        self.genre_label = QLabel(f"🎵 {genre}")
        genre_font = QFont()
        genre_font.setPointSize(10)
        self.genre_label.setFont(genre_font)

        info_layout.addWidget(self.title_label)
        info_layout.addWidget(self.artist_label)
        info_layout.addWidget(self.genre_label)

        self.select_button = QPushButton("✓ Выбрать")
        self.select_button.setFixedSize(100, 40)
        self.select_button.setCursor(Qt.PointingHandCursor)
        self.select_button.clicked.connect(self._on_select_clicked)

        main_layout.addLayout(info_layout, stretch=1)
        main_layout.addWidget(self.select_button)

        self.setFrameShape(QFrame.Shape.Box)
        self.setStyleSheet("""
            MusicWidget {
                background-color: white;
                border: 1px solid #dcdde1;
                border-radius: 10px;
            }
            MusicWidget:hover {
                background-color: #f8f9fa;
                border: 1px solid #3498db;
            }
        """)

    def _on_select_clicked(self):
        self.musicSelected.emit(self.track_data)


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Музыкальный плеер")
        self.setMinimumSize(500, 600)
        self.setStyleSheet("background-color: #ecf0f1;")

        central_widget = QWidget()
        self.setCentralWidget(central_widget)

        main_layout = QVBoxLayout(central_widget)
        main_layout.setContentsMargins(20, 20, 20, 20)
        main_layout.setSpacing(20)

        title_label = QLabel("🎵 Моя музыкальная коллекция")
        title_font = QFont()
        title_font.setPointSize(20)
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setAlignment(Qt.AlignCenter)
        main_layout.addWidget(title_label)

        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setFrameShape(QFrame.Shape.NoFrame)

        self.tracks_container = QWidget()
        self.tracks_layout = QVBoxLayout(self.tracks_container)
        self.tracks_layout.setAlignment(Qt.AlignTop)
        self.tracks_layout.setSpacing(10)

        scroll_area.setWidget(self.tracks_container)
        main_layout.addWidget(scroll_area, stretch=1)

        bottom_frame = QFrame()
        bottom_frame.setFrameShape(QFrame.Shape.StyledPanel)
        bottom_frame.setStyleSheet("""
            QFrame {
                background-color: #2c3e50;
                border-radius: 10px;
                padding: 10px;
            }
        """)

        bottom_layout = QVBoxLayout(bottom_frame)
        self.selected_info = QLabel("⏳ Ничего не выбрано")
        self.selected_info.setAlignment(Qt.AlignCenter)
        info_font = QFont()
        info_font.setPointSize(12)
        self.selected_info.setFont(info_font)
        self.selected_info.setStyleSheet("color: #ecf0f1;")
        bottom_layout.addWidget(self.selected_info)

        main_layout.addWidget(bottom_frame)

        self._load_demo_data()

    def _load_demo_data(self):
        tracks = [
            {"title": "Bohemian Rhapsody", "artist": "Queen", "genre": "Rock"},
            {"title": "Billie Jean", "artist": "Michael Jackson", "genre": "Pop"},
            {"title": "Shape of You", "artist": "Ed Sheeran", "genre": "Pop"},
            {"title": "Stairway to Heaven", "artist": "Led Zeppelin", "genre": "Rock"},
            {"title": "Imagine", "artist": "John Lennon", "genre": "Ballad"},
            {"title": "Smells Like Teen Spirit", "artist": "Nirvana", "genre": "Grunge"},
            {"title": "Hotel California", "artist": "Eagles", "genre": "Rock"},
            {"title": "Rolling in the Deep", "artist": "Adele", "genre": "Soul"},
        ]

        for track in tracks:
            self.add_track_widget(track)

    def add_track_widget(self, track_data: dict):
        widget = MusicWidget(
            title=track_data["title"],
            artist=track_data["artist"],
            genre=track_data["genre"]
        )
        widget.musicSelected.connect(self.on_track_selected)
        self.tracks_layout.addWidget(widget)

    def on_track_selected(self, track_data: dict):
        self.selected_info.setText(f"🎵 Выбран трек: {track_data['title']} — {track_data['artist']} ({track_data['genre']})")


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())