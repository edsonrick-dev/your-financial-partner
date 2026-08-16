import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
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
    // final colorScheme = context.colors;

    return AdaptivePressable(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          constraints: BoxConstraints(minHeight: 44),
          decoration: BoxDecoration(
            // color: colorScheme.bgLight,
            // border: Border.all(color: colorScheme.appBorder),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
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
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            gapTitle,
                            style: AppTextStyle.titleM,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          gapAmount.toCompactCurrency(kThreshold: 10000000),
                          style: AppTextStyle.amountM,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 32,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('0%', style: AppTextStyle.amountS),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
