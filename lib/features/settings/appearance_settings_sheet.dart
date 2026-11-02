import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_appearance.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

Future<ThemeMode?> showAppearanceSettingsSheet() {
  return Get.bottomSheet<ThemeMode>(
    const AppearanceSettingsSheet(),
    isScrollControlled: true,
  );
}

class AppearanceSettingsSheet extends StatefulWidget {
  const AppearanceSettingsSheet({super.key});

  @override
  State<AppearanceSettingsSheet> createState() =>
      _AppearanceSettingsSheetState();
}

class _AppearanceSettingsSheetState extends State<AppearanceSettingsSheet> {
  ThemeMode _selectedMode = AppAppearance.readThemeMode();
  bool _isSaving = false;

  Future<void> _selectThemeMode(ThemeMode mode) async {
    if (_isSaving) return;

    final previousMode = _selectedMode;
    setState(() {
      _selectedMode = mode;
      _isSaving = true;
    });

    try {
      await AppAppearance.saveThemeMode(mode);
      Get.changeThemeMode(mode);
      Get.back<ThemeMode>(result: mode);
    } catch (error, stackTrace) {
      debugPrint('Failed to save appearance preference: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (mounted) {
        setState(() {
          _selectedMode = previousMode;
          _isSaving = false;
        });
        Get.snackbar('Unable to save appearance', 'Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      adaptiveHeight: true,
      title: 'Appearance',
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: context.bottomPaddingSub,
        ),
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final mode in ThemeMode.values)
              AppCard(
                borderColor: mode == _selectedMode
                    ? colorScheme.appText
                    : colorScheme.appBorder,
                onTap: () {
                  _selectThemeMode(mode);
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _themeModeLabel(mode),
                            style: AppTextStyle.titleL,
                          ),
                          Text(
                            _themeModeDescription(mode),
                            style: AppTextStyle.bodyS,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      mode == _selectedMode
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _themeModeLabel(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'Light',
    ThemeMode.dark => 'Dark',
    ThemeMode.system => 'System',
  };

  String _themeModeDescription(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'Always use the light appearance.',
    ThemeMode.dark => 'Always use the dark appearance.',
    ThemeMode.system => 'Follow your device appearance setting.',
  };
}
