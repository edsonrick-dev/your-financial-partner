import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/constants/icons/icon_groups/icon_groups.dart';

class AppCategoryIcon {
  final String key;
  final IconData icon;
  final IconGroup group;

  const AppCategoryIcon({
    required this.key,
    required this.icon,
    this.group = IconGroup.general,
  });
}
