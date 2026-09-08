import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

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
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
          ),
          SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(type, style: AppTextStyle.bodyM)),
                    Text(amount.toCurrency(), style: AppTextStyle.amountM),
                  ],
                ),
                // SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
          ),
        ],
      ),

      // const Spacer(),

      //

      // const SizedBox(width: 12),
    );
  }
}
