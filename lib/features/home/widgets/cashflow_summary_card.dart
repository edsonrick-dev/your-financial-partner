import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_sparkline.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashFlowSummaryCard extends StatelessWidget {
  const CashFlowSummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.trend,
    this.isVertical = false,
  });

  final String title;
  final double amount;
  final Color color;
  final List<double> trend;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    final change = trend.percentChange;
    final colorScheme = context.colors;
    final trendColor = change > 0
        ? colorScheme.appSuccess
        : change < 0
        ? colorScheme.appError
        : colorScheme.appTextMuted;
    return isVertical
        ? Container(
            padding: EdgeInsets.all(12),

            // decoration: BoxDecoration(
            //   // border: BoxBorder.all(color: colorScheme.appBorder),
            //   // borderRadius: BorderRadius.circular(4),
            // ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        height: 16 / 13,
                        fontSize: 13,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        amount.toCompactCurrency(kThreshold: 10000),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          height: 24 / 18,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.appText,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: trendColor.withAlpha(80),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              change > 0
                                  ? PhosphorIconsFill.caretUp
                                  : change < 0
                                  ? PhosphorIconsFill.caretDown
                                  : PhosphorIconsRegular.minus,
                              size: 12,
                              color: trendColor,
                            ),

                            SizedBox(width: 2),
                            Text(
                              '${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 16 / 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      AppSparkline(values: trend, color: color, height: 20),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyle.labelM.copyWith(color: color)),
                SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    amount.toCompactCurrency(kThreshold: 10000),
                    maxLines: 1,
                    style: AppTextStyle.amountM.copyWith(
                      color: colorScheme.appText,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: trendColor.withAlpha(80),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 2),
                      Icon(
                        change > 0
                            ? PhosphorIconsFill.caretUp
                            : change < 0
                            ? PhosphorIconsFill.caretDown
                            : PhosphorIconsRegular.minus,
                        size: 12,
                        color: trendColor,
                      ),

                      SizedBox(width: 2),
                      Text(
                        '${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%',
                        style: AppTextStyle.labelS,
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  child: AppSparkline(values: trend, color: color, height: 16),
                ),
              ],
            ),
          );
  }
}
