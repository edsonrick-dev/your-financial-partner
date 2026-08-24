import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/cashflow_details_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/cashflow_distribution_fields.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/cashflow_plan_annual_summary.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/create_income_plan_sheet.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class CreateExpensePlanSheet extends GetView<CashflowController> {
  const CreateExpensePlanSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();
    final transactionType = TransactionType.spend;
    double spacingHeight = 20;
    return AppSheet(
      adaptiveHeight: false,
      height: AppSheetHeight.full,
      title: 'Create Expense Plan',
      child: SingleChildScrollView(
        child: AppSection(
          child: Column(
            children: [
              Obx(
                () => AppDropdownField(
                  label: 'Expense Category',
                  value: transactionController.selectedCategory.value?.name,
                  hint: 'Select expense category',
                  onTap: () {
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
              // FutureBuilder<List<double>>(
              //   future: controller.calculateCurrentMonthlyDistribution(
              //     transactionType: transactionType,
              //   ),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const SizedBox(
              //         height: 220,
              //         child: Center(child: CircularProgressIndicator()),
              //       );
              //     }

              //     if (snapshot.hasError) {
              //       return const SizedBox.shrink();
              //     }

              //     return Obx(
              //       () => CashflowPlanMonthlyDistribution(
              //         transactionType: transactionType,
              //         currentDistribution:
              //             snapshot.data ?? List<double>.filled(12, 0),
              //         plannedDistribution:
              //             controller.monthlyPlannedDistribution,
              //       ),
              //     );
              //   },
              // ),
              // CashflowPlanValueCreation(transactionType: transactionType),
              AppButton(
                type: ButtonType.outline,
                text: 'View Plan Summary',
                onTap: () {
                  Get.dialog(
                    const PlanSummaryDialog(),
                    barrierDismissible: true,
                  );
                },
              ),
              SizedBox(height: spacingHeight),

              AppButton(
                text: 'Save Expense Plan',
                onTap: () async {
                  await controller.saveCashflowPlan(
                    transactionType: transactionType,
                  );
                },
              ),
              SizedBox(height: spacingHeight * 4),
            ],
          ),
        ),
      ),
    );
  }
}
