import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../widgets/number_analysis_card.dart';
import '../widgets/result_card.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: Consumer<CalculatorProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(provider.num1Controller, 'Número 1'),
                const SizedBox(height: 16),
                _buildTextField(provider.num2Controller, 'Número 2'),
                const SizedBox(height: 24),
                const Text('Operación:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildOperationSelector(provider),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: provider.calculate,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calcular'),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                ),
                const SizedBox(height: 24),
                if (provider.errorMessage != null) _buildErrorCard(provider.errorMessage!),
                if (provider.result != null) ResultCard(result: provider.result!),
                if (provider.propsNum1 != null) NumberAnalysisCard(label: 'Número 1', props: provider.propsNum1!),
                if (provider.propsNum2 != null) NumberAnalysisCard(label: 'Número 2', props: provider.propsNum2!),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
    );
  }

  Widget _buildOperationSelector(CalculatorProvider provider) {
    final ops = ['+', '-', '*', '/', '^', '√', 'log'];
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: ops.map((op) => ChoiceChip(
        label: Text(op),
        selected: provider.selectedOperation == op,
        onSelected: (_) => provider.setOperation(op),
      )).toList(),
    );
  }

  Widget _buildErrorCard(String error) {
    return Card(
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(error, style: TextStyle(color: Colors.red.shade900, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
