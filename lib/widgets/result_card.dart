import 'package:flutter/material.dart';

/// Widget Stateless reutilizable para mostrar los resultados y el análisis de los números.
class ResultCard extends StatelessWidget {
  final String operacionRealizada;
  final String resultado;
  final String analisisNum1;
  final String analisisNum2;

  const ResultCard({
    super.key,
    required this.operacionRealizada,
    required this.resultado,
    required this.analisisNum1,
    required this.analisisNum2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.deepPurple.shade50,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (operacionRealizada.isNotEmpty) ...[
              Text(
                'Operación: $operacionRealizada',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
            ],
            Text(
              resultado,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
            const Divider(height: 24, thickness: 1),
            const Text(
              'Análisis de Propiedades Numéricas:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              analisisNum1,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              analisisNum2,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
