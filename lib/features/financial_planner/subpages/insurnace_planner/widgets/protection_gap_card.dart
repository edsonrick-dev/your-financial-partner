import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class ProtectionGapCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String gapTitle;
  final double gapAmount;
  const ProtectionGapCard({
    super.key,
    required this.icon,
    required this.color,
    required this.gapTitle,
    required this.gapAmount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      padding: EdgeInsets.all(12),
      constraints: BoxConstraints(minHeight: 44),
      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        border: Border.all(color: colorScheme.appBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Row(
            spacing: 12,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                    ),
                  ),
                  Icon(icon, color: color),
                ],
              ),
              Text(gapTitle, style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          Spacer(),
          Text(
            gapAmount.toCompactCurrency(kThreshold: 100000000),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              height: 20 / 15,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}
