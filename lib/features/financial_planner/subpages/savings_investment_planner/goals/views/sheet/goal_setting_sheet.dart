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

class UserProfileSetupSheet extends StatefulWidget {
  const UserProfileSetupSheet({super.key});

  @override
  State<UserProfileSetupSheet> createState() => _UserProfileSetupSheetState();
}

class _UserProfileSetupSheetState extends State<UserProfileSetupSheet> {
  final nameController = TextEditingController();

  DateTime? birthday;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await database.userProfileDao.getProfile();

    if (!mounted) return;

    setState(() {
      nameController.text = profile?.name ?? '';
      birthday = profile?.birthday;
      isLoading = false;
    });
  }

  Future<void> _save() async {
    debugPrint('🟧 UserProfileSetupSheet._save() START');

    final name = nameController.text.trim();

    debugPrint('🟧 Name="$name", birthday=$birthday');

    if (name.isEmpty || birthday == null) {
      debugPrint('🟥 SAVE BLOCKED — name or birthday missing');
      return;
    }

    debugPrint('🟧 Calling userProfileDao.updateProfile()');

    await database.userProfileDao.updateProfile(
      name: name,
      birthday: birthday!,
    );

    debugPrint('🟧 updateProfile() COMPLETE');

    final profile = await database.userProfileDao.getProfile();

    debugPrint(
      '🟧 Profile immediately after save: '
      'name=${profile?.name}, '
      'birthday=${profile?.birthday}',
    );

    debugPrint('🟧 Closing UserProfileSetupSheet');

    Get.back();

    debugPrint('🟧 UserProfileSetupSheet Get.back() COMPLETE');

    // IMPORTANT:
    // Do NOT navigate here while debugging.
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'About You',
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : AppSection(
              child: Column(
                spacing: 20,
                children: [
                  Text(
                    'Before we proceed, let Ascend know more about you.',
                    style: AppTextStyle.headlineM,
                  ),
                  AppTextField(
                    label: 'Name',
                    controller: nameController,
                    focusNode: FocusNode(),
                  ),

                  AppDropdownField(
                    label: 'Birthday',
                    iconKey: 'calendar',
                    value: birthday == null
                        ? ''
                        : DateFormat('MMMM d, yyyy').format(birthday!),
                    hint: 'Select your birthday',
                    onTap: () {
                      final today = DateTime.now();

                      final maxBirthday = DateTime(
                        today.year - 18,
                        today.month,
                        today.day,
                      );

                      AppDatePicker.show(
                        context: context,
                        initialDate: birthday ?? maxBirthday,
                        maximumDate: maxBirthday,
                        onChanged: (date) {
                          setState(() {
                            birthday = date;
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  AppButton(text: 'Continue', onTap: _save),
                ],
              ),
            ),
    );
  }
}
