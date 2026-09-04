import 'dart:math';

/// Servicio encargado de realizar las operaciones matemáticas
/// y verificaciones de propiedades numéricas (primo, par, fibonacci).
class CalculatorService {
  // Lista fija con los primeros 20 números de la sucesión de Fibonacci
  static const List<int> fibonacci20 = [
    0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 
    55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181
  ];

  /// Suma dos números
  double sumar(double a, double b) => a + b;

  /// Resta dos números
  double restar(double a, double b) => a - b;

  /// Multiplica dos números
  double multiplicar(double a, double b) => a * b;

  /// Divide dos números
  double dividir(double a, double b) {
    if (b == 0) throw Exception('No se puede dividir entre cero.');
    return a / b;
  }

  /// Potenciación: a elevado a la potencia b (a^b)
  double potenciar(double base, double exponente) {
    return pow(base, exponente).toDouble();
  }

  /// Radicación: Raíz 'b' de 'a' (a^(1/b)).
  /// Si el índice no se especifica o es 2, es raíz cuadrada.
  double radicar(double numero, double indice) {
    if (indice == 0) throw Exception('El índice de la raíz no puede ser cero.');
    if (numero < 0 && indice % 2 == 0) {
      throw Exception('Raíz con índice par de número negativo no es real.');
    }
    return pow(numero, 1 / indice).toDouble();
  }

  /// Verifica si un número es par (debe ser entero).
  bool esPar(double n) {
    if (n % 1 != 0) return false;
    return n.toInt() % 2 == 0;
  }

  /// Verifica si un número es primo (debe ser entero > 1).
  bool esPrimo(double n) {
    if (n % 1 != 0) return false;
    int num = n.toInt();
    if (num <= 1) return false;
    for (int i = 2; i * i <= num; i++) {
      if (num % i == 0) return false;
    }
    return true;
  }

  /// Verifica si un número está dentro de la lista de los primeros 20 de Fibonacci.
  bool esFibonacci(double n) {
    if (n % 1 != 0) return false;
    return fibonacci20.contains(n.toInt());
  }

  /// Genera un informe resumido del número para mostrar en la interfaz.
  String analizarNumero(String nombre, double? n) {
    if (n == null) return '$nombre: No ingresado';
    if (n % 1 != 0) return '$nombre ($n): Es decimal (las propiedades aplican a enteros)';
    
    int entero = n.toInt();
    final parStr = esPar(n) ? 'Par' : 'Impar';
    final primoStr = esPrimo(n) ? 'Es Primo' : 'No es Primo';
    final fiboStr = esFibonacci(n) ? 'Está en Fibonacci (1-20)' : 'No está en Fibonacci (1-20)';

    return '$nombre ($entero): $parStr | $primoStr | $fiboStr';
  }
}
