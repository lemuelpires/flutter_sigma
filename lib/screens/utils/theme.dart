import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        color: Color(0xFF101419),
        iconTheme: IconThemeData(color: Colors.white),
        toolbarTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF7FFF00),
        primary: const Color(0xFF101419),
        secondary: const Color(0xFF7FFF00),
      ),
    );
  }
}
