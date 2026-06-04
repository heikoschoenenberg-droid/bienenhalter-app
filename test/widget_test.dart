import 'package:bienenhalter_app/app/bienenhalter_app.dart';
import 'package:bienenhalter_app/core/services/app_repositories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows dashboard on app start', (WidgetTester tester) async {
    await AppRepositories.instance.initialize();
    await tester.pumpWidget(const BienenhalterApp());
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Aktive Voelker'), findsOneWidget);
    expect(find.text('Offene Aufgaben'), findsOneWidget);
  });
}
