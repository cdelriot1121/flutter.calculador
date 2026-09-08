import 'package:flutter/material.dart';
import '../domain/calculator_logic.dart';

class CalculatorPresentation extends StatefulWidget {
  const CalculatorPresentation({super.key});

  @override
  State<CalculatorPresentation> createState() => _CalculatorPresentationState();
}

class _CalculatorPresentationState extends State<CalculatorPresentation> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  double? _num1;
  double? _num2;
  double? _result;
  String? _errorMessage;
  String _selectedOperation = '+';

  NumberProperties? _propsNum1;
  NumberProperties? _propsNum2;

  void _calculate() {
    setState(() {
      _errorMessage = null;
      _result = null;

      _num1 = double.tryParse(_num1Controller.text);
      _num2 = double.tryParse(_num2Controller.text);

      if (_num1 == null || _num2 == null) {
        _errorMessage = 'Por favor ingrese ambos números correctamente.';
        _propsNum1 = null;
        _propsNum2 = null;
        return;
      }

      _propsNum1 = CalculatorLogic.analyzeNumber(_num1!);
      _propsNum2 = CalculatorLogic.analyzeNumber(_num2!);

      CalculationResult res;
      switch (_selectedOperation) {
        case '+':
          res = CalculatorLogic.add(_num1!, _num2!);
          break;
        case '-':
          res = CalculatorLogic.subtract(_num1!, _num2!);
          break;
        case '*':
          res = CalculatorLogic.multiply(_num1!, _num2!);
          break;
        case '/':
          res = CalculatorLogic.divide(_num1!, _num2!);
          break;
        case '^':
          res = CalculatorLogic.power(_num1!, _num2!);
          break;
        case '√':
          res = CalculatorLogic.root(_num1!, _num2!);
          break;
        case 'log':
          res = CalculatorLogic.log(_num1!, _num2!);
          break;
        default:
          res = CalculatorLogic.add(_num1!, _num2!);
      }

      if (res.error != null) {
        _errorMessage = res.error;
      } else {
        _result = res.value;
      }
    });
  }

  Widget _buildNumberAnalysis(String label, NumberProperties? props) {
    if (props == null) return const SizedBox.shrink();
    return Card(
      color: Colors.deepPurple.shade50,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Propiedades de $label (${props.number}):',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  props.isEven ? Icons.check_circle : Icons.cancel,
                  color: props.isEven ? Colors.green : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text('Es Par: ${props.isEven ? "Sí" : "No"}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  props.isPrime ? Icons.check_circle : Icons.cancel,
                  color: props.isPrime ? Colors.green : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text('Es Primo: ${props.isPrime ? "Sí" : "No"}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  props.isFibonacci ? Icons.check_circle : Icons.cancel,
                  color: props.isFibonacci ? Colors.green : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text('En los primeros 20 de Fibonacci: ${props.isFibonacci ? "Sí" : "No"}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Layer-First'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _num1Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(
                labelText: 'Número 1 (o base / radicando / arg)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.pin),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _num2Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(
                labelText: 'Número 2 (o exponente / índice / base de log)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.pin),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Operación:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('+ Suma'),
                  selected: _selectedOperation == '+',
                  onSelected: (val) => setState(() => _selectedOperation = '+'),
                ),
                ChoiceChip(
                  label: const Text('- Resta'),
                  selected: _selectedOperation == '-',
                  onSelected: (val) => setState(() => _selectedOperation = '-'),
                ),
                ChoiceChip(
                  label: const Text('* Multiplicación'),
                  selected: _selectedOperation == '*',
                  onSelected: (val) => setState(() => _selectedOperation = '*'),
                ),
                ChoiceChip(
                  label: const Text('/ División'),
                  selected: _selectedOperation == '/',
                  onSelected: (val) => setState(() => _selectedOperation = '/'),
                ),
                ChoiceChip(
                  label: const Text('^ Potencia'),
                  selected: _selectedOperation == '^',
                  onSelected: (val) => setState(() => _selectedOperation = '^'),
                ),
                ChoiceChip(
                  label: const Text('√ Raíz (num1 √ num2)'),
                  selected: _selectedOperation == '√',
                  onSelected: (val) => setState(() => _selectedOperation = '√'),
                ),
                ChoiceChip(
                  label: const Text('log (base num2)'),
                  selected: _selectedOperation == 'log',
                  onSelected: (val) => setState(() => _selectedOperation = 'log'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _calculate,
              icon: const Icon(Icons.calculate),
              label: const Text('Calcular y Analizar', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            if (_result != null)
              Card(
                color: Colors.purple.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Resultado:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_result',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 10),
            _buildNumberAnalysis('Número 1', _propsNum1),
            _buildNumberAnalysis('Número 2', _propsNum2),
          ],
        ),
      ),
    );
  }
}
