import 'package:bienenhalter_app/app/bienenhalter_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows dashboard on app start', (WidgetTester tester) async {
    await tester.pumpWidget(const BienenhalterApp());

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Aktive Völker'), findsOneWidget);
    expect(find.text('Offene Aufgaben'), findsOneWidget);
  });
}
