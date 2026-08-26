import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class CashflowPlanPeriodSelectionSheet extends StatelessWidget {
  const CashflowPlanPeriodSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: 'Select Period',
      adaptiveHeight: false,
      child: Column(
        children: BudgetPeriod.values.map((period) {
          return AdaptivePressable(
            onTap: () {
              Get.back(result: period);
            },
            child: ListTile(
              title: Text(period.label),
              subtitle: Text(period.description),
            ),
          );
        }).toList(),
      ),
    );
  }
}
