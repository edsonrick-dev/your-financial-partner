import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
}

extension AppColorScheme on ColorScheme {
  bool get isDark => brightness == Brightness.dark;
  Color get ascendPrimary => color900;

  ///PAGE SHIFTERS
  Color get pageShifterTextSelected =>
      isDark ? pageShifterFillUnselected : color100;
  Color get pageShifterFillSelected => isDark ? appAccent : appText;
  Color get pageShifterTextUnselected => text;
  Color get pageShifterFillUnselected => isDark ? color800 : bgLight;

  Color get buttonBackground => isDark ? appAccent : color900;
  Color get buttonForeground => isDark ? text : color900;

  Color get grabber => isDark ? color700 : color900;
  Color get grabberInversed => color900;

  Color get bg => isDark ? color900 : color100;
  Color get bgLight => isDark ? color800 : color50;
  Color get bgDark => isDark ? color950 : color200;
  Color get surface => bg;

  Color get bgInversed => isDark ? color900 : color900;
  Color get appOnSurface => const Color(0xFFFFFFFF);
  Color get appOnSurfaceSecondary => appText;
  Color get appOnSurfaceTertiary => appText.withAlpha(220);

  /// TEXT

  Color get appText => isDark ? color100 : color900;
  Color get appTextMuted => color500;
  Color get appInversedtext => color50;
  Color get appInversedtextMuted => color300;

  /// SEMANTICS
  Color get appSuccess => Colors.green;
  Color get appError => Color(0xFFFF383C);
  Color get appErrorSoft => Color(0xFFF9D3D6);

  Color get appWarning => const Color(0xFFF59E0B);
  Color get appInfo => const Color(0xFF3B82F6);
  Color get appInfoSoft => appInfo.withAlpha(60);

  /// BORDERS
  Color get appBorder => appText.withAlpha(70);
  Color get appBorderMuted => appBorder.withAlpha(70);

  Color get text => isDark ? color100 : color900;
  Color get textMuted => isDark ? color300 : color700;
  Color get textInversed => bg;
  Color get textInversedMuted => bgLight;
  Color get gradient1 => color900;
  Color get gradient2 => const Color(0xFF46628F);
}

extension FinanceColors on ColorScheme {
  /// FLOW
  Color get appInflow => const Color(0xFF16A34A);
  Color get appInflowInverse => const Color(0xFF4ADE80);
  Color get appOutflow => const Color(0xFFDC2626);
  Color get appOutflowInversed => const Color(0xFFFF6B6B);
  Color get appAccent => const Color(0xFFE6A23F);
  Color get appNeutral => const Color(0xFF94A3B8);
  Color get appNeutralSoft => const Color(0xFFE2E8F0);

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

extension DesignSystemColors on ColorScheme {
  Color get color50 => const Color(0xFFF8FAFC);
  Color get color100 => const Color(0xFFF1F5F9);
  Color get color200 => const Color(0xFFE2E8F0);
  Color get color300 => const Color(0xFFC8D5E1);
  Color get color400 => const Color(0xFF94A3B8);
  Color get color500 => const Color(0xFF64748B);
  Color get color600 => const Color(0xFF475569);
  Color get color700 => const Color(0xFF334155);
  Color get color800 => const Color(0xFF1E293B);
  Color get color900 => const Color(0xFF141C29);
  Color get color950 => const Color(0xFF0A0E17);
}

class AppPalette {
  AppPalette._();

  static const color50 = Color(0xFFF8FAFC);
  static const color100 = Color(0xFFF1F5F9);
  static const color200 = Color(0xFFE2E8F0);
  static const color300 = Color(0xFFC8D5E1);
  static const color400 = Color(0xFF94A3B8);
  static const color500 = Color(0xFF64748B);
  static const color600 = Color(0xFF475569);
  static const color700 = Color(0xFF334155);
  static const color800 = Color(0xFF1E293B);
  static const color900 = Color(0xFF141C29);
  static const color950 = Color(0xFF0A0E17);

  // static const accent = Color(0xFFF5A623);
  static const success = Color(0xFF16A34A);
  static const error = Color(0xFFDC2626);
  static const warning = Color(0xFFF59E0B);
  static const info = Color(0xFF3B82F6);
}
