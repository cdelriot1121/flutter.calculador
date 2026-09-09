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
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Container(
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xFF161622),
                borderRadius: BorderRadius.circular(36),
                border: Border.all(color: Colors.white12, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: Column(
                  children: [
                    // Mobile-like Header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: const BoxDecoration(
                        color: Color(0xFF1E1E2C),
                        border: Border(bottom: BorderSide(color: Colors.white10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.calculate_outlined, color: Colors.deepPurpleAccent, size: 24),
                              SizedBox(width: 10),
                              Text(
                                'Calculadora Analítica',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.dark_mode, color: Colors.deepPurpleAccent, size: 18),
                          ),
                        ],
                      ),
                    ),
                    // Scrollable Body
                    Expanded(
                      child: Consumer<CalculatorProvider>(
                        builder: (context, provider, child) {
                          return SingleChildScrollView(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Inputs Card
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E1E2C),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white10),
                                  ),
                                  child: Column(
                                    children: [
                                      _buildTextField(provider.num1Controller, 'Número 1', Icons.looks_one_outlined),
                                      const SizedBox(height: 16),
                                      _buildTextField(provider.num2Controller, 'Número 2', Icons.looks_two_outlined),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Seleccione Operación',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _buildOperationSelector(provider),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: provider.calculate,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurpleAccent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    elevation: 4,
                                    shadowColor: Colors.deepPurpleAccent.withValues(alpha: 0.5),
                                  ),
                                  child: const Text(
                                    'Calcular y Analizar',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                if (provider.errorMessage != null) ...[
                                  _buildErrorCard(provider.errorMessage!),
                                  const SizedBox(height: 16),
                                ],
                                if (provider.result != null) ...[
                                  ResultCard(result: provider.result!),
                                  const SizedBox(height: 16),
                                ],
                                if (provider.propsNum1 != null) ...[
                                  NumberAnalysisCard(label: 'Número 1', props: provider.propsNum1!),
                                  const SizedBox(height: 16),
                                ],
                                if (provider.propsNum2 != null) ...[
                                  NumberAnalysisCard(label: 'Número 2', props: provider.propsNum2!),
                                  const SizedBox(height: 16),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: Colors.deepPurpleAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFF12121B),
      ),
    );
  }

  Widget _buildOperationSelector(CalculatorProvider provider) {
    final ops = [
      {'label': '+ Suma', 'val': '+'},
      {'label': '- Resta', 'val': '-'},
      {'label': '× Multiplicación', 'val': '*'},
      {'label': '÷ División', 'val': '/'},
      {'label': '^ Potencia', 'val': '^'},
      {'label': '√ Raíz', 'val': '√'},
      {'label': 'log', 'val': 'log'},
    ];

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: ops.map((op) {
        final isSelected = provider.selectedOperation == op['val'];
        return ChoiceChip(
          label: Text(op['label']!),
          selected: isSelected,
          selectedColor: Colors.deepPurple.shade700,
          backgroundColor: const Color(0xFF1E1E2C),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? Colors.deepPurpleAccent : Colors.white12,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          onSelected: (_) => provider.setOperation(op['val']!),
        );
      }).toList(),
    );
  }

  Widget _buildErrorCard(String error) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade900.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              error,
              style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
