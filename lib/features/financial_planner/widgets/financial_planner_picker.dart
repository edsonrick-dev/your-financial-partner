import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/widgets/financial_planner_page_shifter.dart';

class FinancialPlannerPicker extends GetView<FinancialPlannerController> {
  const FinancialPlannerPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.pageScrollController,
      padding: const EdgeInsets.symmetric(vertical: 4),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 12),
          ...controller.financialPlannerPages.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return FinancialPlannerPageShifter(
              key: controller.financialPlannerKeys[index],
              title: item.title,
              index: index,
            );
          }),

          SizedBox(width: 12),
        ],
      ),
    );
  }
}
