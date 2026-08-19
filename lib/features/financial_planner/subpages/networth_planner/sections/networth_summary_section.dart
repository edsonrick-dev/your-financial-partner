import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NetWorthSummaryContainerSection extends StatelessWidget {
  final double netWorth;
  const NetWorthSummaryContainerSection({super.key, required this.netWorth});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    double change = 0.028;
    bool isGrowth = change > 0 ? true : false;
    String comparison = 'last month';
    return AppSection(
      child: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.text, colorScheme.gradient2],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              'Net Worth',
              style: AppTextStyle.titleL.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  netWorth.abs().toCurrency(),
                  style: AppTextStyle.amountXL.copyWith(
                    color: netWorth < 0
                        ? colorScheme.appOutflow
                        : colorScheme.inversePrimary,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      isGrowth
                          ? PhosphorIconsFill.caretUp
                          : PhosphorIconsFill.caretDown,
                      color: isGrowth
                          ? colorScheme.appInflow
                          : colorScheme.appOutflow,
                      size: 16,
                    ),
                    RichText(
                      text: TextSpan(
                        text: '${(change * 100).toStringAsFixed(1)}%',
                        style: AppTextStyle.amountM.copyWith(
                          color: isGrowth
                              ? colorScheme.appInflow
                              : colorScheme.appOutflow,
                        ),
                        children: [
                          TextSpan(
                            text: ' vs ',
                            style: AppTextStyle.titleM.copyWith(
                              color: colorScheme.textInversed,
                            ),
                          ),
                          TextSpan(
                            text: comparison,
                            style: AppTextStyle.titleM.copyWith(
                              color: colorScheme.textInversed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
