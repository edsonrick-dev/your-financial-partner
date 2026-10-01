import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/widget/goal_type_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class GoalSettingSheet extends StatelessWidget {
  const GoalSettingSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Set Goals',
      child: AppSection(
        child: Column(
          spacing: 12,
          children: GoalType.values.map((goalType) {
            return GoalTypeCard(
              goal: goalType,
              onTap: () => _selectGoal(goalType),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _selectGoal(GoalType goalType) {
    switch (goalType) {
      case GoalType.emergencyFund:
        Get.back();
        Get.toNamed(Routes.EMERGENCYFUNDPAGE, preventDuplicates: false);
        break;

      case GoalType.retirement:
        Get.back();
        Get.toNamed(Routes.RETIREMENTFUNDPAGE, preventDuplicates: false);
        break;

      case GoalType.education:
        // Open education setup
        break;

      case GoalType.general:
        // Open general goal setup
        break;
    }
  }
}
