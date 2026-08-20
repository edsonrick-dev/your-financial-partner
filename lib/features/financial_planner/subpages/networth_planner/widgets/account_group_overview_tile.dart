import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/core/num_extension.dart';

class AccountGroupOverviewTile extends StatelessWidget {
  final IconData icon;
  final String type;
  final double amount;
  final double percentage;
  final Color color;
  final String percentageLabel;

  const AccountGroupOverviewTile({
    super.key,
    required this.type,
    required this.icon,
    required this.color,
    this.amount = 0,
    required this.percentage,
    required this.percentageLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Row(
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
                Icon(icon, color: color, size: 20),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: AppTextStyle.bodyM),
                Text(
                  '${(percentage * 100).toStringAsFixed(1)}% of $percentageLabel',
                  style: AppTextStyle.labelS.copyWith(
                    color: colorScheme.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),

        const Spacer(),

        Text(amount.toCurrency(), style: AppTextStyle.amountM),

        const SizedBox(width: 12),
      ],
    );
  }
}
