import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'End-to-End Test: Membuka aplikasi, melihat list, dan masuk ke detail restoran',
    (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('Restaurant App'), findsOneWidget);

      final firstRestaurantCard = find.byType(Card).first;

      await tester.tap(firstRestaurantCard);

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Foods'), findsOneWidget);
    },
  );
}
