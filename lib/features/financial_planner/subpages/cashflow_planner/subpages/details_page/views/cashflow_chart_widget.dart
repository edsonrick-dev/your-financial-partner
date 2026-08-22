import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';

class CashflowPlanMonthlyDistribution extends StatelessWidget {
  const CashflowPlanMonthlyDistribution({
    super.key,
    required this.transactionType,
    required this.currentDistribution,
    required this.plannedDistribution,
  });

  final List<double> currentDistribution;
  final List<double> plannedDistribution;
  final TransactionType transactionType;
  @override
  Widget build(BuildContext context) {
    assert(
      currentDistribution.length == AppMonth.values.length,
      'currentDistribution must contain 12 values.',
    );

    assert(
      plannedDistribution.length == AppMonth.values.length,
      'plannedDistribution must contain 12 values.',
    );

    final projectedDistribution = List.generate(
      AppMonth.values.length,
      (index) => currentDistribution[index] + plannedDistribution[index],
    );

    final maxAmount = projectedDistribution.reduce((a, b) => a > b ? a : b);

    final colorScheme = context.colors;
    final currentColor = transactionType == TransactionType.earn
        ? colorScheme.appInflow
        : colorScheme.appOutflow;
    final newPlanColor = transactionType == TransactionType.earn
        ? colorScheme.appInflow
        : colorScheme.appOutflow;

    final currentLabel = transactionType == TransactionType.earn
        ? 'Existing Sources'
        : 'Existing Budget';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Monthly Impact', style: Theme.of(context).textTheme.titleMedium),

        const SizedBox(height: 8),

        Row(
          children: [
            _LegendItem(color: currentColor, label: currentLabel),
            const SizedBox(width: 16),
            _LegendItem(
              color: newPlanColor,
              label: 'New plan',
              isCurrent: false,
            ),
          ],
        ),

        const SizedBox(height: 20),

        SizedBox(
          height: 220,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(AppMonth.values.length, (index) {
              final month = AppMonth.values[index];

              final current = currentDistribution[index];
              final planned = plannedDistribution[index];
              final projected = projectedDistribution[index];
              final projectedHeightFactor = maxAmount <= 0
                  ? 0.0
                  : projected / maxAmount;

              final currentHeightFactor = projected <= 0
                  ? 0.0
                  : current / projected;

              final plannedHeightFactor = projected <= 0
                  ? 0.0
                  : planned / projected;
              // final currentHeightFactor = projected <= 0
              //     ? 0.0
              //     : current / projected;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            heightFactor: projectedHeightFactor,
                            widthFactor: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // New plan
                                if (planned > 0)
                                  Flexible(
                                    flex: (plannedHeightFactor * 1000).round(),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: newPlanColor,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(6),
                                            ),
                                      ),
                                    ),
                                  ),

                                // Existing
                                if (current > 0)
                                  Flexible(
                                    flex: (currentHeightFactor * 1000).round(),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: currentColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        month.shortName,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    this.isCurrent = true,
  });

  final Color color;
  final String label;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: isCurrent
              ? BoxDecoration(
                  border: Border.all(color: color, width: 2),
                  shape: BoxShape.circle,
                )
              : BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
