import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

void main() {
  runApp(const VictorinaApp());
}

class VictorinaApp extends StatelessWidget {
  const VictorinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Викторина',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VictorinaHome(),
    );
  }
}

// ==================== ГЛАВНЫЙ ЭКРАН ====================

class VictorinaHome extends StatefulWidget {
  const VictorinaHome({super.key});

  @override
  State<VictorinaHome> createState() => _VictorinaHomeState();
}

class _VictorinaHomeState extends State<VictorinaHome> {
  int _bestScore = 0;

  @override
  void initState() {
    super.initState();
    _loadBestScore();
  }

  Future<void> _loadBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _bestScore = prefs.getInt('best_score') ?? 0;
    });
  }

  Future<void> _saveBestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final bestScore = prefs.getInt('best_score') ?? 0;
    if (score > bestScore) {
      await prefs.setInt('best_score', score);
      setState(() => _bestScore = score);
    }
  }

  Future<void> _resetBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('best_score');
    setState(() => _bestScore = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎯 Викторина'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.quiz, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 32),
            const Text(
              'Проверь свои знания!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    '🏆 Рекорд',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    '$_bestScore',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(onFinish: _saveBestScore),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                '🚀 Начать',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _resetBestScore,
              child: const Text(
                'Сбросить рекорд',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== ЭКРАН ВИКТОРИНЫ ====================

class QuizScreen extends StatefulWidget {
  final Function(int) onFinish;

  const QuizScreen({super.key, required this.onFinish});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // 📚 Вопросы (5 штук)
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Кто написал роман "Майстер корабля"?',
      'options': ['Михаил Коцюбинский', 'Юрий Яновский', 'Олесь Гончар', 'Панас Мирный'],
      'correct': 1,
    },
    {
      'question': 'Как называется главный принцип работы Flutter?',
      'options': ['Всё есть виджет', 'Всё есть объект', 'Всё есть функция', 'Всё есть компонент'],
      'correct': 0,
    },
    {
      'question': 'Какой язык используется для Android-разработки?',
      'options': ['Swift', 'Kotlin', 'JavaScript', 'Python'],
      'correct': 1,
    },
    {
      'question': 'Что означает аббревиатура ООП?',
      'options': [
        'Объектно-ориентированное программирование',
        'Основы обработки программ',
        'Организация открытых приложений',
        'Общее обучение программированию'
      ],
      'correct': 0,
    },
    {
      'question': 'Какой из этих языков является типизированным?',
      'options': ['JavaScript', 'Python', 'Dart', 'PHP'],
      'correct': 2,
    },
  ];

  int _currentQuestion = 0;
  int _score = 0;
  bool _answered = false;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _questions.shuffle(Random());
  }

  void _selectAnswer(int index) {
    if (_answered) return;

    if (index == _questions[_currentQuestion]['correct']) {
      _score++;
    }

    setState(() => _answered = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (_currentQuestion < _questions.length - 1) {
        setState(() {
          _currentQuestion++;
          _answered = false;
        });
      } else {
        setState(() => _showResult = true);
      }
    });
  }

  void _restart() {
    setState(() {
      _questions.shuffle(Random());
      _currentQuestion = 0;
      _score = 0;
      _answered = false;
      _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🏆 ЭКРАН РЕЗУЛЬТАТА
    if (_showResult) {
      widget.onFinish(_score);
      return Scaffold(
        appBar: AppBar(
          title: const Text('📊 Результат'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: _score == _questions.length
                      ? Colors.green.shade50
                      : _score > _questions.length / 2
                      ? Colors.orange.shade50
                      : Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _score == _questions.length
                      ? Icons.emoji_events
                      : _score > _questions.length / 2
                      ? Icons.sentiment_satisfied
                      : Icons.sentiment_dissatisfied,
                  size: 80,
                  color: _score == _questions.length
                      ? Colors.amber
                      : _score > _questions.length / 2
                      ? Colors.orange
                      : Colors.red,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '$_score из ${_questions.length}',
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                _score == _questions.length
                    ? '✨ Идеально! Ты гений! ✨'
                    : _score > _questions.length / 2
                    ? '👍 Неплохо! Так держать! 👍'
                    : '💪 Попробуй ещё раз! У тебя получится! 💪',
                style: TextStyle(
                  fontSize: 20,
                  color: _score == _questions.length
                      ? Colors.green
                      : _score > _questions.length / 2
                      ? Colors.orange
                      : Colors.red,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  _restart();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('🔄 Играть снова', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      );
    }

    // 📋 ЭКРАН ВОПРОСА
    final question = _questions[_currentQuestion];
    final options = question['options'] as List;

    return Scaffold(
      appBar: AppBar(
        title: Text('Вопрос ${_currentQuestion + 1}/${_questions.length}'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$_score',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: IgnorePointer(
        ignoring: _answered,
        child: AnimatedOpacity(
          opacity: _answered ? 0.5 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    question['question'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                ...options.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String option = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ElevatedButton(
                      onPressed: () => _selectAnswer(idx),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.all(18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: Colors.deepPurple, width: 1.5),
                        ),
                      ),
                      child: Text(
                        '${String.fromCharCode(65 + idx)}. $option',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}