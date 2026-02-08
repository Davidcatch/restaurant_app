import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/styles.dart';
import 'data/api/api_service.dart';
import 'provider/restaurant_provider.dart';
import 'ui/restaurant_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const RestaurantListPage(),
      ),
    );
  }
}
