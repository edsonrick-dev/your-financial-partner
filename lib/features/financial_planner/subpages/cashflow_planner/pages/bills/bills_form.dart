import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bill_budget_notice.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_occurrence_selectors/bill_occurrence_selector.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/widgets/bill_frequency_selector.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/widgets/bill_schedule_summary.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class BillForm extends GetView<BillController> {
  const BillForm({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final transactionController = Get.find<TransactionController>();
    final transactionType = TransactionType.spend;
    const mvpBillFrequencies = [
      BillsFrequency.monthly,
      BillsFrequency.quarterly,
      BillsFrequency.semiAnnual,
      BillsFrequency.annual,
    ];
    return AppSheet(
      title: 'Add Bill',
      height: AppSheetHeight.full,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  AppSection(
                    sectionTitle: 'Bill Details',
                    child: Column(
                      spacing: 20,
                      children: [
                        AppTextField(
                          label: 'Bill Name',
                          controller: controller.billNameController,
                          focusNode: controller.billNameFocusNode,
                          onChanged: (_) => controller.validateBill(),
                        ),
                        Obx(
                          () => AppDropdownField(
                            label: 'Category',
                            iconKey:
                                transactionController
                                    .selectedCategory
                                    .value
                                    ?.icon ??
                                'category',
                            value: transactionController
                                .selectedCategory
                                .value
                                ?.name,
                            hint: 'Select category',
                            onTap: () {
                              transactionController.selectCategory(
                                transactionType,
                              );
                            },
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Obx(
                              () => AppAmountField(
                                label: 'Amount',
                                amount: controller.billAmount.value,
                                onChanged: (value) {
                                  controller.billAmount.value = value;
                                  controller.validateBill();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                'Enter the expected amount for this bill. You can update it when you pay.',
                                style: AppTextStyle.labelS.copyWith(
                                  color: colorScheme.appTextMuted,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppSection(
                    sectionTitle: 'Schedule',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text('Plan Period:', style: AppTextStyle.titleM),
                            // SizedBox(height: 8),
                            Obx(
                              () => Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: colorScheme.bgLight,
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                    color: colorScheme.appBorder,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: mvpBillFrequencies.map((period) {
                                    return BillsFrequencySelector(
                                      period: period,
                                      isSelected:
                                          controller.selectedPeriod.value ==
                                          period,
                                      onTap: () =>
                                          controller.selectPeriod(period),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Obx(
                              () => Text(
                                textAlign: TextAlign.end,
                                controller.selectedPeriod.value!.billsLabel,
                                style: AppTextStyle.bodyM.copyWith(
                                  color: colorScheme.appText,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => BillOccurrenceSelector(
                            frequency: controller.selectedPeriod.value!,
                          ),
                        ),

                        // AppTextField(
                        //   label: 'Due On',
                        //   controller: controller.billNameController,
                        //   focusNode: controller.billNameFocusNode,
                        // ),
                        Obx(
                          () => Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Set reminder',
                                          style: AppTextStyle.titleM,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          controller.reminderEnabled.value
                                              ? 'Remind me before the bill is due'
                                              : 'No reminder',
                                          style: AppTextStyle.bodyM.copyWith(
                                            color: colorScheme.appTextMuted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch.adaptive(
                                    value: controller.reminderEnabled.value,
                                    onChanged: (value) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      controller.reminderEnabled.value = value;

                                      if (value) {
                                        controller.reminderDaysBefore.value ??=
                                            3;
                                      } else {
                                        controller.reminderDaysBefore.value =
                                            null;
                                      }
                                    },
                                  ),
                                ],
                              ),

                              if (controller.reminderEnabled.value) ...[
                                const SizedBox(height: 12),

                                AppDropdownField(
                                  showIcon: false,
                                  label: 'Remind me',
                                  value: switch (controller
                                      .reminderDaysBefore
                                      .value) {
                                    1 => '1 day before',
                                    2 => '2 days before',
                                    3 => '3 days before',
                                    7 => '1 week before',
                                    _ => null,
                                  },
                                  hint: 'Select reminder',
                                  onTap: () async {
                                    final selectedDays = await AppSheets
                                        .selection
                                        .selectReminder(
                                          selectedDaysBefore: controller
                                              .reminderDaysBefore
                                              .value,
                                        );

                                    if (selectedDays != null) {
                                      controller.reminderDaysBefore.value =
                                          selectedDays;
                                    }
                                  },
                                ),
                              ],
                            ],
                          ),
                        ),
                        BillScheduleSummary(),
                      ],
                    ),
                  ),
                  Obx(() {
                    if (controller.isBillValid.value) {
                      return AppSection(child: BillBudgetNotice());
                    }
                    return const SizedBox.shrink();
                  }),
                  SizedBox(height: context.bottomPadding),
                ],
              ),
            ),
          ),

          // Obx(
          //   () => AppSection(
          //     child: AppButton(
          //       text: 'Save',
          //       onTap: controller.isBillValid.value
          //           ? () {
          //               // save
          //             }
          //           : null,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// class BillBudgetNotice extends GetView<BillController> {
//   const BillBudgetNotice({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final transactionController = Get.find<TransactionController>();
//     return Container(
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.purple.withValues(alpha: 0.2),
//         border: Border.all(color: Colors.purple),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(PhosphorIconsRegular.lightbulb),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'No budget for ${transactionController.selectedCategory.value!.name} yet.',
//                       style: AppTextStyle.headlineS,
//                     ),
//                     // SizedBox(height: 8),
//                     Text(
//                       'Your new bill of '
//                       '₱${controller.billAmount.value.toCurrency()}/${controller.selectedPeriod.value!.period} '
//                       'will be used as the minimum budget for this category.',
//                       style: AppTextStyle.bodyM,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           // BillsRow(amount: 0, frequency: 'month', title: 'Current budget'),

//           // // BillsRow(
//           // //   isMain: false,
//           // //   amount: 0,
//           // //   frequency: 'month',
//           // //   title: 'Other recurring bills',
//           // // ),
//           // BillsRow(
//           //   amount: controller.billAmount.value,
//           //   frequency: 'month',
//           //   title: 'Total recurring bills',
//           // ),
//           SizedBox(height: 20),
//           // Text('''You'll be over by P300/month'''),
//           AppButton(text: 'Create budget for P300/month', onTap: () {}),
//           AppButton(
//             type: ButtonType.ghost,
//             text: 'Set custom budget',
//             onTap: () {},
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(PhosphorIconsRegular.floppyDisk),
//               SizedBox(width: 8),
//               Text(
//                 '''This bill will be saved if you choose to adjust budget''',
//                 style: AppTextStyle.labelS,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
