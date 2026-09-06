import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppGradient {
  AppGradient._();

  static LinearGradient gradientA(ColorScheme colors) => LinearGradient(
    colors: [colors.gradient1, colors.gradient2],
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient gradientB(ColorScheme colors) => LinearGradient(
    colors: [colors.gradient1, colors.gradient2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
