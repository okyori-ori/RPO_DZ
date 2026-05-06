import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Список студентов',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const StudentsPage(),
    );
  }
}

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  // 📌 Метод для получения цвета в зависимости от балла
  Color getScoreColor(String score) {
    final value = double.parse(score);
    if (value >= 4.5) {
      return Colors.green; // Отличник
    } else if (value >= 3.0) {
      return Colors.orange; // Хорошист
    } else {
      return Colors.red; // Двоечник
    }
  }

  // Данные студентов (имя, группа, балл)
  final List<Map<String, String>> students = const [
    {'name': 'Мингазов Саша', 'group_num': '67', 'average_score': '4.8'},
    {'name': 'Лекгих саша', 'group_num': '67', 'average_score': '4.9'},
    {'name': 'Мингазов Ахнаф', 'group_num': '67', 'average_score': '3.5'},
    {'name': 'кто еще', 'group_num': '67', 'average_score': '2.8'},
    {'name': 'Ікто еще', 'group_num': '67', 'average_score': '4.2'},
    {'name': 'кто еще', 'group_num': '67', 'average_score': '5.0'},
    {'name': 'кто еще', 'group_num': '67', 'average_score': '2.5'},
    {'name': 'кто еще', 'group_num': 'П67', 'average_score': '3.9'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список студентов'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getScoreColor(student['average_score']!),
                child: Text(
                  student['name']![0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                student['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              // ✅ ВАРИАНТ 1: Балл цветной в одной строке
              subtitle: Text(
                "Группа: ${student['group_num']} | Балл: ${student['average_score']}",
                style: TextStyle(
                  color: getScoreColor(student['average_score']!),
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Chip(
                label: Text(student['average_score']!),
                backgroundColor: getScoreColor(student['average_score']!).withOpacity(0.2),
                side: BorderSide(
                  color: getScoreColor(student['average_score']!),
                ),
              ),
              onTap: () {
                _showStudentInfo(context, student);
              },
            ),
          );
        },
      ),
    );
  }

  void _showStudentInfo(BuildContext context, Map<String, String> student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(student['name']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Группа: ${student['group_num']}"),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("Балл: "),
                  Text(
                    student['average_score']!,
                    style: TextStyle(
                      color: getScoreColor(student['average_score']!),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }
}