import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.light(
      surface: AppPalette.color100,
      onSurface: AppPalette.color900,
      primary: AppPalette.accent,
    ),
  );
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFf0a0e17),
      onSurface: AppPalette.color100,
    ),
  );
}
