import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = const Color(0xFFFFFFFF);
final Color secondaryColor = const Color(0xFF6B38FB);

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
  useMaterial3: true,
  textTheme: GoogleFonts.poppinsTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.dark(
    primary: secondaryColor,
    onPrimary: Colors.black,
    secondary: secondaryColor,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
);
