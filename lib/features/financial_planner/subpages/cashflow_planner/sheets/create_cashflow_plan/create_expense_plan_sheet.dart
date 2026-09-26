import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/design_system/shifters/segment_shifter/app_segmented_selector.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/plan_summary_dialog.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/cashflow_distribution_fields.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sections/cashflow_plan_annual_summary_section.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/core/design_system/shifters/mode_shifter/app_mode_item.dart';
import 'package:getx_drift_app/core/design_system/shifters/mode_shifter/app_mode_shifter_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateExpensePlanSheet extends GetView<CashflowController> {
  const CreateExpensePlanSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Plan Period:', style: AppTextStyle.titleM),
                  SizedBox(height: 8),
                  Obx(() {
                    final selectedPeriod = controller.selectedPeriod.value;

                    return AppSegmentedSelector(
                      style: AppTextStyle.titleS,
                      items: BudgetPeriod.values
                          .map((period) => period.label)
                          .toList(),
                      selectedIndex: selectedPeriod == null
                          ? 0
                          : BudgetPeriod.values.indexOf(selectedPeriod),
                      onChanged: (index) {
                        controller.selectPeriod(BudgetPeriod.values[index]);
                      },
                    );
                  }),
                ],
              ),
              SizedBox(height: spacingHeight),
              Obx(
                () => AppDropdownField(
                  label: 'Expense Category',
                  showIcon:
                      transactionController.selectedCategory.value?.icon !=
                      null,
                  iconKey: transactionController.selectedCategory.value?.icon,
                  value: transactionController.selectedCategory.value?.name,
                  hint: 'Select expense category',
                  onTap: () {
                    transactionController.selectCategoryWithFilter(
                      transactionType,
                      controller.existingBudgetPlanCategoryIds,
                    );
                  },
                ),
              ),

              // // Period
              // Obx(
              //   () => AppDropdownField(
              //     iconKey: 'caretDown',
              //     label: 'Period',
              //     value: controller.selectedPeriod.value?.label,
              //     hint: 'Select period',
              //     onTap: () async {
              //       final selected = await Get.bottomSheet<BudgetPeriod>(
              //         const CashflowPlanPeriodSelectionSheet(),
              //         backgroundColor: Colors.transparent,
              //         isScrollControlled: true,
              //       );

              //       if (selected != null) {
              //         controller.selectPeriod(selected);
              //       }
              //     },
              //   ),
              // ),
              SizedBox(height: spacingHeight),
              // Distribution mode
              Obx(() {
                final period = controller.selectedPeriod.value;

                if (period == null || !period.supportsCustomization) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amount Distribution:', style: AppTextStyle.titleM),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: colorScheme.bgLight,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: colorScheme.appBorderMuted),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppModeShifterButton(
                              item: const ModeItem(
                                selectedIcon: PhosphorIconsFill.coin,
                                unselectedIcon: PhosphorIconsRegular.coin,
                                title: 'Even Distribution',
                              ),
                              selected:
                                  controller.selectedDistribution.value ==
                                  CashFlowDistribution.defaultDistribution,
                              onTap: () {
                                controller.selectDistribution(
                                  CashFlowDistribution.defaultDistribution,
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: AppModeShifterButton(
                              item: const ModeItem(
                                selectedIcon: PhosphorIconsFill.coins,
                                unselectedIcon: PhosphorIconsRegular.coins,
                                title: 'Custom Distribution',
                              ),
                              selected:
                                  controller.selectedDistribution.value ==
                                  CashFlowDistribution.custom,
                              onTap: () {
                                controller.selectDistribution(
                                  CashFlowDistribution.custom,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spacingHeight),
                  ],
                );
              }),

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
                  children: [
                    const CashFlowDistributionFields(),
                    Row(
                      children: [
                        Spacer(),
                        AdaptivePressable(
                          onTap: () {
                            controller.clearDistributionFields();
                          },
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              children: [
                                Icon(PhosphorIconsRegular.trash, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Clear fields',
                                  style: AppTextStyle.titleM,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),

              SizedBox(height: spacingHeight),
              // Annual projection
              CashflowPlanAnnualSummarySection(
                transactionType: transactionType,
              ),

              SizedBox(height: spacingHeight),

              Obx(() {
                final isCustom =
                    controller.selectedDistribution.value ==
                    CashFlowDistribution.custom;

                final hasValidAmount = isCustom
                    ? controller.distributionTotal > 0
                    : controller.amount.value > 0;

                final isValid =
                    transactionController.selectedCategory.value != null &&
                    hasValidAmount;

                return AppButton(
                  text: 'Save Expense Plan',
                  onTap: isValid
                      ? () async {
                          await controller.saveCashflowPlan(
                            transactionType: transactionType,
                          );
                        }
                      : null,
                );
              }),
              SizedBox(height: 12),
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
              SizedBox(height: context.bottomPaddingSub),
            ],
          ),
        ),
      ),
    );
  }
}
