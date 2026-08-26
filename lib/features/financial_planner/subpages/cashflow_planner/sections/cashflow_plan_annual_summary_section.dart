import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';

class CashflowPlanAnnualSummarySection extends GetView<CashflowController> {
  final TransactionType transactionType;
  const CashflowPlanAnnualSummarySection({
    super.key,
    required this.transactionType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      final period = controller.selectedPeriod.value;

      if (period == null) {
        return const SizedBox.shrink();
      }

      final isCustom =
          controller.selectedDistribution.value == CashFlowDistribution.custom;

      final periodTotal = isCustom
          ? controller.distributionTotal
          : controller.plannedPeriodAmount;

      final periodLabel = period == BudgetPeriod.fortnightly && isCustom
          ? '4-week pattern'
          : period.label;

      final multiplier = isCustom
          ? period.customPatternsPerYear
          : period.occurrencesPerYear;

      final annualizationLabel = period == BudgetPeriod.fortnightly && isCustom
          ? '4-week patterns'
          : period.annualizationLabel;

      final sumarryLabel = transactionType == TransactionType.earn
          ? 'Income'
          : 'Budget';

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: colorScheme.appInfoSoft,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.appText),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Plan Summary', style: AppTextStyle.headlineS),
            // SizedBox(height: 8),
            // Period / pattern total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$periodLabel total'),
                Text(
                  periodTotal.toCurrency(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),

            // Annual multiplier
            if (period != BudgetPeriod.yearly) ...[
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('× No. of $annualizationLabel'),
                  Text('$multiplier'),
                ],
              ),
            ],

            const SizedBox(height: 12),

            Divider(height: 1, color: Theme.of(context).dividerColor),

            const SizedBox(height: 12),

            // Annual result
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Expected Annual $sumarryLabel',
                  style: AppTextStyle.titleM,
                ),
                Text(
                  controller.annualizedAmount.toCurrency(),
                  style: AppTextStyle.amountL,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
