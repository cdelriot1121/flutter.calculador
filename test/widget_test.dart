import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sumadora_flutter/main.dart';

void main() {
  testWidgets('Prueba de suma en MiSumadoraApp', (WidgetTester tester) async {
    // Renderizar la app
    await tester.pumpWidget(const MiSumadoraApp());

    // Verificar que existe el título y los campos
    expect(find.text('Sumadora Flutter'), findsWidgets);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
