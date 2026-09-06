import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/plan_summary_dialog.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/cashflow_distribution_fields.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sections/cashflow_plan_annual_summary_section.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/organize_THIS/app_mode_item.dart';
import 'package:getx_drift_app/organize_THIS/app_mode_shifter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateIncomePlanSheet extends GetView<CashflowController> {
  const CreateIncomePlanSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();
    final transactionType = TransactionType.earn;
    final colorScheme = context.colors;
    double spacingHeight = 20;
    return AppSheet(
      adaptiveHeight: false,
      height: AppSheetHeight.full,
      title: 'Create Income Plan',
      child: SingleChildScrollView(
        child: AppSection(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Plan Period:', style: AppTextStyle.titleM),
                  SizedBox(height: 8),
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: colorScheme.bgLight,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: colorScheme.appBorderMuted),
                      ),
                      child: Row(
                        children: BudgetPeriod.values.map((period) {
                          return PeriodButton(
                            period: period,
                            isSelected:
                                controller.selectedPeriod.value == period,
                            onTap: () => controller.selectPeriod(period),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              // Category
              SizedBox(height: spacingHeight),
              // Period
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

              // SizedBox(height: spacingHeight),
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
                    transactionController.selectCategoryWithFilter(
                      transactionType,
                      controller.existingIncomePlanCategoryIds,
                    );
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
                            child: ModeShifter(
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
                            child: ModeShifter(
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

                    SizedBox(height: 20),
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
              CashflowPlanAnnualSummarySection(
                transactionType: transactionType,
              ),
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

class PeriodButton extends StatelessWidget {
  const PeriodButton({
    required this.period,
    required this.isSelected,
    this.onTap,
    super.key,
  });

  final BudgetPeriod period;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Expanded(
      child: AdaptivePressable(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.pageShifterFillSelected
                : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                period.label,
                maxLines: 1,
                style: isSelected
                    ? AppTextStyle.titleM.copyWith(
                        color: colorScheme.pageShifterTextSelected,
                        // fontWeight: FontWeight.w600,
                      )
                    : AppTextStyle.bodyM.copyWith(
                        color: colorScheme.pageShifterTextUnselected,
                        // fontWeight: FontWeight.w400,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
