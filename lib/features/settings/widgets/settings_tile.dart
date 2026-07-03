import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        width: double.infinity,
        child: Row(
          spacing: 12,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon, color: color),
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(height: 20 / 15, fontSize: 15)),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: colorScheme.appTextMuted,
                    height: 16 / 12,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(PhosphorIconsRegular.caretRight, size: 20),
          ],
        ),
      ),
    );
  }
}
