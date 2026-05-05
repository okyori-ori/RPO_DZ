#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Track {
protected:
    string title;
    int duration;

public:
    Track(string title, int duration) {
        this->title = title;
        this->duration = duration;
    }

    virtual void play() {
        cout << "Играет трек: " << title << endl;
    }

    virtual int getDuration() {
        return duration;
    }

    virtual ~Track() {}
};

class Song : public Track {
private:
    string artist;

public:
    Song(string title, int duration, string artist)
        : Track(title, duration) {
        this->artist = artist;
    }

    void play() override {
        cout << "Играет песня: " << title
            << " - " << artist << endl;
    }
};

class Instrumental : public Track {
private:
    string instrument;

public:
    Instrumental(string title, int duration, string instrument)
        : Track(title, duration) {
        this->instrument = instrument;
    }

    void play() override {
        cout << "Играет инструментал: " << title
            << " (" << instrument << ")" << endl;
    }
};


class Podcast : public Track {
private:
    string host;

public:
    Podcast(string title, int duration, string host)
        : Track(title, duration) {
        this->host = host;
    }

    void play() override {
        cout << "Играет подкаст: " << title
            << " (ведущий: " << host << ")" << endl;
    }
};



vector<Track*> tracks;



void addTrack() {
    int choice;
    cout << "1. Песня\n2. Инструментал\n3. Подкаст\nВыбор: ";
    cin >> choice;

    string title;
    int duration;

    cout << "Название: ";
    cin >> title;

    cout << "Длительность: ";
    cin >> duration;

    if (choice == 1) {
        string artist;
        cout << "Исполнитель: ";
        cin >> artist;
        tracks.push_back(new Song(title, duration, artist));
    }
    else if (choice == 2) {
        string instrument;
        cout << "Инструмент: ";
        cin >> instrument;
        tracks.push_back(new Instrumental(title, duration, instrument));
    }
    else if (choice == 3) {
        string host;
        cout << "Ведущий: ";
        cin >> host;
        tracks.push_back(new Podcast(title, duration, host));
    }
    else {
        cout << "Ошибка выбора\n";
    }
}

void playAll() {
    for (auto t : tracks) {
        t->play();
    }
}

void sortTracks()
{
    sort(tracks.begin(), tracks.end(),
        [](Track* a, Track* b) {
            return a->getDuration() < b->getDuration();
        }
    );

    cout << "Отсортировано по длительности\n";
}

void showDurations() {
    for (auto t : tracks) {
        cout << "Длительность: " << t->getDuration() << endl;
    }
}

void deleteAll() {
    for (auto t : tracks) {
        delete t;
    }
    tracks.clear();
}



void menu() {
    setlocale(LC_ALL, "ru");
    int choice;

    while (true) 
    {
        cout << "\nМузыкальный каталог\n";
        cout << "1. Добавить трек\n";
        cout << "2. Проиграть все\n";
        cout << "3. Сортировать по длительности\n";
        cout << "4. Показать длительности\n";
        cout << "0. Выход\n";
        cout << "Выбор: ";

        cin >> choice;

        switch (choice)
        {
        case 1: addTrack(); break;
        case 2: playAll(); break;
        case 3: sortTracks(); break;
        case 4: showDurations(); break;
        case 0:
            deleteAll();
            return;
        default:
            cout << "Ошибка!\n";
        }
    }
}




int main() {
    menu();
    return 0;
}