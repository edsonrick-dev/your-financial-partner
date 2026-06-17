import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,

    colorScheme: const ColorScheme.light(
      surface: Color(0xFFF4F7FA),
      onSurface: Color(0xFF141c29),
      primary: Color(0xFF141C29),
    ),
  );
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFf0a0e17),
      onSurface: Color(0xF0141c29),
    ),
  );
}
