#include "math_utils.h"
#include <iostream>

int main() {
    int x = 10;
    int y = 5;

    int sum = add(x, y);
    printResult(x, y, sum);

    int product = multiply(x, y);
    printResult(x, y, product);

    int division = divide(x, y);
    printResult(x, y, division);

    return 0;
}