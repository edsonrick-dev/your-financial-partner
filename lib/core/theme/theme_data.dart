import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.light(
      surface: AppPalette.color100,
      onSurface: AppPalette.color900,
      primary: AppPalette.color900,
    ),
  );
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      surface: AppPalette.color950,
      onSurface: AppPalette.color100,
      primary: AppPalette.color100,
    ),
  );
}
