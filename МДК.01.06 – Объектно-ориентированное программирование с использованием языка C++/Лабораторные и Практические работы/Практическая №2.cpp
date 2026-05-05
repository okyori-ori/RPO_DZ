#include <iostream>
#include <stdexcept>
using namespace std;

class Fraction {
private:
    int numerator;
    int denominator;

   
    int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return abs(a);
    }

    void normalizeSign() {
        if (denominator < 0) {
            numerator = -numerator;
            denominator = -denominator;
        }
    }

public:

    Fraction() {
        numerator = 0;
        denominator = 1;
    }


    Fraction(int num, int den) {
        if (den == 0) {
            cout << "Ошибка: знаменатель не может быть 0. Установлено 1.\n";
            denominator = 1;
        }
        else {
            denominator = den;
        }
        numerator = num;

        simplify();
    }

    void print() const {
        cout << numerator << "/" << denominator << endl;
    }

   
    void simplify() {
        int g = gcd(numerator, denominator);
        numerator /= g;
        denominator /= g;
        normalizeSign();
    }

   
    Fraction operator+(const Fraction& other) const {
        int num = numerator * other.denominator + other.numerator * denominator;
        int den = denominator * other.denominator;
        return Fraction(num, den);
    }

   
    Fraction operator-(const Fraction& other) const {
        int num = numerator * other.denominator - other.numerator * denominator;
        int den = denominator * other.denominator;
        return Fraction(num, den);
    }

    
    Fraction operator*(const Fraction& other) const {
        return Fraction(numerator * other.numerator,
            denominator * other.denominator);
    }

    Fraction operator/(const Fraction& other) const {
        if (other.numerator == 0) {
            throw runtime_error("Ошибка: деление на 0!");
        }
        return Fraction(numerator * other.denominator,
            denominator * other.numerator);
    }

   
    bool operator==(const Fraction& other) const {
        return numerator * other.denominator ==
            other.numerator * denominator;
    }

   
    friend ostream& operator<<(ostream& os, const Fraction& f) {
        os << f.numerator << "/" << f.denominator;
        return os;
    }
};

//  MAIN 

int main() {
    Fraction f1(1, 2);
    Fraction f2(3, 4);

    cout << "f1 = " << f1 << endl;
    cout << "f2 = " << f2 << endl;

    Fraction sum = f1 + f2;
    Fraction diff = f1 - f2;
    Fraction mult = f1 * f2;
    Fraction div = f1 / f2;

    cout << "Сложение: " << sum << endl;
    cout << "Вычитание: " << diff << endl;
    cout << "Умножение: " << mult << endl;
    cout << "Деление: " << div << endl;

    if (f1 == f2) {
        cout << "Дроби равны\n";
    }
    else {
        cout << "Дроби не равны\n";
    }

    return 0;
}