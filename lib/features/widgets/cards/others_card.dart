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
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        constraints: BoxConstraints(minHeight: 60),
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(width: 8),
            Icon(PhosphorIconsRegular.caretRight, size: 16),
          ],
        ),
      ),
    );
  }
}
