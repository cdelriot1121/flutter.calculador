import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_project/main.dart';

void main() {
  testWidgets('Carga inicial de la Calculadora', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Calculadora Layer-First'), findsOneWidget);
    expect(find.text('Calcular y Analizar'), findsOneWidget);
  });
}
