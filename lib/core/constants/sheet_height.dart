import 'package:flutter/material.dart';

class AppSheetHeight {
  AppSheetHeight._();
  static const double full = 0.93;
  static const double threeQuarter = 0.75;
  static const double half = 0.5;
  static const double quarter = 0.25;
}

abstract final class AppShadows {
  static List<BoxShadow> card(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.06),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }

  static List<BoxShadow> pill(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.06),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }

  static List<BoxShadow> elevated(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.10),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
    ];
  }

  static List<BoxShadow> floating(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.12),
        blurRadius: 24,
        offset: const Offset(0, 8),
      ),
    ];
  }
}
