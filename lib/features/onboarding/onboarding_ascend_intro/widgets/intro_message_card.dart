import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class IntroMessageCard extends StatelessWidget {
  const IntroMessageCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.bgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.appBorder),
      ),
      child: child,
    );
  }
}
