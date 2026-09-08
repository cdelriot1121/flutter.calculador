import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_project/domain/calculator_logic.dart';

void main() {
  group('CalculatorLogic - Operaciones Básicas', () {
    test('Suma', () {
      expect(CalculatorLogic.add(5, 3).value, 8);
    });

    test('Resta', () {
      expect(CalculatorLogic.subtract(10, 4).value, 6);
    });

    test('Multiplicación', () {
      expect(CalculatorLogic.multiply(3, 7).value, 21);
    });

    test('División', () {
      expect(CalculatorLogic.divide(10, 2).value, 5);
      expect(CalculatorLogic.divide(5, 0).error, 'No se puede dividir por cero');
    });

    test('Potencia', () {
      expect(CalculatorLogic.power(2, 3).value, 8);
    });

    test('Raíz', () {
      expect(CalculatorLogic.root(9, 2).value, 3);
      expect(CalculatorLogic.root(-8, 3).value, -2);
      expect(CalculatorLogic.root(-4, 2).error, 'Raíz par de un número negativo no es real');
    });

    test('Logaritmo', () {
      expect(CalculatorLogic.log(100, 10).value, closeTo(2, 0.0001));
      expect(CalculatorLogic.log(-5, 10).error, 'El argumento del logaritmo debe ser > 0');
    });
  });

  group('CalculatorLogic - Análisis de Números', () {
    test('Identifica números pares', () {
      expect(CalculatorLogic.analyzeNumber(4).isEven, isTrue);
      expect(CalculatorLogic.analyzeNumber(7).isEven, isFalse);
    });

    test('Identifica números primos', () {
      expect(CalculatorLogic.analyzeNumber(7).isPrime, isTrue);
      expect(CalculatorLogic.analyzeNumber(4).isPrime, isFalse);
      expect(CalculatorLogic.analyzeNumber(1).isPrime, isFalse);
    });

    test('Identifica primeros 20 números de Fibonacci', () {
      expect(CalculatorLogic.analyzeNumber(0).isFibonacci, isTrue);
      expect(CalculatorLogic.analyzeNumber(13).isFibonacci, isTrue);
      expect(CalculatorLogic.analyzeNumber(4181).isFibonacci, isTrue);
      expect(CalculatorLogic.analyzeNumber(4).isFibonacci, isFalse);
    });
  });
}
