import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';

class FinancialPlannerPageShifter extends GetView<FinancialPlannerController> {
  const FinancialPlannerPageShifter({
    super.key,
    required this.title,
    required this.index,
  });
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      final isSelected = controller.selectedTabIndex.value == index;
      return AdaptivePressable(
        onTap: () {
          controller.selectTab(index);
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: colorScheme.text,
              width: isSelected ? 0.5 : 1,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              color: colorScheme.text,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              // fontSize: 1,
            ),
          ),
        ),
      );
    });
  }
}
