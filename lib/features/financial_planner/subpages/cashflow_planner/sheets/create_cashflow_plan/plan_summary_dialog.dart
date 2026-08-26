import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/charts/cashflow_chart_widget.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';

class PlanSummaryDialog extends GetView<CashflowController> {
  const PlanSummaryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final transactionController = Get.find<TransactionController>();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 800),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.bg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Plan Summary', style: AppTextStyle.headlineS),
              const SizedBox(height: 20),

              // Plan details
              _SummaryRow(
                label: 'Income Source',
                value:
                    transactionController.selectedCategory.value?.name ?? '—',
              ),

              const SizedBox(height: 12),

              _SummaryRow(
                label: 'Period',
                value: controller.selectedPeriod.value?.label ?? '—',
              ),

              // const SizedBox(height: 12),

              // _SummaryRow(
              //   label: 'Distribution',
              //   value: controller.selectedDistribution.value.name,
              // ),
              const SizedBox(height: 24),

              // Monthly distribution
              // Text('Monthly Distribution', style: AppTextStyle.titleL),
              // const SizedBox(height: 12),
              FutureBuilder<List<double>>(
                future: controller.calculateRecurringMonthlyDistribution(
                  transactionType: TransactionType.earn,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 220,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return const SizedBox.shrink();
                  }

                  return Obx(
                    () => CashflowPlanMonthlyDistribution(
                      transactionType: TransactionType.earn,
                      currentDistribution:
                          snapshot.data ?? List<double>.filled(12, 0),
                      plannedDistribution:
                          controller.monthlyPlannedDistribution,
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Value creation
              _PlanValueCreation(transactionType: TransactionType.earn),

              const SizedBox(height: 24),

              // AppButton(
              //   text: 'Save Income Plan',
              //   onTap: () {
              //     Get.back();
              //     Get.back();

              //     // Your save logic here.
              //     controller.saveIncomePlan;
              //   },
              // ),

              // const SizedBox(height: 8),
              AppButton(
                type: ButtonType.ghost,
                text: 'Back to Plan',
                onTap: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyle.bodyM),
        Text(value, style: AppTextStyle.titleM),
      ],
    );
  }
}

class _PlanValueCreation extends GetView<CashflowController> {
  final TransactionType transactionType;

  const _PlanValueCreation({required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final isIncome = transactionType == TransactionType.earn;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Value Created', style: AppTextStyle.headlineS),

        const SizedBox(height: 12),

        Text(isIncome ? 'Expected Annual Income' : 'Annual Planned Spending'),

        Text(
          controller.annualizedAmount.toCurrency(),
          style: AppTextStyle.amountL,
        ),

        const SizedBox(height: 8),

        Text(
          isIncome
              ? 'This plan adds to your expected annual income and gives you a clearer amount to allocate toward your financial goals.'
              : 'This plan gives you a defined spending limit, helping make your monthly budget more predictable.',
        ),
      ],
    );
  }
}
