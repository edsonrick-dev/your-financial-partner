import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:intl/intl.dart';

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
