import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final double result;

  const ResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Resultado:', style: TextStyle(fontSize: 16)),
            Text('$result', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
          ],
        ),
      ),
    );
  }
}
