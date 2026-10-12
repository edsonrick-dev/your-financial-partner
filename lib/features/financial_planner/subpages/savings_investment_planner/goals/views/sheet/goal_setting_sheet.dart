import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/widget/goal_type_card.dart';
import 'package:getx_drift_app/features/profile/user_profile_sheet.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:intl/intl.dart';

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
        _selectRetirementGoal();
        break;

      case GoalType.education:
        // Open education setup
        break;

      case GoalType.general:
        // Open general goal setup
        break;
    }
  }

  Future<void> _selectRetirementGoal() async {
    debugPrint('🟦 _selectRetirementGoal() START');

    final profile = await database.userProfileDao.getProfile();

    debugPrint(
      '🟦 Profile before setup: '
      'name=${profile?.name}, '
      'birthday=${profile?.birthday}',
    );

    Get.back();

    debugPrint('🟦 GoalSettingSheet closed');

    if (profile?.name == null ||
        profile!.name!.trim().isEmpty ||
        profile.birthday == null) {
      debugPrint('🟨 Birthday missing → opening UserProfileSetupSheet');

      await Get.bottomSheet(
        const UserProfileSetupSheet(),
        isScrollControlled: true,
      );

      debugPrint('🟨 UserProfileSetupSheet CLOSED');

      final updatedProfile = await database.userProfileDao.getProfile();

      debugPrint(
        '🟨 Profile after setup: '
        'name=${updatedProfile?.name}, '
        'birthday=${updatedProfile?.birthday}',
      );

      if (updatedProfile?.name == null ||
          updatedProfile!.name!.trim().isEmpty ||
          updatedProfile.birthday == null) {
        debugPrint('🟥 Profile incomplete → RETURNING WITHOUT NAVIGATION');
        return;
      }

      debugPrint('🟩 Birthday exists → continuing to Retirement Planner');
    }

    debugPrint('🟪 NAVIGATING → RETIREMENTFUNDPAGE');

    Get.toNamed(Routes.RETIREMENTFUNDPAGE, preventDuplicates: false);
  }
}
