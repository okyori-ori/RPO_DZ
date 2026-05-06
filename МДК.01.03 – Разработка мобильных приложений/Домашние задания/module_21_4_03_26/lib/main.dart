import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  String _currentNumber = '';
  String _operator = '';
  double _firstNumber = 0;
  double _secondNumber = 0;

  void _handleButtonPress(String value) {
    setState(() {
      if (value == 'C') {
        _clear();
      } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
        _setOperator(value);
      } else if (value == '=') {
        _calculate();
      } else if (value == '±') {
        _toggleSign();
      } else if (value == '%') {
        _percentage();
      } else {
        _appendNumber(value);
      }
    });
  }

  void _clear() {
    _display = '0';
    _currentNumber = '';
    _operator = '';
    _firstNumber = 0;
    _secondNumber = 0;
  }

  void _setOperator(String op) {
    if (_currentNumber.isNotEmpty) {
      _firstNumber = double.parse(_currentNumber);
      _operator = op;
      _currentNumber = '';
    } else if (_operator.isNotEmpty) {
      _operator = op;
    }
  }

  void _calculate() {
    if (_currentNumber.isNotEmpty && _operator.isNotEmpty) {
      _secondNumber = double.parse(_currentNumber);
      double result = 0;

      switch (_operator) {
        case '+':
          result = _firstNumber + _secondNumber;
          break;
        case '-':
          result = _firstNumber - _secondNumber;
          break;
        case '×':
          result = _firstNumber * _secondNumber;
          break;
        case '÷':
          if (_secondNumber != 0) {
            result = _firstNumber / _secondNumber;
          } else {
            _display = 'Ошибка';
            return;
          }
          break;
      }

      _display = result.toString();
      if (_display.endsWith('.0')) {
        _display = _display.substring(0, _display.length - 2);
      }
      _currentNumber = _display;
      _operator = '';
    }
  }

  void _appendNumber(String number) {
    if (_currentNumber == '0' && number != '.') {
      _currentNumber = number;
    } else {
      _currentNumber += number;
    }
    _display = _currentNumber;
  }

  void _toggleSign() {
    if (_currentNumber.isNotEmpty) {
      double num = double.parse(_currentNumber);
      num = -num;
      _currentNumber = num.toString();
      if (_currentNumber.endsWith('.0')) {
        _currentNumber = _currentNumber.substring(0, _currentNumber.length - 2);
      }
      _display = _currentNumber;
    }
  }

  void _percentage() {
    if (_currentNumber.isNotEmpty) {
      double num = double.parse(_currentNumber);
      num = num / 100;
      _currentNumber = num.toString();
      if (_currentNumber.endsWith('.0')) {
        _currentNumber = _currentNumber.substring(0, _currentNumber.length - 2);
      }
      _display = _currentNumber;
    }
  }

  Widget buildButton(String text, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: () => _handleButtonPress(text),
          child: Container(
            decoration: BoxDecoration(
              color: color ?? Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Дисплей
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerRight,
            child: Text(
              _display,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Кнопки
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Ряд 1: C, ±, %, ÷
                  Row(
                    children: [
                      buildButton('C', color: Colors.red[300], textColor: Colors.white),
                      buildButton('±', color: Colors.grey[600], textColor: Colors.white),
                      buildButton('%', color: Colors.grey[600], textColor: Colors.white),
                      buildButton('÷', color: Colors.orange, textColor: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Ряд 2: 7, 8, 9, ×
                  Row(
                    children: [
                      buildButton('7', color: Colors.grey[400], textColor: Colors.white),
                      buildButton('8', color: Colors.grey[400], textColor: Colors.white),
                      buildButton('9', color: Colors.grey[400], textColor: Colors.white),
                      buildButton('×', color: Colors.orange, textColor: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Ряд 3: 4, 5, 6, -
                  Row(
                    children: [
                      buildButton('4', color: Colors.grey[400], textColor: Colors.white),
                      buildButton('5', color: Colors.grey[400], textColor: Colors.white),
                      buildButton('6', color: Colors.grey[400], textColor: Colors.white),
                      buildButton('-', color: Colors.orange, textColor: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Ряд 4: 1, 2, 3, +
                  Row(
                    children: [
                      buildButton('1', color: Colors.grey[400], textColor: Colors.white),
                      buildButton('2', color: Colors.grey[400], textColor: Colors.white),
                      buildButton('3', color: Colors.grey[400], textColor: Colors.white),
                      buildButton('+', color: Colors.orange, textColor: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Ряд 5: 0, ., =
                  Row(
                    children: [
                      buildButton('0', color: Colors.grey[400], textColor: Colors.white),
                      buildButton('.', color: Colors.grey[400], textColor: Colors.white),
                      buildButton('=', color: Colors.green, textColor: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}