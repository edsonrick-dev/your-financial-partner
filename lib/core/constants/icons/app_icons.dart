import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/icons/category_icons/category_icons.dart';

class AppIcons {
  AppIcons._();

  static const fallbackKey = 'fallback';
  static const fallback = Icons.category_outlined;

  static final categories = CategoryIcons();
  // static final system = _SystemIcons();

  static IconData get(String key) {
    return categories.resolve(key);
  }
}

// class _SystemIcons {
//   final List<AppCategoryIcon> availableIcons = [
//     const AppCategoryIcon(key: 'calendar', icon: Icons.calendar_month),
//   ];

//   late final Map<String, IconData> resolver = {
//     for (final item in availableIcons) item.key: item.icon,
//   };
//   IconData resolve(String key) {
//     return resolver[key] ?? AppIcons.fallback;
//   }
// }
