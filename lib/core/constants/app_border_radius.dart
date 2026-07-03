import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/app_scale.dart';

class AppBorderRadius {
  AppBorderRadius._();

  static BorderRadius sheetTop = BorderRadius.vertical(
    top: Radius.circular(38),
  );
  static BorderRadius sheet = BorderRadius.all(Radius.circular(38));

  static double m = AppScale.x2;
}

class AppSpacing {
  AppSpacing._();

  static double listSpacing = AppScale.x2;
  static double cardSpacing = AppScale.x3;
}

class AppPadding {
  AppPadding._();

  static double pageHorizontal = AppScale.x4;
}
