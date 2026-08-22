import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/cashflow_chart_widget.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/cashflow_details_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/cashflow_plan_annual_summary.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class CreateIncomePlanSheet extends GetView<CashflowController> {
  const CreateIncomePlanSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();
    final transactionType = TransactionType.earn;
    double spacingHeight = 20;
    return AppSheet(
      adaptiveHeight: false,
      height: AppSheetHeight.full,
      title: 'Create Income Plan',
      child: SingleChildScrollView(
        child: AppSection(
          child: Column(
            children: [
              // Category
              Obx(
                () => AppDropdownField(
                  label: 'Income Source',
                  iconKey:
                      transactionController.selectedCategory.value?.icon ??
                      'category',
                  value: transactionController.selectedCategory.value?.name,
                  hint: 'Select income source',
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    transactionController.selectCategory(transactionType);
                  },
                ),
              ),
              SizedBox(height: spacingHeight),

              // Period
              Obx(
                () => AppDropdownField(
                  iconKey: 'caretDown',
                  label: 'Period',
                  value: controller.selectedPeriod.value?.label,
                  hint: 'Select period',
                  onTap: () async {
                    final selected = await Get.bottomSheet<BudgetPeriod>(
                      const BudgetPeriodSelectionSheet(),
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                    );

                    if (selected != null) {
                      controller.selectPeriod(selected);
                    }
                  },
                ),
              ),

              SizedBox(height: spacingHeight),
              // Distribution mode
              Obx(() {
                final period = controller.selectedPeriod.value;

                if (period == null || !period.supportsCustomization) {
                  return const SizedBox.shrink();
                }

                return Column(
                  children: [
                    SegmentedButton<CashFlowDistribution>(
                      segments: const [
                        ButtonSegment(
                          value: CashFlowDistribution.defaultDistribution,
                          label: Text('Evenly'),
                        ),
                        ButtonSegment(
                          value: CashFlowDistribution.custom,
                          label: Text('Custom'),
                        ),
                      ],
                      selected: {controller.selectedDistribution.value},
                      onSelectionChanged: (selection) {
                        controller.selectDistribution(selection.first);
                      },
                    ),
                    SizedBox(height: spacingHeight),
                  ],
                );
              }),

              // Amount — only in Evenly mode
              // Amount / period total
              Obx(() {
                final isCustom =
                    controller.selectedDistribution.value ==
                    CashFlowDistribution.custom;

                if (isCustom) {
                  return const SizedBox.shrink();
                }
                return AppAmountField(
                  label: 'Amount',
                  amount: controller.amount.value,
                  onChanged: (amount) {
                    controller.amount.value = amount;
                  },
                );
                // return AppTextField(
                //   label: 'Amount',
                // onChanged: (_) => controller.amountChanged(),
                //   prefixText: '₱',
                //   keyboardType: const TextInputType.numberWithOptions(
                //     decimal: true,
                //   ),
                // focusNode: controller.amountFocusNode,
                //   controller: controller.amountController,
                // );
              }),

              // Custom allocations
              Obx(() {
                final period = controller.selectedPeriod.value;

                if (period == null ||
                    !period.supportsCustomization ||
                    controller.selectedDistribution.value !=
                        CashFlowDistribution.custom) {
                  return const SizedBox.shrink();
                }

                return Column(
                  spacing: 12,
                  children: [const CashFlowDistributionFields()],
                );
              }),

              SizedBox(height: spacingHeight),
              // Annual projection
              CashflowPlanAnnualSummary(transactionType: transactionType),
              const SizedBox(height: 20),

              // Monthly distribution
              FutureBuilder<List<double>>(
                future: controller.calculateCurrentMonthlyDistribution(
                  transactionType: transactionType,
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
                      transactionType: transactionType,
                      currentDistribution:
                          snapshot.data ?? List<double>.filled(12, 0),
                      plannedDistribution:
                          controller.monthlyPlannedDistribution,
                    ),
                  );
                },
              ),

              CashflowPlanValueCreation(transactionType: transactionType),
              // // Annual projection
              // Obx(() {
              //   final period = controller.selectedPeriod.value;

              //   if (period == null) {
              //     return const SizedBox.shrink();
              //   }
              //   final periodLabel =
              //       (controller.selectedPeriod.value ==
              //               BudgetPeriod.fortnightly &&
              //           controller.selectedDistribution.value ==
              //               CashFlowDistribution.custom)
              //       ? '4-week period'
              //       : period.label;
              //   return Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('$periodLabel total'),
              //       Text(
              //         controller.selectedDistribution.value ==
              //                 CashFlowDistribution.custom
              //             ? controller.distributionTotal.toCurrency()
              //             : controller.plannedPeriodAmount.toCurrency(),
              //         style: Theme.of(context).textTheme.titleMedium,
              //       ),
              //     ],
              //   );
              // }),
              // Obx(() {
              //   final period = controller.selectedPeriod.value;

              //   if (period == null) {
              //     return const SizedBox.shrink();
              //   }

              //   final isCustom =
              //       controller.selectedDistribution.value ==
              //       CashFlowDistribution.custom;

              //   final multiplier = isCustom
              //       ? period.customPatternsPerYear
              //       : period.occurrencesPerYear;
              //   final annualizationLabel =
              //       (controller.selectedPeriod.value ==
              //               BudgetPeriod.fortnightly &&
              //           controller.selectedDistribution.value ==
              //               CashFlowDistribution.custom)
              //       ? '4-week periods'
              //       : period.annualizationLabel;
              //   return controller.selectedPeriod.value != BudgetPeriod.yearly
              //       ? Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text('× No. of $annualizationLabel'),
              //             Text('$multiplier'),
              //           ],
              //         )
              //       : SizedBox.shrink();
              // }),

              // controller.selectedPeriod.value == null
              //     ? SizedBox.shrink()
              //     : Divider(),

              // Obx(() {
              //   final period = controller.selectedPeriod.value;

              //   if (period == null) {
              //     return const SizedBox.shrink();
              //   }

              //   return Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Text('Expected Annual Income'),
              //       Text(
              //         controller.annualizedAmount.toCurrency(),
              //         style: Theme.of(context).textTheme.titleMedium,
              //       ),
              //     ],
              //   );
              // }),
              SizedBox(height: spacingHeight * 4),
            ],
          ),
        ),
      ),
    );
  }
}

class CashflowPlanValueCreation extends GetView<CashflowController> {
  final TransactionType transactionType;

  const CashflowPlanValueCreation({super.key, required this.transactionType});

  @override
  Widget build(BuildContext context) {
    final isIncome = transactionType == TransactionType.earn;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // your semantic styling
      ),
      child: Column(
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
      ),
    );
  }
}

class CashflowPlanWithAllocations {
  final CashFlowPlan plan;
  final List<CashFlowPlanAllocation> allocations;

  const CashflowPlanWithAllocations({
    required this.plan,
    required this.allocations,
  });
}
