import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppSectionBody extends StatelessWidget {
  const AppSectionBody({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.all(8),
      child: child,
    );
  }
}
