import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  //Display
  static const TextStyle displayL = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    height: 40 / 34,
    letterSpacing: 0,
  );
  static const TextStyle displayM = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 36 / 28,
    letterSpacing: 0,
  );
  static const TextStyle displayS = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32 / 24,
    letterSpacing: 0,
  );

  //Headline
  static const TextStyle headlineL = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 28 / 22,
    letterSpacing: -0.2,
  );
  static const TextStyle headlineM = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
    letterSpacing: -0.2,
  );
  static const TextStyle headlineS = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 24 / 17,
    letterSpacing: 0,
  );

  //Title
  static const TextStyle titleL = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    height: 24 / 17,
    letterSpacing: 0,
  );
  static const TextStyle titleM = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 20 / 15,
    letterSpacing: 0,
  );

  static const TextStyle titleS = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: 0,
  );

  //Body
  static const TextStyle bodyL = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 24 / 17,
    letterSpacing: 0,
  );
  static const TextStyle bodyM = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 20 / 16,
    letterSpacing: 0,
  );
  static const TextStyle bodyS = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0,
  );

  //Label
  static const TextStyle labelM = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 16 / 13,
    letterSpacing: 0,
  );
  static const TextStyle labelS = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 16 / 11,
    letterSpacing: 0.5,
  );
  static const TextStyle labelXS = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 12 / 10,
    letterSpacing: 0.5,
  );
  //Amount
  static const TextStyle amountXL = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    fontFeatures: [FontFeature.tabularFigures()],
    letterSpacing: 0,
  );
  static const TextStyle amountL = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 24 / 17,
    fontFeatures: [FontFeature.tabularFigures()],
    letterSpacing: 0,
  );
  static const TextStyle amountM = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 20 / 15,
    fontFeatures: [FontFeature.tabularFigures()],
    letterSpacing: 0,
  );
  static const TextStyle amountS = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 16 / 13,
    fontFeatures: [FontFeature.tabularFigures()],
    letterSpacing: 0,
  );
  static const TextStyle amountXS = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 16 / 11,
    fontFeatures: [FontFeature.tabularFigures()],
    letterSpacing: 0,
  );

  static const TextStyle cardTitle = titleL;
  static const TextStyle cardTitleSmall = titleS;
  static const TextStyle cardAmount = amountL;
}
