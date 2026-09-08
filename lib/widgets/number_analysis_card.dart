import 'package:flutter/material.dart';
import '../domain/calculator_logic.dart';

class NumberAnalysisCard extends StatelessWidget {
  final String label;
  final NumberProperties props;

  const NumberAnalysisCard({super.key, required this.label, required this.props});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Propiedades de $label (${props.number}):', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            _buildPropRow('Par', props.isEven),
            _buildPropRow('Primo', props.isPrime),
            _buildPropRow('Fibonacci (20)', props.isFibonacci),
          ],
        ),
      ),
    );
  }

  Widget _buildPropRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(value ? Icons.check : Icons.close, color: value ? Colors.green : Colors.red, size: 18),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
