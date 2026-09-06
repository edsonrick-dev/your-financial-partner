import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_occurrence_selectors/annual_selector.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_occurrence_selectors/monthly_selector.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_occurrence_selectors/quarterly_selector.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_occurrence_selectors/semi_annual_selector.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';

class BillOccurrenceSelector extends GetView<BillController> {
  const BillOccurrenceSelector({required this.frequency, super.key});

  final BillsFrequency frequency;

  @override
  Widget build(BuildContext context) {
    switch (frequency) {
      case BillsFrequency.monthly:
        return MonthlyOccurrenceSelector(controller: controller);

      case BillsFrequency.quarterly:
        return QuarterlyOccurrenceSelector(controller: controller);

      case BillsFrequency.semiAnnual:
        return SemiAnnualOccurrenceSelector(controller: controller);

      case BillsFrequency.annual:
        return AnnualOccurrenceSelector(controller: controller);

      case BillsFrequency.weekly:
      case BillsFrequency.biWeekly:
      case BillsFrequency.fortnightly:
        return const SizedBox.shrink();
    }
  }
}
