import 'package:flutter/material.dart';

void main() {
  runApp(const MiCalculadoraApp());
}

class MiCalculadoraApp extends StatelessWidget {
  const MiCalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Básica Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  // ===========================================================================
  // PASO 1: Controladores de texto (TextEditingController)
  // Sirven para leer lo que el usuario ingresa en los TextField.
  // ===========================================================================
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  // ===========================================================================
  // PASO 2: Variables de estado
  // _resultado: Almacena el mensaje o el número final calculado.
  // _operacionRealizada: Muestra el detalle de la operación (ej: "10 + 5").
  // ===========================================================================
  String _resultado = '';
  String _operacionRealizada = '';

  // ===========================================================================
  // PASO 3: Función lógica principal para realizar las 4 operaciones
  // Recibe un String 'operacion' (suma, resta, multiplicacion, division)
  // ===========================================================================
  void _calcular(String operacion) {
    // 3.1 Obtener el texto ingresado y quitar espacios en blanco con .trim()
    final String texto1 = _num1Controller.text.trim();
    final String texto2 = _num2Controller.text.trim();

    // 3.2 Convertir el texto a tipo numérico 'double' usando double.tryParse()
    final double? num1 = double.tryParse(texto1);
    final double? num2 = double.tryParse(texto2);

    // 3.3 Validación de entradas vacías o inválidas
    if (num1 == null || num2 == null) {
      setState(() {
        _resultado = 'Por favor, ingresa números válidos en ambos campos.';
        _operacionRealizada = '';
      });
      return;
    }

    double res = 0;
    String simbolo = '';

    // 3.4 Estructura de control switch para determinar la operación matemática
    switch (operacion) {
      case 'suma':
        res = num1 + num2;
        simbolo = '+';
        break;
      case 'resta':
        res = num1 - num2;
        simbolo = '-';
        break;
      case 'multiplicacion':
        res = num1 * num2;
        simbolo = '×';
        break;
      case 'division':
        simbolo = '÷';
        // Validación matemática: Evitar la división por cero
        if (num2 == 0) {
          setState(() {
            _resultado = 'Error: No se puede dividir entre cero.';
            _operacionRealizada = '$num1 ÷ 0';
          });
          return;
        }
        res = num1 / num2;
        break;
    }

    // 3.5 setState() le notifica a Flutter que la interfaz debe actualizarse
    setState(() {
      _operacionRealizada = '$num1 $simbolo $num2';

      // Si el resultado es un número entero exacto (ej. 8.0), mostramos solo 8
      if (res % 1 == 0) {
        _resultado = 'Resultado: ${res.toInt()}';
      } else {
        // Redondeamos a un máximo de 4 decimales para que no se extienda demasiado
        String resultadoFormateado = res.toStringAsFixed(4);
        // Eliminamos ceros sobrantes al final del decimal (ej. 3.5000 -> 3.5)
        resultadoFormateado = resultadoFormateado
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
        _resultado = 'Resultado: $resultadoFormateado';
      }
    });
  }

  // ===========================================================================
  // PASO 4: Función para limpiar todos los campos
  // ===========================================================================
  void _limpiarCampos() {
    setState(() {
      _num1Controller.clear();
      _num2Controller.clear();
      _resultado = '';
      _operacionRealizada = '';
    });
  }

  // ===========================================================================
  // PASO 5: Liberar controladores de la memoria al salir de la pantalla
  // ===========================================================================
  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  // ===========================================================================
  // PASO 6: Construcción visual de la pantalla (Widget build)
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Básica'),
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
                size: 80,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),

              // Campo de entrada 1
              TextField(
                controller: _num1Controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Primer número',
                  hintText: 'Ejemplo: 12',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.looks_one),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de entrada 2
              TextField(
                controller: _num2Controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Segundo número',
                  hintText: 'Ejemplo: 4',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.looks_two),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Selecciona una operación:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Botones de Suma y Resta en una Fila (Row)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _calcular('suma'),
                      icon: const Icon(Icons.add),
                      label: const Text('Sumar'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _calcular('resta'),
                      icon: const Icon(Icons.remove),
                      label: const Text('Restar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Botones de Multiplicación y División en una Fila (Row)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _calcular('multiplicacion'),
                      icon: const Icon(Icons.close),
                      label: const Text('Multiplicar'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _calcular('division'),
                      icon: const Icon(Icons.safety_divider),
                      label: const Text('Dividir'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Botón Limpiar Todo
              OutlinedButton.icon(
                onPressed: _limpiarCampos,
                icon: const Icon(Icons.cleaning_services),
                label: const Text('Limpiar Todo'),
              ),
              const SizedBox(height: 24),

              // Contenedor/Tarjeta para mostrar el resultado
              if (_resultado.isNotEmpty)
                Card(
                  elevation: 4,
                  color: Colors.deepPurple.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        if (_operacionRealizada.isNotEmpty)
                          Text(
                            'Operación: $_operacionRealizada',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurple.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          _resultado,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
