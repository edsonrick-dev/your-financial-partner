import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/core/num_extension.dart';

class AccountOverview extends StatelessWidget {
  final IconData icon;
  final String type;
  final double amount;
  final double percentage;
  final Color color;
  final String percentageLabel;

  const AccountOverview({
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
        const SizedBox(width: 12),
        Row(
          spacing: 4,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: AppTextStyle.bodyS),
                // Text(
                //   '${(percentage * 100).toStringAsFixed(1)}% of $percentageLabel',
                //   style: AppTextStyle.labelS.copyWith(
                //     color: colorScheme.textMuted,
                //   ),
                // ),
              ],
            ),
          ],
        ),

        const Spacer(),

        Text(amount.toCurrency(), style: AppTextStyle.amountS),

        const SizedBox(width: 12),
      ],
    );
  }
}
