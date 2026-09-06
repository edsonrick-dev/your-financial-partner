import 'package:flutter/material.dart';

class ModeItem {
  const ModeItem({
    required this.selectedIcon,
    required this.unselectedIcon,
    this.title,
  });

  final IconData selectedIcon;
  final IconData unselectedIcon;
  final String? title;
}
