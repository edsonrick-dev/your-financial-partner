import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/widget/goal_type_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class GoalSettingSheet extends StatelessWidget {
  const GoalSettingSheet({super.key});

  bool _isSingletonGoal(GoalType goalType) {
    switch (goalType) {
      case GoalType.emergencyFund:
      case GoalType.retirement:
        return true;

      case GoalType.education:
      case GoalType.general:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Set Goals',
      child: FutureBuilder<List<GoalsTableData>>(
        future: database.goalsDao.getAllGoals(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }

          final goals = snapshot.data!;

          return AppSection(
            child: Column(
              spacing: 12,
              children: GoalType.values.map((goalType) {
                final isSingleton = _isSingletonGoal(goalType);

                final exists =
                    isSingleton &&
                    goals.any((goal) => goal.type == goalType.name);

                return GoalTypeCard(
                  goal: goalType,
                  enabled: !exists,
                  status: exists ? 'Already set up' : null,
                  onTap: exists ? null : () => _selectGoal(goalType),
                );
              }).toList(),
            ),
          );
        },
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
