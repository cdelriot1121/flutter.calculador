import 'package:flutter/material.dart';

void main() {
  runApp(const MiSumadoraApp());
}

class MiSumadoraApp extends StatelessWidget {
  const MiSumadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sumadora Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SumadoraPage(),
    );
  }
}

class SumadoraPage extends StatefulWidget {
  const SumadoraPage({super.key});

  @override
  State<SumadoraPage> createState() => _SumadoraPageState();
}

class _SumadoraPageState extends State<SumadoraPage> {
  // estos son controladores capturar el texto que el usuario escribe en cada campo
  final TextEditingController _numero1Controller = TextEditingController();
  final TextEditingController _numero2Controller = TextEditingController();

  
  String _resultado = '';

  // funcion principal para realizar la suma
  void _sumar() {
    
    final String texto1 = _numero1Controller.text.trim();
    final String texto2 = _numero2Controller.text.trim();

    
    final double? num1 = double.tryParse(texto1);
    final double? num2 = double.tryParse(texto2);

    setState(() {
      if (num1 != null && num2 != null) {
        final double suma = num1 + num2;
        
        if (suma % 1 == 0) {
          _resultado = 'Resultado: ${suma.toInt()}';
        } else {
          _resultado = 'Resultado: $suma';
        }
      } else {
        _resultado = 'Por favor ingresa números válidos en ambos campos.';
      }
    });
  }

  // Buenas prácticas: Liberar la memoria de los controladores al destruir el widget
  @override
  void dispose() {
    _numero1Controller.dispose();
    _numero2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sumadora Flutter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.calculate_outlined,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),

              // Campo de texto 1
              TextField(
                controller: _numero1Controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Primer número',
                  hintText: 'Ingresa el primer número',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.looks_one),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de texto 2
              TextField(
                controller: _numero2Controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Segundo número',
                  hintText: 'Ingresa el segundo número',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.looks_two),
                ),
              ),
              const SizedBox(height: 24),

              // Botón para calcular
              ElevatedButton.icon(
                onPressed: _sumar,
                icon: const Icon(Icons.add),
                label: const Text(
                  'Calcular Suma',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // Mostrar el resultado si no está vacío
              if (_resultado.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Text(
                    _resultado,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
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
