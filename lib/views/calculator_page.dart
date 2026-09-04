import 'package:flutter/material.dart';
import '../services/calculator_service.dart';
import '../widgets/result_card.dart';

/// Widget Stateful que maneja el estado de la interfaz de la calculadora.
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Instancia del servicio con las operaciones y lógica
  final CalculatorService _calculatorService = CalculatorService();

  // Controladores de texto para los campos de entrada
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  // Variables de estado
  String _resultado = '';
  String _operacionRealizada = '';
  String _analisisNum1 = '';
  String _analisisNum2 = '';

  void _calcular(String operacion) {
    final String texto1 = _num1Controller.text.trim();
    final String texto2 = _num2Controller.text.trim();

    final double? num1 = double.tryParse(texto1);
    final double? num2 = double.tryParse(texto2);

    if (num1 == null || num2 == null) {
      setState(() {
        _resultado = 'Por favor, ingresa números válidos en ambos campos.';
        _operacionRealizada = '';
        _analisisNum1 = '';
        _analisisNum2 = '';
      });
      return;
    }

    double res = 0;
    String simbolo = '';

    try {
      switch (operacion) {
        case 'suma':
          res = _calculatorService.sumar(num1, num2);
          simbolo = '+';
          break;
        case 'resta':
          res = _calculatorService.restar(num1, num2);
          simbolo = '-';
          break;
        case 'multiplicacion':
          res = _calculatorService.multiplicar(num1, num2);
          simbolo = '×';
          break;
        case 'division':
          res = _calculatorService.dividir(num1, num2);
          simbolo = '÷';
          break;
        case 'potencia':
          res = _calculatorService.potenciar(num1, num2);
          simbolo = '^';
          break;
        case 'radicacion':
          res = _calculatorService.radicar(num1, num2);
          simbolo = '√';
          break;
      }

      // Formatear el resultado visual
      String resFormatted = (res % 1 == 0)
          ? res.toInt().toString()
          : res.toStringAsFixed(4).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');

      setState(() {
        if (operacion == 'radicacion') {
          _operacionRealizada = 'Raíz $num2 de $num1';
        } else {
          _operacionRealizada = '$num1 $simbolo $num2';
        }
        _resultado = 'Resultado: $resFormatted';
        _analisisNum1 = _calculatorService.analizarNumero('Número 1', num1);
        _analisisNum2 = _calculatorService.analizarNumero('Número 2', num2);
      });
    } catch (e) {
      setState(() {
        _resultado = 'Error: ${e.toString().replaceAll('Exception: ', '')}';
        _operacionRealizada = '';
        _analisisNum1 = _calculatorService.analizarNumero('Número 1', num1);
        _analisisNum2 = _calculatorService.analizarNumero('Número 2', num2);
      });
    }
  }

  void _limpiarCampos() {
    setState(() {
      _num1Controller.clear();
      _num2Controller.clear();
      _resultado = '';
      _operacionRealizada = '';
      _analisisNum1 = '';
      _analisisNum2 = '';
    });
  }

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Avanzada'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Limpiar todo',
            onPressed: _limpiarCampos,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.calculate_rounded,
                size: 70,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 16),

              // Campos de texto de entrada
              TextField(
                controller: _num1Controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                decoration: const InputDecoration(
                  labelText: 'Número 1 (Base / Radicando)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.looks_one),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _num2Controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                decoration: const InputDecoration(
                  labelText: 'Número 2 (Exponente / Índice)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.looks_two),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Selecciona una operación:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Fila 1: Suma y Resta
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _calcular('suma'),
                      icon: const Icon(Icons.add),
                      label: const Text('Sumar'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _calcular('resta'),
                      icon: const Icon(Icons.remove),
                      label: const Text('Restar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Fila 2: Multiplicación y División
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _calcular('multiplicacion'),
                      icon: const Icon(Icons.close),
                      label: const Text('Multiplicar'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _calcular('division'),
                      icon: const Icon(Icons.percent),
                      label: const Text('Dividir'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Fila 3: Potenciación y Radicación
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _calcular('potencia'),
                      icon: const Icon(Icons.superscript),
                      label: const Text('Potencia (^)', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _calcular('radicacion'),
                      icon: const Icon(Icons.square_foot),
                      label: const Text('Raíz (√)', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: _limpiarCampos,
                icon: const Icon(Icons.cleaning_services),
                label: const Text('Limpiar Todo'),
              ),

              // Widget stateless para mostrar resultado e informe
              if (_resultado.isNotEmpty)
                ResultCard(
                  operacionRealizada: _operacionRealizada,
                  resultado: _resultado,
                  analisisNum1: _analisisNum1,
                  analisisNum2: _analisisNum2,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
