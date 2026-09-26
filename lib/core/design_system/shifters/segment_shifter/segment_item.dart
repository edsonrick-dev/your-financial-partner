import 'package:flutter/material.dart';

class SegmentItem {
  const SegmentItem({this.selectedIcon, this.title, this.unselectedIcon})
    : assert(
        (selectedIcon == null) == (unselectedIcon == null),
        'selectedIcon and unselectedIcon must either both be provided or both be null.',
      );

  final IconData? selectedIcon;
  final IconData? unselectedIcon;
  final String? title;
}
