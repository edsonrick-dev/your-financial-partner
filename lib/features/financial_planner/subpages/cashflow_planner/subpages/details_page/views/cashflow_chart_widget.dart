import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'dart:math' as math;

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

    // final projectedMax = projectedDistribution.reduce((a, b) => a > b ? a : b);

    // final maxAmount = projectedMax * 1.10;
    // final actualMax = projectedDistribution.reduce((a, b) => a > b ? a : b);

    final actualMax = projectedDistribution.reduce((a, b) => a > b ? a : b);

    final maxAmount = actualMax * 1.05;
    // final maxAmount = niceChartMax(actualMax);
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
          height: 240,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Y-axis
              SizedBox(
                width: 60,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      maxAmount.toCompactCurrency(kThreshold: 10000),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      (maxAmount * 0.75).toCompactCurrency(kThreshold: 10000),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      (maxAmount * 0.50).toCompactCurrency(kThreshold: 10000),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      (maxAmount * 0.25).toCompactCurrency(kThreshold: 10000),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      0.toCurrency(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Chart
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(AppMonth.values.length, (
                          index,
                        ) {
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

                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FractionallySizedBox(
                                        heightFactor: projectedHeightFactor,
                                        widthFactor: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (planned > 0)
                                              Flexible(
                                                flex:
                                                    (plannedHeightFactor * 1000)
                                                        .round(),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: newPlanColor,
                                                    borderRadius:
                                                        const BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            6,
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                              ),

                                            if (current > 0)
                                              Flexible(
                                                flex:
                                                    (currentHeightFactor * 1000)
                                                        .round(),
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

                                  SizedBox(
                                    height: 20,
                                    child: Center(
                                      child: Text(
                                        month.shortName.trim().substring(0, 1),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 240,
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: [
        //       // Y-axis
        //       SizedBox(
        //         width: 58,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.end,
        //           children: [
        //             Text(
        //               maxAmount.toCompactCurrency(),
        //               style: Theme.of(context).textTheme.labelSmall,
        //             ),
        //             Text(
        //               (maxAmount * 0.75).toCompactCurrency(),
        //               style: Theme.of(context).textTheme.labelSmall,
        //             ),
        //             Text(
        //               (maxAmount * 0.50).toCompactCurrency(),
        //               style: Theme.of(context).textTheme.labelSmall,
        //             ),
        //             Text(
        //               (maxAmount * 0.25).toCompactCurrency(),
        //               style: Theme.of(context).textTheme.labelSmall,
        //             ),
        //             Text(
        //               0.toCurrency(),
        //               style: Theme.of(context).textTheme.labelSmall,
        //             ),
        //           ],
        //         ),
        //       ),

        //       const SizedBox(width: 8),

        //       // Chart
        //       Expanded(
        //         child: Column(
        //           children: [
        //             Expanded(
        //               child: Row(
        //                 crossAxisAlignment: CrossAxisAlignment.end,
        //                 children: List.generate(AppMonth.values.length, (
        //                   index,
        //                 ) {
        //                   final month = AppMonth.values[index];

        //                   final current = currentDistribution[index];
        //                   final planned = plannedDistribution[index];
        //                   final projected = projectedDistribution[index];

        //                   final projectedHeightFactor = maxAmount <= 0
        //                       ? 0.0
        //                       : projected / maxAmount;

        //                   final currentHeightFactor = projected <= 0
        //                       ? 0.0
        //                       : current / projected;

        //                   final plannedHeightFactor = projected <= 0
        //                       ? 0.0
        //                       : planned / projected;

        //                   return Expanded(
        //                     child: Padding(
        //                       padding: const EdgeInsets.symmetric(
        //                         horizontal: 3,
        //                       ),
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Expanded(
        //                             child: Align(
        //                               alignment: Alignment.bottomCenter,
        //                               child: FractionallySizedBox(
        //                                 heightFactor: projectedHeightFactor,
        //                                 widthFactor: 1,
        //                                 child: Column(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.end,
        //                                   children: [
        //                                     // New plan
        //                                     if (planned > 0)
        //                                       Flexible(
        //                                         flex:
        //                                             (plannedHeightFactor * 1000)
        //                                                 .round(),
        //                                         child: Container(
        //                                           width: double.infinity,
        //                                           decoration: BoxDecoration(
        //                                             color: newPlanColor,
        //                                             borderRadius:
        //                                                 const BorderRadius.vertical(
        //                                                   top: Radius.circular(
        //                                                     6,
        //                                                   ),
        //                                                 ),
        //                                           ),
        //                                         ),
        //                                       ),

        //                                     // Existing
        //                                     if (current > 0)
        //                                       Flexible(
        //                                         flex:
        //                                             (currentHeightFactor * 1000)
        //                                                 .round(),
        //                                         child: Container(
        //                                           width: double.infinity,
        //                                           decoration: BoxDecoration(
        //                                             border: Border.all(
        //                                               color: currentColor,
        //                                               width: 2,
        //                                             ),
        //                                           ),
        //                                         ),
        //                                       ),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                           ),

        //                           const SizedBox(height: 8),

        //                           SizedBox(
        //                             height: 20,
        //                             child: Center(
        //                               child: Text(
        //                                 month.shortName,
        //                                 style: Theme.of(
        //                                   context,
        //                                 ).textTheme.labelSmall,
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   );
        //                 }),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        //   SizedBox(
        //     height: 220,
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: List.generate(AppMonth.values.length, (index) {
        //         final month = AppMonth.values[index];

        //         final current = currentDistribution[index];
        //         final planned = plannedDistribution[index];
        //         final projected = projectedDistribution[index];
        //         final projectedHeightFactor = maxAmount <= 0
        //             ? 0.0
        //             : projected / maxAmount;

        //         final currentHeightFactor = projected <= 0
        //             ? 0.0
        //             : current / projected;

        //         final plannedHeightFactor = projected <= 0
        //             ? 0.0
        //             : planned / projected;
        //         // final currentHeightFactor = projected <= 0
        //         //     ? 0.0
        //         //     : current / projected;

        //         return Expanded(
        //           child: Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 3),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               children: [
        //                 Expanded(
        //                   child: Align(
        //                     alignment: Alignment.bottomCenter,
        //                     child: FractionallySizedBox(
        //                       heightFactor: projectedHeightFactor,
        //                       widthFactor: 1,
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           // New plan
        //                           if (planned > 0)
        //                             Flexible(
        //                               flex: (plannedHeightFactor * 1000).round(),
        //                               child: Container(
        //                                 width: double.infinity,
        //                                 decoration: BoxDecoration(
        //                                   color: newPlanColor,
        //                                   borderRadius:
        //                                       const BorderRadius.vertical(
        //                                         top: Radius.circular(6),
        //                                       ),
        //                                 ),
        //                               ),
        //                             ),

        //                           // Existing
        //                           if (current > 0)
        //                             Flexible(
        //                               flex: (currentHeightFactor * 1000).round(),
        //                               child: Container(
        //                                 width: double.infinity,
        //                                 decoration: BoxDecoration(
        //                                   border: Border.all(
        //                                     color: currentColor,
        //                                     width: 2,
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 const SizedBox(height: 8),

        //                 Text(
        //                   month.shortName,
        //                   style: Theme.of(context).textTheme.labelSmall,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         );
        //       }),
        //     ),
        //   ),
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
