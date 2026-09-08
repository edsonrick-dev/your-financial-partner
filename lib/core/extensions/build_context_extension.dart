import 'package:flutter/widgets.dart';

extension BuildContextExtension on BuildContext {
  double get bottomPadding => MediaQuery.of(this).padding.bottom + 60;
  double get bottomPaddingSub => MediaQuery.of(this).padding.bottom;

  double get topPadding => MediaQuery.of(this).padding.top + 12;
}
