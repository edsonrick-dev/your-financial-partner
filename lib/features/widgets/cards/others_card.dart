import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OthersCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  const OthersCard({
    super.key,
    this.icon = PhosphorIconsRegular.flipHorizontal,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AdaptivePressable(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          constraints: BoxConstraints(minHeight: 44),
          decoration: BoxDecoration(
            color: colorScheme.bgLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 12),
              Text(title),
              Spacer(),
              Icon(PhosphorIconsRegular.caretRight, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
