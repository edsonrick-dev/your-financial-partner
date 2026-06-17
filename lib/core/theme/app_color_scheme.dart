import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
}

extension AppColorScheme on ColorScheme {
  bool get isDark => brightness == Brightness.dark;

  /// BACKGROUND
  Color get appOnSurface => const Color(0xFFFFFFFF);
  Color get appOnSurfaceSecondary => appText;
  Color get appOnSurfaceTertiary => appText.withAlpha(220);

  /// TEXT
  Color get appText => const Color(0xFF141C29);
  Color get appTextMuted => const Color(0xFf475569);
  Color get appInversedtext => surface;
  Color get appInversedtextMuted => Colors.black;

  /// SEMANTICS
  Color get appSuccess => Colors.green;
  Color get appError => Colors.red;
  Color get appWarning => Colors.green;
  Color get appInfo => const Color(0xFF3B82F6);
  Color get appInfoSoft => appInfo.withAlpha(60);

  /// BORDERS
  Color get appBorder => appText.withAlpha(70);
  Color get appBorderMuted => appBorder.withAlpha(70);
}

extension FinanceColors on ColorScheme {
  /// FLOW
  Color get appInflow => const Color(0xFF16A34A);
  Color get appOutflow => const Color(0xFFDC2626);
  Color get appAccent => const Color(0xFFF59E0B);
  Color get appNeutral => const Color(0xFF94A3B8);

  /// 8-STEP COLOR
  Color get appCritical => Colors.green;
  Color get appVeryPoor => Colors.green;
  Color get appPoor => Colors.green;
  Color get appFair => Colors.green;
  Color get appGood => Colors.green;
  Color get appVeryGood => Colors.green;
  Color get appExcellent => Colors.green;
  Color get appExceptional => Colors.green;
}
