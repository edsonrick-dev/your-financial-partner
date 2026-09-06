import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/cashflow_plan_period_selection_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/create_income_plan_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/plan_summary_dialog.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/cashflow_distribution_fields.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sections/cashflow_plan_annual_summary_section.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/forms/spend_transaction_form.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
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
              SizedBox(height: spacingHeight),
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
                            child: ModeButton(
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
                            child: ModeButton(
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

              // Obx(() {
              //   final period = controller.selectedPeriod.value;

              //   if (period == null || !period.supportsCustomization) {
              //     return const SizedBox.shrink();
              //   }

              //   return Column(
              //     children: [
              //       Row(
              //         children: [
              //           Text(
              //             'Cashflow Distribution:',
              //             style: AppTextStyle.titleM,
              //           ),
              //           Spacer(),
              //           Container(
              //             padding: const EdgeInsets.all(4),
              //             decoration: BoxDecoration(
              //               color: colorScheme.bgLight,
              //               borderRadius: BorderRadius.circular(12),
              //               border: Border.all(
              //                 color: colorScheme.appBorderMuted,
              //               ),
              //             ),
              //             child: Row(
              //               children: [
              //                 ModeButton(
              //                   item: const ModeItem(
              //                     selectedIcon: PhosphorIconsFill.coin,
              //                     unselectedIcon: PhosphorIconsRegular.coin,
              //                     title: 'Evenly',
              //                   ),
              //                   selected:
              //                       controller.selectedDistribution.value ==
              //                       CashFlowDistribution.defaultDistribution,
              //                   onTap: () {
              //                     controller.selectDistribution(
              //                       CashFlowDistribution.defaultDistribution,
              //                     );
              //                   },
              //                 ),
              //                 ModeButton(
              //                   item: const ModeItem(
              //                     selectedIcon: PhosphorIconsFill.coins,
              //                     unselectedIcon: PhosphorIconsRegular.coins,
              //                     title: 'Custom',
              //                   ),
              //                   selected:
              //                       controller.selectedDistribution.value ==
              //                       CashFlowDistribution.custom,
              //                   onTap: () {
              //                     controller.selectDistribution(
              //                       CashFlowDistribution.custom,
              //                     );
              //                   },
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //       SizedBox(height: 12),
              //       // SegmentedButton<CashFlowDistribution>(
              //       //   segments: const [
              //       //     ButtonSegment(
              //       //       value: CashFlowDistribution.defaultDistribution,
              //       //       label: Text('Evenly'),
              //       //     ),
              //       //     ButtonSegment(
              //       //       value: CashFlowDistribution.custom,
              //       //       label: Text('Custom'),
              //       //     ),
              //       //   ],
              //       //   selected: {controller.selectedDistribution.value},
              //       //   onSelectionChanged: (selection) {
              //       //     controller.selectDistribution(selection.first);
              //       //   },
              //       // ),
              //       // SizedBox(height: spacingHeight),
              //     ],
              //   );
              // }),

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
