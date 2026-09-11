import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/loan_detail_sheet/loan_controller.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/widgets/bill_frequency_selector.dart';

class LoanPaymentScheduleSection extends GetView<LoanController> {
  const LoanPaymentScheduleSection({super.key});

  static const mvpFrequencies = [
    BillsFrequency.monthly,
    BillsFrequency.quarterly,
    BillsFrequency.semiAnnual,
    BillsFrequency.annual,
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      sectionTitle: 'Payment Schedule',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          // ============================================================
          // ENABLE SCHEDULE
          // ============================================================
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Set a payment schedule',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.paymentScheduleEnabled.value
                            ? 'Track when your loan payments are due'
                            : 'Add this later if you want to schedule payments',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: controller.paymentScheduleEnabled.value,
                  onChanged: controller.setPaymentScheduleEnabled,
                ),
              ],
            ),
          ),

          // ============================================================
          // SCHEDULE DETAILS
          // ============================================================
          Obx(() {
            if (!controller.paymentScheduleEnabled.value) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                // --------------------------------------------------------
                // FIRST PAYMENT DATE
                // --------------------------------------------------------
                Obx(
                  () => AppDropdownField(
                    label: 'Next Payment Date',
                    iconKey: 'calendar',
                    value: controller.formattedFirstPaymentDate,
                    hint: 'Select date',
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();

                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);

                      AppDatePicker.show(
                        context: context,
                        initialDate: controller.firstPaymentDate.value,
                        minimumDate: today,
                        onChanged: controller.setFirstPaymentDate,
                      );
                    },
                  ),
                ),

                // --------------------------------------------------------
                // FREQUENCY
                // --------------------------------------------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: colorScheme.bgLight,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: colorScheme.appBorder),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: mvpFrequencies.map((frequency) {
                          return BillsFrequencySelector(
                            period: frequency,
                            isSelected:
                                controller.paymentFrequency.value == frequency,
                            onTap: () {
                              controller.setPaymentFrequency(frequency);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Text(
                        controller.paymentFrequency.value?.billsLabel ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.appText,
                        ),
                      ),
                    ),
                  ],
                ),
                // --------------------------------------------------------
                // PAYMENT AMOUNT
                // --------------------------------------------------------
                AppAmountField(
                  label: 'Payment Amount',
                  amount: controller.paymentAmount.value,
                  onChanged: controller.setPaymentAmount,
                ),
                // --------------------------------------------------------
                // PAYMENT SUMMARY
                // --------------------------------------------------------
                Obx(() {
                  if (controller.paymentAmount.value <= 0) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.bgLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colorScheme.appBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Text(
                          'Payment Summary',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '₱${controller.paymentAmount.value.toStringAsFixed(2)} '
                          '${controller.paymentFrequency.value?.billsLabel ?? ''}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'Next payment: ${controller.formattedFirstPaymentDate ?? ''}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: colorScheme.appTextMuted),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            );
          }),
        ],
      ),
    );
  }
}
