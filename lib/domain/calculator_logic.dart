import 'dart:math' as math;

class CalculationResult {
  final double value;
  final String? error;

  CalculationResult({required this.value, this.error});
  CalculationResult.error(this.error) : value = 0;
}

class NumberProperties {
  final double number;
  final bool isEven;
  final bool isPrime;
  final bool isFibonacci;

  NumberProperties({
    required this.number,
    required this.isEven,
    required this.isPrime,
    required this.isFibonacci,
  });
}

class CalculatorLogic {
  // Primeros 20 números de Fibonacci
  static final List<int> fibonacci20 = [
    0, 1, 1, 2, 3, 5, 8, 13, 21, 34,
    55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181
  ];

  static CalculationResult add(double a, double b) => CalculationResult(value: a + b);
  static CalculationResult subtract(double a, double b) => CalculationResult(value: a - b);
  static CalculationResult multiply(double a, double b) => CalculationResult(value: a * b);

  static CalculationResult divide(double a, double b) {
    if (b == 0) {
      return CalculationResult.error('No se puede dividir por cero');
    }
    return CalculationResult(value: a / b);
  }

  static CalculationResult power(double base, double exponent) =>
      CalculationResult(value: math.pow(base, exponent).toDouble());

  static CalculationResult root(double number, double nRoot) {
    if (nRoot == 0) {
      return CalculationResult.error('El índice de la raíz no puede ser cero');
    }
    if (number < 0 && nRoot % 2 == 0) {
      return CalculationResult.error('Raíz par de un número negativo no es real');
    }
    if (number < 0) {
      return CalculationResult(value: -math.pow(-number, 1 / nRoot).toDouble());
    }
    return CalculationResult(value: math.pow(number, 1 / nRoot).toDouble());
  }

  static CalculationResult log(double number, double base) {
    if (number <= 0) {
      return CalculationResult.error('El argumento del logaritmo debe ser > 0');
    }
    if (base <= 0 || base == 1) {
      return CalculationResult.error('La base del logaritmo debe ser > 0 y != 1');
    }
    return CalculationResult(value: math.log(number) / math.log(base));
  }

  static NumberProperties analyzeNumber(double number) {
    bool isInt = number % 1 == 0;
    int intVal = number.toInt();

    // Par / Impar (válido para enteros)
    bool even = isInt ? (intVal % 2 == 0) : false;

    // Primo (válido para enteros positivos > 1)
    bool prime = false;
    if (isInt && intVal > 1) {
      prime = true;
      for (int i = 2; i * i <= intVal; i++) {
        if (intVal % i == 0) {
          prime = false;
          break;
        }
      }
    }

    // Fibonacci (si está entre los primeros 20)
    bool fib = isInt && fibonacci20.contains(intVal);

    return NumberProperties(
      number: number,
      isEven: even,
      isPrime: prime,
      isFibonacci: fib,
    );
  }
}
