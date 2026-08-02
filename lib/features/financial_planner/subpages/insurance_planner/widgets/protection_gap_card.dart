import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class ProtectionGapCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String gapTitle;
  final double gapAmount;
  final VoidCallback? onTap;
  const ProtectionGapCard({
    super.key,
    required this.icon,
    required this.color,
    required this.gapTitle,
    required this.gapAmount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                        ),
                      ),
                      Icon(icon, color: color),
                    ],
                  ),
                  Text(gapTitle, style: AppTextStyle.bodyM),
                ],
              ),
              Spacer(),
              Text(
                gapAmount.toCompactCurrency(kThreshold: 10000000),
                style: AppTextStyle.amountM,
              ),
              SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
