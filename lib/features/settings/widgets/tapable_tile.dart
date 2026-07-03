import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TappableTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String? choice;
  final String? subtitle;

  const TappableTile({
    super.key,
    this.onTap,
    required this.title,
    this.choice,
    this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        constraints: BoxConstraints(minHeight: 48),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(color: colorScheme.appTextMuted),
                  ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Text(
                  choice ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: colorScheme.appTextMuted,
                  ),
                ),
                SizedBox(width: 4),
                Icon(PhosphorIconsRegular.caretRight, size: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
