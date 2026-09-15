import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class MetricBarRow extends StatelessWidget {
  final String label;
  final double amount;
  final double ratio;
  final Color color;
  final Color? textColor;

  const MetricBarRow({
    super.key,
    required this.label,
    required this.amount,
    required this.ratio,
    required this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Row(
      children: [
        SizedBox(width: 80, child: Text(label)),

        Expanded(
          child: LinearProgressIndicator(
            value: ratio.clamp(0.0, 1.0),
            minHeight: 8,
            borderRadius: BorderRadius.circular(6),
            backgroundColor: colorScheme.bgDark,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),

        const SizedBox(width: 8),

        SizedBox(
          width: 56,
          child: Text(
            amount.toCompactCurrency(),
            textAlign: TextAlign.right,
            style: AppTextStyle.amountXS.copyWith(
              color: amount < 0
                  ? colorScheme.appOutflow
                  : textColor ?? colorScheme.appText,
            ),
          ),
        ),
      ],
    );
  }
}
