import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';

class SemiAnnualOccurrenceSelector extends StatelessWidget {
  const SemiAnnualOccurrenceSelector({required this.controller, super.key});

  final BillController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Obx(
            () => AppDropdownField(
              showIcon: false,
              label: 'Months Due',
              value: controller.selectedMonthPattern.value?.shortLabel(),
              hint: 'Select months',
              onTap: () async {
                final selectedPattern = await AppSheets.selection
                    .selectMonthPattern(BillsFrequency.semiAnnual);

                if (selectedPattern != null) {
                  controller.selectedMonthPattern.value = selectedPattern;
                  controller.updateNextDueDate();
                  controller.validateBill();
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => AppDropdownField(
              showIcon: false,
              label: 'Due on',
              value: controller.selectedMonthDay.value?.toString(),
              hint: 'Select day',
              onTap: () async {
                final selectedDay = await AppSheets.selection.selectDayOfMonth(
                  selectedDAy: controller.selectedMonthDay.value,
                );

                if (selectedDay != null) {
                  controller.selectedMonthDay.value = selectedDay;
                  controller.updateNextDueDate();
                  controller.validateBill();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
