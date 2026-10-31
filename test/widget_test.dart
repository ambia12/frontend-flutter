import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_flutter/main.dart';

void main() {
  testWidgets('Kantingo app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KantingoApp());
    expect(find.byType(KantingoApp), findsOneWidget);
  });
}
