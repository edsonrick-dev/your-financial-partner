import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_appearance.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/features/settings/appearance_settings_sheet.dart';
import 'package:getx_drift_app/features/settings/widgets/settings_section.dart';
import 'package:getx_drift_app/features/settings/widgets/tapable_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  ThemeMode _themeMode = AppAppearance.readThemeMode();

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.threeQuarter,
      adaptiveHeight: true,
      title: 'Preferences',
      child: Column(
        spacing: 24,
        children: [
          SettingsSection(
            title: 'General',
            children: [
              TappableTile(title: 'Currency', choice: 'Philippine Peso (P)'),
              TappableTile(title: 'Number Format', choice: 'P1,000.00'),
            ],
          ),
          SettingsSection(
            title: 'App',
            children: [
              TappableTile(
                title: 'Theme',
                choice: _themeModeLabel(_themeMode),
                onTap: () async {
                  final selectedMode = await showAppearanceSettingsSheet();
                  if (selectedMode != null && mounted) {
                    setState(() => _themeMode = selectedMode);
                  }
                },
              ),
              TappableTile(title: 'Date Format', choice: 'MMM d, yyyy'),
              TappableTile(title: 'Start of Week', choice: 'Monday'),
            ],
          ),
        ],
      ),
    );
  }

  String _themeModeLabel(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'Light',
    ThemeMode.dark => 'Dark',
    ThemeMode.system => 'System',
  };
}
