import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppTextStyle {
  AppTextStyle._();

  //Display
  static TextStyle get displayL => TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    height: 40 / 34,
    letterSpacing: 0,
  );
  static TextStyle get displayM => TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    height: 40 / 34,
    letterSpacing: 0,
  );
  static TextStyle get displayS => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32 / 24,
    letterSpacing: 0,
  );

  //Headline
  static TextStyle get headlineL => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 28 / 22,
    letterSpacing: -0.2,
  );
  static TextStyle get headlineS => TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 24 / 17,
    letterSpacing: 0,
  );

  //Title
  static TextStyle get titleL => TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    height: 24 / 17,
    letterSpacing: 0,
  );
  static TextStyle get titleM => TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 20 / 15,
    letterSpacing: 0,
  );
  static TextStyle get titleS => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: 0,
  );

  //Body
  static TextStyle get bodyL => TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 24 / 17,
    letterSpacing: 0,
  );
  static TextStyle get bodyM => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 20 / 16,
    letterSpacing: 0,
  );

  //Label
  static TextStyle get labelM => TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 16 / 13,
    letterSpacing: 0,
  );
  static TextStyle get labelS => TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 16 / 11,
    letterSpacing: 0.5,
  );
  //Amount
  static TextStyle get amountXL => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    fontFeatures: [FontFeature.tabularFigures()],
    letterSpacing: 0,
  );
  static TextStyle get amountL => TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 24 / 17,
    fontFeatures: [FontFeature.tabularFigures()],
    letterSpacing: 0,
  );
  static TextStyle get amountM => TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 20 / 15,
    fontFeatures: [FontFeature.tabularFigures()],
    letterSpacing: 0,
  );
}

class AppGradient {
  AppGradient._();

  static LinearGradient gradientA(ColorScheme colors) => LinearGradient(
    colors: [colors.text, colors.gradient2],
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
  );
}
