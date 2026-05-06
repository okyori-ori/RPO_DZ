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
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Кто написал роман "Тихий Дон"?',
      'options': ['Лев Толстой', 'Михаил Шолохов', 'Фёдор Достоевский', 'Антон Чехов'],
      'correct': 1,
    },
    {
      'question': 'Какая планета находится ближе всего к Солнцу?',
      'options': ['Венера', 'Земля', 'Марс', 'Меркурий'],
      'correct': 3,
    },
    {
      'question': 'Сколько цветов в радуге?',
      'options': ['5', '6', '7', '8'],
      'correct': 2,
    },
    {
      'question': 'Какой язык программирования используется для разработки приложений на Flutter?',
      'options': ['JavaScript', 'Python', 'Dart', 'Kotlin'],
      'correct': 2,
    },
    {
      'question': 'Кто написал "Войну и мир"?',
      'options': ['Фёдор Достоевский', 'Михаил Булгаков', 'Лев Толстой', 'Иван Тургенев'],
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
    // 🏆 ЭКРАН РЕЗУЛЬТАТА С ГРАМОТОЙ
    if (_showResult) {
      widget.onFinish(_score);

      // Форматируем дату: "17 апреля 2026"
      final now = DateTime.now();
      const months = [
        'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
        'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
      ];
      final formattedDate = '${now.day} ${months[now.month - 1]} ${now.year}';

      return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          title: const Text('🏆 Ваша грамота'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            width: 350,
            height: 500,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple.shade100,
                  Colors.deepPurple.shade50,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.deepPurple.shade300,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: CustomPaint(
              painter: CertificatePainter(
                userName: 'Мингазов Я Саша',
                score: _score,
                totalQuestions: _questions.length,
                formattedDate: formattedDate,
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              _restart();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('🔄 Играть снова', style: TextStyle(fontSize: 18)),
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
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== КАСТОМНЫЙ ХУДОЖНИК ДЛЯ ГРАМОТЫ ====================

class CertificatePainter extends CustomPainter {
  final String userName;
  final int score;
  final int totalQuestions;
  final String formattedDate;

  CertificatePainter({
    required this.userName,
    required this.score,
    required this.totalQuestions,
    required this.formattedDate,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // Золотая рамка
    final borderPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final rect = RRect.fromLTRBR(10, 10, width - 10, height - 10, const Radius.circular(16));
    canvas.drawRRect(rect, borderPaint);

    // Медалька сверху
    final medalPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(width / 2, 70), 40, medalPaint);

    final medalTextPainter = TextPainter(
      text: const TextSpan(
        text: '🏆',
        style: TextStyle(fontSize: 40),
      ),
      textDirection: TextDirection.ltr,
    );
    medalTextPainter.layout();
    medalTextPainter.paint(
      canvas,
      Offset(width / 2 - medalTextPainter.width / 2, 70 - medalTextPainter.height / 2),
    );

    // Заголовок "ГРАМОТА"
    final titlePainter = TextPainter(
      text: const TextSpan(
        text: 'ГРАМОТА',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4A148C),
          letterSpacing: 4,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    titlePainter.layout(maxWidth: width - 40);
    titlePainter.paint(canvas, Offset((width - titlePainter.width) / 2, 130));

    // Линия под заголовком
    final linePaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(width / 2 - 100, 165),
      Offset(width / 2 + 100, 165),
      linePaint,
    );

    // Текст "Награждается"
    final awardPainter = TextPainter(
      text: const TextSpan(
        text: 'НАГРАЖДАЕТСЯ',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF757575),
          letterSpacing: 2,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    awardPainter.layout(maxWidth: width - 40);
    awardPainter.paint(canvas, Offset((width - awardPainter.width) / 2, 190));

    // Имя пользователя
    final namePainter = TextPainter(
      text: TextSpan(
        text: userName,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4A148C),
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    namePainter.layout(maxWidth: width - 80);
    namePainter.paint(canvas, Offset((width - namePainter.width) / 2, 230));

    // Результат
    final scorePainter = TextPainter(
      text: const TextSpan(
        text: 'за успешное прохождение викторины',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF616161),
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    scorePainter.layout(maxWidth: width - 80);
    scorePainter.paint(canvas, Offset((width - scorePainter.width) / 2, 280));

    // Счёт
    final resultPainter = TextPainter(
      text: TextSpan(
        text: '$score из $totalQuestions баллов',
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFD700),
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    resultPainter.layout(maxWidth: width - 80);
    resultPainter.paint(canvas, Offset((width - resultPainter.width) / 2, 320));

    // Подпись
    final signaturePainter = TextPainter(
      text: const TextSpan(
        text: '_______\nОрганизационный комитет',
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF9E9E9E),
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    signaturePainter.layout(maxWidth: width - 80);
    signaturePainter.paint(canvas, Offset((width - signaturePainter.width) / 2, 390));

    // ✅ ДАТА ВНИЗУ (мелким шрифтом, серая, 14px, по центру)
    final dateText = 'Дата: $formattedDate';
    final datePainter = TextPainter(
      text: TextSpan(
        text: dateText,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF9E9E9E),
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    datePainter.layout(maxWidth: width - 80);
    datePainter.paint(
      canvas,
      Offset((width - datePainter.width) / 2, height - 40),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}