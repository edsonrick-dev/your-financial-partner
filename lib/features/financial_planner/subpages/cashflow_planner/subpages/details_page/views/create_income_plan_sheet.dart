import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/cashflow_chart_widget.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/cashflow_details_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/cashflow_distribution_fields.dart';
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
                text: 'Save Income Plan',

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

enum ButtonType { primary, outline, ghost }

class AppButton extends StatelessWidget {
  final String text;
  final ButtonType type;
  final VoidCallback? onTap;

  const AppButton({
    super.key,
    this.type = ButtonType.primary,
    this.onTap,
    required this.text,
  });

  Color _backgroundColor(BuildContext context) {
    final colorScheme = context.colors;

    return switch (type) {
      ButtonType.primary => colorScheme.appText,
      ButtonType.outline => Colors.transparent,
      ButtonType.ghost => Colors.transparent,
    };
  }

  Color _foregroundColor(BuildContext context) {
    final colorScheme = context.colors;

    return switch (type) {
      ButtonType.primary => colorScheme.bg,
      ButtonType.outline => colorScheme.appText,
      ButtonType.ghost => colorScheme.appText,
    };
  }

  Border? _border(BuildContext context) {
    final colorScheme = context.colors;

    return switch (type) {
      ButtonType.primary => null,
      ButtonType.outline => Border.all(color: colorScheme.appText),
      ButtonType.ghost => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _backgroundColor(context),
          border: _border(context),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.titleL.copyWith(
              color: _foregroundColor(context),
            ),
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
              CashflowPlanValueCreation(transactionType: TransactionType.earn),

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
