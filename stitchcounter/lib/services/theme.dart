// theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color forestGreen = Color(0xFF2E7D32);
  static const Color canvasColor = Color(0xFFF9FBE7);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: forestGreen,
        brightness: Brightness.light,
        surface: canvasColor,
      ),
    );
  }
}
