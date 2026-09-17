import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bill_budget_notice.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/widgets/bill_frequency_selector.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
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
                            showIcon:
                                transactionController
                                    .selectedCategory
                                    .value
                                    ?.icon !=
                                null,
                            iconKey: transactionController
                                .selectedCategory
                                .value
                                ?.icon,
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
                      spacing: 20,
                      children: [
                        Obx(
                          () => AppDropdownField(
                            label: 'Next Payment',
                            iconKey: 'calendar',
                            value: controller.formattedNextPaymentDate,
                            hint: 'Select Date',
                            onTap: () {
                              controller.selectNextPaymentDate(context);
                            },
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Billing Schedule', style: AppTextStyle.bodyM),
                            SizedBox(height: 8),
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
                                  children: mvpBillFrequencies.map((frequency) {
                                    return BillsFrequencySelector(
                                      period: frequency,
                                      isSelected:
                                          controller.selectedPeriod.value ==
                                          frequency,
                                      onTap: () =>
                                          controller.selectPeriod(frequency),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Obx(() {
                              final nextPaymentDate =
                                  controller.nextPaymentDate.value;
                              final frequency = controller.selectedPeriod.value;

                              if (nextPaymentDate == null ||
                                  frequency == null) {
                                return const SizedBox.shrink();
                              }

                              return BillScheduleMonths(
                                nextPaymentDate: nextPaymentDate,
                                frequency: frequency,
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // BillScheduleSummary(),
                  Obx(() {
                    if (controller.isBillValid.value) {
                      return AppSection(child: BillBudgetNotice());
                    }
                    return const SizedBox.shrink();
                  }),
                  SizedBox(height: context.bottomPaddingSub),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension BillControllerScheduleExtension on BillController {
  void selectNextPaymentDate(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    AppDatePicker.show(
      context: context,
      initialDate: nextPaymentDate.value ?? today,
      minimumDate: today,
      onChanged: (date) {
        nextPaymentDate.value = date;
        validateBill();
      },
    );
  }

  void selectPeriod(BillsFrequency period) {
    selectedPeriod.value = period;
    validateBill();
  }

  bool get isScheduleValid {
    return nextPaymentDate.value != null && selectedPeriod.value != null;
  }

  void validateBill() {
    final category = transactionController.selectedCategory.value;

    isBillValid.value =
        billNameController.text.trim().isNotEmpty &&
        billAmount.value > 0 &&
        category != null &&
        isScheduleValid;
  }
}

class BillScheduleMonths extends StatelessWidget {
  final DateTime nextPaymentDate;
  final BillsFrequency frequency;

  const BillScheduleMonths({
    super.key,
    required this.nextPaymentDate,
    required this.frequency,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final impactedMonths = _getImpactedMonths();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(height: 12),
        Row(
          spacing: 4,
          children: AppMonth.values.map((month) {
            final isImpacted = impactedMonths[month.index];

            return Expanded(
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isImpacted ? colorScheme.appText : colorScheme.bgLight,
                  border: Border.all(color: colorScheme.appBorder),
                ),
                child: Center(
                  child: Text(
                    month.shortName.substring(0, 1),
                    style: AppTextStyle.labelS.copyWith(
                      color: isImpacted
                          ? colorScheme.bgLight
                          : colorScheme.appText,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Text(
          _scheduleDescription,
          style: AppTextStyle.bodyS.copyWith(color: colorScheme.appTextMuted),
        ),
      ],
    );
  }

  String get _scheduleDescription {
    final day = nextPaymentDate.day;
    final months = _getImpactedMonthNames();

    switch (frequency) {
      case BillsFrequency.monthly:
        return 'Your bill falls every $day${_ordinalSuffix(day)} of the month';

      case BillsFrequency.quarterly:
      case BillsFrequency.semiAnnual:
      case BillsFrequency.annual:
        return 'Your bill falls every $day${_ordinalSuffix(day)} of ${_formatMonthList(months)}';

      case BillsFrequency.weekly:
        return 'Your bill falls every week';

      case BillsFrequency.biWeekly:
      case BillsFrequency.fortnightly:
        return 'Your bill falls every 2 weeks';
    }
  }

  List<String> _getImpactedMonthNames() {
    final impacted = _getImpactedMonths();

    return AppMonth.values
        .where((month) => impacted[month.index])
        .map((month) => month.fullName)
        .toList();
  }

  String _formatMonthList(List<String> months) {
    if (months.length == 1) {
      return months.first;
    }

    if (months.length == 2) {
      return '${months[0]} and ${months[1]}';
    }

    return '${months.sublist(0, months.length - 1).join(', ')}, and ${months.last}';
  }

  String _ordinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  List<bool> _getImpactedMonths() {
    final impacted = List<bool>.filled(12, false);
    const calculator = BillScheduleCalculator();

    var currentDate = nextPaymentDate;

    while (!impacted[currentDate.month - 1]) {
      impacted[currentDate.month - 1] = true;

      currentDate = calculator.getNextOccurrence(
        currentDate: currentDate,
        frequency: frequency,
        anchorDay: nextPaymentDate.day,
      );
    }

    return impacted;
  }
}

class BillScheduleCalculator {
  const BillScheduleCalculator();

  DateTime getNextOccurrence({
    required DateTime currentDate,
    required BillsFrequency frequency,
    required int anchorDay,
  }) {
    switch (frequency) {
      case BillsFrequency.monthly:
        return _addMonthsClamped(currentDate, 1, anchorDay);

      case BillsFrequency.quarterly:
        return _addMonthsClamped(currentDate, 3, anchorDay);

      case BillsFrequency.semiAnnual:
        return _addMonthsClamped(currentDate, 6, anchorDay);

      case BillsFrequency.annual:
        return _addMonthsClamped(currentDate, 12, anchorDay);

      case BillsFrequency.weekly:
        return currentDate.add(const Duration(days: 7));

      case BillsFrequency.biWeekly:
      case BillsFrequency.fortnightly:
        return currentDate.add(const Duration(days: 14));
    }
  }

  DateTime _addMonthsClamped(DateTime date, int months, int anchorDay) {
    final target = DateTime(date.year, date.month + months, 1);

    final lastDay = DateTime(target.year, target.month + 1, 0).day;

    return DateTime(target.year, target.month, anchorDay.clamp(1, lastDay));
  }

  List<int> getImpactedMonths({
    required DateTime startDate,
    required BillsFrequency frequency,
    required int anchorDay,
  }) {
    final months = <int>{};
    var currentDate = startDate;

    while (!months.contains(currentDate.month)) {
      months.add(currentDate.month);

      currentDate = getNextOccurrence(
        currentDate: currentDate,
        frequency: frequency,
        anchorDay: anchorDay,
      );
    }

    return months.toList();
  }
}
