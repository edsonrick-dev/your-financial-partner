import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class CashflowPlanSummarySection extends StatelessWidget {
  final SavedCashflowPlanData plan;
  final double transactionAmount;
  final double planned;
  final TransactionType transactionType;

  const CashflowPlanSummarySection({
    super.key,
    required this.plan,
    required this.transactionAmount,
    required this.planned,
    required this.transactionType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final remaining = planned - transactionAmount;

    final progress = planned > 0
        ? (transactionAmount / planned).clamp(0.0, 1.0)
        : 0.0;
    final percentage = planned > 0
        ? (transactionAmount / planned * 100).clamp(0, double.infinity)
        : 0.0;
    final excessPlanned = transactionAmount > planned;
    final isIncome = transactionType == TransactionType.earn;
    final statusColor = isIncome
        ? colorScheme.appInflowInverse
        : excessPlanned
        ? colorScheme.appOutflowInversed
        : colorScheme.appInflowInverse;

    return AppSection(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppGradient.gradientA(colorScheme),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.category,
              style: AppTextStyle.titleL.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              _periodLabel(),
              style: AppTextStyle.bodyS.copyWith(
                color: colorScheme.appInversedtext,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: _Metric(label: 'Planned', value: planned.toCurrency()),
                ),
                Expanded(
                  child: _Metric(
                    label: isIncome ? 'Received' : 'Spent',
                    value: transactionAmount.toCurrency(),
                  ),
                ),
                Expanded(
                  child: _Metric(
                    label: isIncome
                        ? excessPlanned
                              ? 'Plan reached'
                              : 'Still to receive'
                        : excessPlanned
                        ? 'Over'
                        : 'Remaining',
                    value: remaining.abs().toCurrency(),
                    valueColor: statusColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: colorScheme.appInversedtext.withAlpha(40),
              valueColor: AlwaysStoppedAnimation(statusColor),
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  isIncome
                      ? '${percentage.toStringAsFixed(0)}% received'
                      : '${percentage.toStringAsFixed(0)}% used',
                  style: AppTextStyle.bodyS.copyWith(
                    color: colorScheme.appInversedtext,
                  ),
                ),
                const Spacer(),
                Text(
                  isIncome
                      ? transactionAmount >= planned
                            ? 'Plan reached'
                            : 'On track'
                      : excessPlanned
                      ? 'Over budget'
                      : 'Within budget',
                  style: AppTextStyle.bodyS.copyWith(color: statusColor),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Text(
            //       '${(transactionAmount / (planned > 0 ? planned : 1) * 100).clamp(0, double.infinity).toStringAsFixed(0)}% used',
            //       style: AppTextStyle.bodyS.copyWith(
            //         color: colorScheme.appInversedtext,
            //       ),
            //     ),
            //     const Spacer(),
            //     Text(
            //       excessPlanned ? 'Over budget' : 'Within budget',
            //       style: AppTextStyle.bodyS.copyWith(color: statusColor),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  String _periodLabel() {
    // Replace these with your actual period-range properties
    // once the plan grouping logic exposes them.
    switch (plan.budgetPeriod) {
      case BudgetPeriod.weekly:
        return 'Weekly ${transactionType == TransactionType.earn ? 'Plan' : 'Budget'}';

      case BudgetPeriod.fortnightly:
        return 'Fortnightly ${transactionType == TransactionType.earn ? 'Plan' : 'Budget'}';

      case BudgetPeriod.monthly:
        return 'Monthly ${transactionType == TransactionType.earn ? 'Plan' : 'Budget'}';

      case BudgetPeriod.yearly:
        return 'Annual ${transactionType == TransactionType.earn ? 'Plan' : 'Budget'}';
    }
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _Metric({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyS.copyWith(
            color: colorScheme.appInversedtext,
          ),
        ),
        const SizedBox(height: 4),
        FittedBox(
          child: Text(
            value,
            style: AppTextStyle.amountM.copyWith(
              color: valueColor ?? colorScheme.appInversedtext,
            ),
          ),
        ),
      ],
    );
  }
}
