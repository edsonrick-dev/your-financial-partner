import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/net_worth_comparison_enum.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NetWorthSummaryContainerSection extends StatelessWidget {
  final double netWorth;
  final double baselineNetWorth;
  final NetWorthComparison comparisonType;
  final ValueChanged<NetWorthComparison> onComparisonChanged;

  const NetWorthSummaryContainerSection({
    super.key,
    required this.netWorth,
    required this.baselineNetWorth,
    required this.comparisonType,
    required this.onComparisonChanged,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final change = baselineNetWorth == 0
        ? 0
        : (netWorth - baselineNetWorth) / baselineNetWorth.abs();
    final isGrowth = change > 0;

    return AppSection(
      child: Container(
        padding: const EdgeInsets.all(24),
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
            Row(
              children: [
                Text(
                  'Net Worth',
                  style: AppTextStyle.titleL.copyWith(
                    color: colorScheme.appInversedtextMuted,
                  ),
                ),

                const Spacer(),

                _ComparisonSelector(
                  value: comparisonType,
                  onChanged: onComparisonChanged,
                ),
              ],
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

                if (baselineNetWorth != 0)
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
                          text: '${(change.abs() * 100).toStringAsFixed(1)}%',
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
                              text: comparisonType.comparisonLabel,
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

class _ComparisonSelector extends StatelessWidget {
  final NetWorthComparison value;
  final ValueChanged<NetWorthComparison> onChanged;

  const _ComparisonSelector({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return PopupMenuButton<NetWorthComparison>(
      initialValue: value,
      onSelected: onChanged,
      offset: const Offset(0, 8),
      itemBuilder: (context) {
        return NetWorthComparison.values.map((option) {
          return PopupMenuItem<NetWorthComparison>(
            value: option,
            child: Text(option.selectorLabel),
          );
        }).toList();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value.selectorLabel,
            style: AppTextStyle.titleS.copyWith(
              color: colorScheme.textInversed,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            PhosphorIconsRegular.caretDown,
            size: 14,
            color: colorScheme.textInversed,
          ),
        ],
      ),
    );
  }
}
