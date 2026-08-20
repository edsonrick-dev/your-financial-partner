import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/cashflow_details_view.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/shared/field_container.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
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
                  label: 'Category',
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

                return AppTextField(
                  label: 'Amount',
                  onChanged: (_) => controller.amountChanged(),
                  prefixText: '₱',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  focusNode: controller.amountFocusNode,
                  controller: controller.amountController,
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

                    AppFieldContainer(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${period.label} total'),
                          Text(
                            controller.plannedPeriodAmount.toCurrency(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: spacingHeight),

              // // Custom distribution fields
              // Obx(() {
              //   final period = controller.selectedPeriod.value;

              //   if (period == null ||
              //       !period.supportsCustomization ||
              //       controller.selectedDistribution.value !=
              //           CashFlowDistribution.custom) {
              //     return const SizedBox.shrink();
              //   }

              //   return const CashFlowDistributionFields();
              // }),
              // SizedBox(height: spacingHeight),
              // Obx(() {
              //   final isCustom =
              //       controller.selectedDistribution.value ==
              //       CashFlowDistribution.custom;

              //   if (isCustom) {
              //     return AppFieldContainer(
              //       onTap: () {},
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text('${controller.selectedPeriod.value?.label} total'),
              //           Text(
              //             controller.plannedPeriodAmount.toCurrency(),
              //             style: Theme.of(context).textTheme.titleMedium,
              //           ),
              //         ],
              //       ),
              //     );
              //   }

              //   return AppTextField(
              //     label: 'Amount',
              //     onChanged: (_) => controller.amountChanged(),
              //     prefixText: '₱',
              //     keyboardType: const TextInputType.numberWithOptions(
              //       decimal: true,
              //     ),
              //     focusNode: controller.amountFocusNode,
              //     controller: controller.amountController,
              //   );
              // }),
              SizedBox(height: spacingHeight),
              // Annual projection
              Obx(() {
                final period = controller.selectedPeriod.value;

                if (period == null) {
                  return const SizedBox.shrink();
                }

                return AppFieldContainer(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Expected Annual Income'),
                      Text(
                        controller.annualizedAmount.toCurrency(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
