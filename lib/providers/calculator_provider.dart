import 'package:flutter/material.dart';
import '../domain/calculator_logic.dart';

class CalculatorProvider extends ChangeNotifier {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();

  double? _result;
  String? _errorMessage;
  String _selectedOperation = '+';

  NumberProperties? _propsNum1;
  NumberProperties? _propsNum2;

  double? get result => _result;
  String? get errorMessage => _errorMessage;
  String get selectedOperation => _selectedOperation;
  NumberProperties? get propsNum1 => _propsNum1;
  NumberProperties? get propsNum2 => _propsNum2;

  void setOperation(String op) {
    _selectedOperation = op;
    notifyListeners();
  }

  void calculate() {
    _errorMessage = null;
    _result = null;

    final num1 = double.tryParse(num1Controller.text);
    final num2 = double.tryParse(num2Controller.text);

    if (num1 == null || num2 == null) {
      _errorMessage = 'Por favor ingrese ambos números correctamente.';
      _propsNum1 = null;
      _propsNum2 = null;
      notifyListeners();
      return;
    }

    _propsNum1 = CalculatorLogic.analyzeNumber(num1);
    _propsNum2 = CalculatorLogic.analyzeNumber(num2);

    CalculationResult res;
    switch (_selectedOperation) {
      case '+': res = CalculatorLogic.add(num1, num2); break;
      case '-': res = CalculatorLogic.subtract(num1, num2); break;
      case '*': res = CalculatorLogic.multiply(num1, num2); break;
      case '/': res = CalculatorLogic.divide(num1, num2); break;
      case '^': res = CalculatorLogic.power(num1, num2); break;
      case '√': res = CalculatorLogic.root(num1, num2); break;
      case 'log': res = CalculatorLogic.log(num1, num2); break;
      default: res = CalculatorLogic.add(num1, num2);
    }

    if (res.error != null) {
      _errorMessage = res.error;
    } else {
      _result = res.value;
    }
    notifyListeners();
  }
}
