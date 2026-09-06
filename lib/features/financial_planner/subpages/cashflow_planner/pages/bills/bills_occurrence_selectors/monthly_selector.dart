import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';

import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';

class MonthlyOccurrenceSelector extends StatelessWidget {
  const MonthlyOccurrenceSelector({required this.controller, super.key});

  final BillController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppDropdownField(
        showIcon: false,
        label: 'Due on',
        value: controller.selectedMonthDay.value == null
            ? null
            : '${controller.selectedMonthDay.value}',
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
    );
  }
}
