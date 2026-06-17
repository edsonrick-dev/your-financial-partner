import 'package:flutter/material.dart';

class AppGrabber extends StatelessWidget {
  const AppGrabber({super.key, this.isDark = false});

  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 4),
      child: Container(
        height: 4,
        width: 36,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: isDark ? Colors.white : Colors.black54),
      ),
    );
  }
}
