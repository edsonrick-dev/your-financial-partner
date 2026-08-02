import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/settings/widgets/settings_section.dart';
import 'package:getx_drift_app/features/settings/widgets/settings_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 24,
          children: [
            Column(
              children: [
                AppBar(
                  title: Text('Settings', style: AppTextStyle.headlineL),
                  centerTitle: false,
                  surfaceTintColor: Colors.transparent,
                ),
                AppSection(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    constraints: BoxConstraints(minHeight: 44),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.bgLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colorScheme.appBorder),
                    ),
                    child: Column(
                      spacing: 12,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 12,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorScheme.appText,
                                  ),
                                ),
                                Column(
                                  spacing: 4,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Edson Rick San Juan'),
                                    Text('edsonsanjuan@gmail.com'),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                        color: colorScheme.appText,
                                      ),
                                      child: Text(
                                        'Free Account',
                                        style: TextStyle(
                                          color: colorScheme.bgLight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(PhosphorIconsRegular.pencilSimple),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          width: double.infinity,
                          constraints: BoxConstraints(minHeight: 44),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: colorScheme.surface,
                            boxShadow: [BoxShadow(offset: Offset(0, 0.5))],
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: 8,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Financial Stability Score'),
                                        Row(
                                          children: [
                                            Text(72.toString()),
                                            Text(' / ${80.toString()}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    VerticalDivider(
                                      color: colorScheme.appBorder,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Good'),
                                        Text('Keep going!'),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(PhosphorIconsRegular.caretRight, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SettingsSection(
              children: [
                SettingsTile(
                  icon: PhosphorIconsRegular.gear,
                  title: 'Preferences',
                  subtitle: 'Currency, language, and more',
                  onTap: () {
                    Get.toNamed(Routes.preferences);
                  },
                  color: Colors.purple,
                ),
                SettingsTile(
                  icon: PhosphorIconsRegular.bell,
                  title: 'Notifications',
                  subtitle: 'Manage your reminders and alert',
                  onTap: () {
                    Get.toNamed(Routes.notifications);
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
