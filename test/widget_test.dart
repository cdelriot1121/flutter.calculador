import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculadora_flutter/main.dart';

void main() {
  testWidgets('Prueba de calculadora app', (WidgetTester tester) async {
    // Renderizar la app
    await tester.pumpWidget(const MiCalculadoraApp());

    // Verificar que existe el título y los campos
    expect(find.text('Calculadora Flutter'), findsWidgets);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
