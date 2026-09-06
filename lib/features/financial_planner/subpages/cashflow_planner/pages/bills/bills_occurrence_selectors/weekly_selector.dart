import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';

class WeeklyOccurrenceSelector extends StatelessWidget {
  const WeeklyOccurrenceSelector({required this.controller, super.key});

  final BillController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppDropdownField(
        label: 'Due every',
        value: controller.selectedWeekday.value?.fullName,
        hint: 'Select day',
        onTap: () {
          // Open AppDay selector
        },
      ),
    );
  }
}
