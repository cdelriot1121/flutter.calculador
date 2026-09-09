import 'package:flutter/material.dart';
import '../domain/calculator_logic.dart';

class NumberAnalysisCard extends StatelessWidget {
  final String label;
  final NumberProperties props;

  const NumberAnalysisCard({super.key, required this.label, required this.props});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.analytics_outlined, color: Colors.deepPurpleAccent, size: 22),
                const SizedBox(width: 8),
                Text(
                  'Propiedades de $label (${props.number})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Divider(height: 20, color: Colors.white24),
            _buildPropRow('Es Par', props.isEven),
            const SizedBox(height: 8),
            _buildPropRow('Es Primo', props.isPrime),
            const SizedBox(height: 8),
            _buildPropRow('Fibonacci (Primeros 20)', props.isFibonacci),
          ],
        ),
      ),
    );
  }

  Widget _buildPropRow(String title, bool value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: value ? Colors.green.shade900.withValues(alpha: 0.4) : Colors.red.shade900.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(
            value ? Icons.check : Icons.close,
            color: value ? Colors.greenAccent : Colors.redAccent,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value ? 'Sí' : 'No',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: value ? Colors.greenAccent : Colors.redAccent,
          ),
        ),
      ],
    );
  }
}
