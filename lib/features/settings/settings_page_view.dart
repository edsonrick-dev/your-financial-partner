import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/features/settings/pages/notifications_page.dart';
import 'package:getx_drift_app/features/settings/pages/preferences_page.dart';
import 'package:getx_drift_app/features/settings/widgets/settings_section.dart';
import 'package:getx_drift_app/features/settings/widgets/settings_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.threeQuarter,

      title: 'Settings',
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            SettingsSection(
              children: [
                SettingsTile(
                  icon: PhosphorIconsRegular.gear,
                  title: 'Preferences',
                  subtitle: 'Currency, language, and more',
                  onTap: () {
                    Get.bottomSheet(
                      PreferencesPage(),
                      isScrollControlled: true,
                    );
                  },
                  color: Colors.purple,
                ),
                SettingsTile(
                  icon: PhosphorIconsRegular.bell,
                  title: 'Notifications',
                  subtitle: 'Manage your reminders and alert',
                  onTap: () {
                    Get.bottomSheet(
                      NotificationsPage(),
                      isScrollControlled: true,
                    );
                    // Get.toNamed(Routes.notifications);
                  },
                  color: Colors.orange,
                ),
                SettingsTile(
                  icon: PhosphorIconsRegular.shieldStar,
                  title: 'Security',
                  subtitle: 'App locks, biometrics, privacy, and more',
                  onTap: () {},
                  color: Colors.blueAccent,
                ),
              ],
            ),
            SettingsSection(
              children: [
                SettingsTile(
                  icon: PhosphorIconsRegular.cloud,
                  title: 'Data & Backup',
                  subtitle: 'Backup, restore, export, and import data',
                  onTap: () {},
                  color: Colors.lightBlue,
                ),
                SettingsTile(
                  icon: PhosphorIconsRegular.palette,
                  title: 'Appearance',
                  subtitle: 'Theme, color, text, and display',
                  onTap: () {},
                  color: Colors.deepPurple,
                ),
              ],
            ),

            SettingsSection(
              children: [
                SettingsTile(
                  icon: PhosphorIconsRegular.headset,
                  title: 'Support',
                  subtitle: 'Help center, contact support, and feedback',
                  onTap: () {},
                  color: Colors.green,
                ),
                SettingsTile(
                  icon: PhosphorIconsRegular.bell,
                  title: 'About',
                  subtitle: 'App version, terms, and privacy policy',
                  onTap: () {},
                  color: Colors.orange,
                ),
              ],
            ),

            SettingsSection(
              children: [
                SettingsTile(
                  icon: PhosphorIconsRegular.signOut,
                  title: 'Sign out',
                  subtitle: 'Sign out your account',
                  onTap: () {},
                  color: Colors.red,
                ),
              ],
            ),

            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
