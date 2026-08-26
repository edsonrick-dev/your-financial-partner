import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';

class CashflowPlanSummarySection extends StatelessWidget {
  final SavedCashflowPlanData plan;
  final double spent;
  final double planned;

  const CashflowPlanSummarySection({
    super.key,
    required this.plan,
    required this.spent,
    required this.planned,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final remaining = planned - spent;

    final progress = planned > 0 ? (spent / planned).clamp(0.0, 1.0) : 0.0;

    final isOverBudget = spent > planned;

    final statusColor = isOverBudget
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
                color: colorScheme.textInversedMuted,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _Metric(label: 'Planned', value: planned.toCurrency()),
                ),
                Expanded(
                  child: _Metric(label: 'Spent', value: spent.toCurrency()),
                ),
                Expanded(
                  child: _Metric(
                    label: isOverBudget ? 'Over' : 'Remaining',
                    value: remaining.abs().toCurrency(),
                    valueColor: statusColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: colorScheme.textInversed.withAlpha(40),
              valueColor: AlwaysStoppedAnimation(statusColor),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Text(
                  '${(spent / (planned > 0 ? planned : 1) * 100).clamp(0, double.infinity).toStringAsFixed(0)}% used',
                  style: AppTextStyle.bodyS.copyWith(
                    color: colorScheme.textInversedMuted,
                  ),
                ),
                const Spacer(),
                Text(
                  isOverBudget ? 'Over budget' : 'Within budget',
                  style: AppTextStyle.bodyS.copyWith(color: statusColor),
                ),
              ],
            ),
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
        return 'Weekly budget';

      case BudgetPeriod.fortnightly:
        return 'Fortnightly budget';

      case BudgetPeriod.monthly:
        return 'Monthly budget';

      case BudgetPeriod.yearly:
        return 'Annual budget';
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
            color: colorScheme.textInversedMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyle.amountM.copyWith(
            color: valueColor ?? colorScheme.textInversed,
          ),
        ),
      ],
    );
  }
}
