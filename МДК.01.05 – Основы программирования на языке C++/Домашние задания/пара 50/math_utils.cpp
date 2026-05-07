#include "math_utils.h"
#include <iostream>

int add(int a, int b) {
    return a + b;
}

int multiply(int a, int b) {
    return a * b;
}

int divide(int a, int b) {
    if (b == 0) {
        std::cout << "Ошибка: деление на ноль!" << std::endl;
        return 0;
    }
    return a / b;
}

void printResult(int a, int b, int result) {
    std::cout << "Результат: " << a << " и " << b << " = " << result << std::endl;
}