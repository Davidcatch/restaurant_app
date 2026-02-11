import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';

void main() {
  testWidgets(
    'Halaman List harus menampilkan judul dan subtitle dengan benar',
    (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => RestaurantProvider(apiService: ApiService()),
            ),
            ChangeNotifierProvider(
              create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
            ),
            ChangeNotifierProvider(create: (_) => SchedulingProvider()),
            ChangeNotifierProvider(
              create: (_) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                  sharedPreferences: Future.value(prefs),
                ),
              ),
            ),
          ],
          child: const MaterialApp(home: RestaurantListPage()),
        ),
      );

      expect(find.text('Restaurant'), findsWidgets);
      expect(
        find.text('Rekomendasi restoran terbaik untukmu!'),
        findsOneWidget,
      );
    },
  );
}
