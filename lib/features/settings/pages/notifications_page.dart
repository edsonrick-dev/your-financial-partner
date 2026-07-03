import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/settings/widgets/settings_section.dart';

class NotificationsPage extends GetView<SettingsController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: Column(
        spacing: 24,
        children: [
          SettingsSection(
            title: 'General',
            children: [
              Obx(
                () => ToggleTile(
                  title: 'Budget Reminders',
                  subtitle: 'Get reminder about budget limits',
                  toggleValue: controller.budgetReminders.value,
                  onToggleChanged: (value) {
                    controller.budgetReminders.value = value;
                  },
                  onTap: () {
                    controller.budgetReminders.toggle();
                  },
                ),
              ),
              Obx(
                () => ToggleTile(
                  title: 'Bill Reminders',
                  subtitle: 'Never miss a due date',
                  toggleValue: controller.billReminders.value,
                  onToggleChanged: (value) {
                    controller.billReminders.value = value;
                  },
                  onTap: () {
                    controller.billReminders.toggle();
                  },
                ),
              ),
            ],
          ),
          SettingsSection(
            title: 'Reports & Insights',
            children: [
              Obx(
                () => ToggleTile(
                  title: 'Weekly Summary',
                  subtitle: 'Your weekly financial overview',
                  toggleValue: controller.weeklySummaryReminders.value,
                  onToggleChanged: (value) {
                    controller.weeklySummaryReminders.value = value;
                  },
                  onTap: () {
                    controller.weeklySummaryReminders.toggle();
                  },
                ),
              ),
              Obx(
                () => ToggleTile(
                  title: 'Monthly Report',
                  subtitle: 'Detailed monthly report',
                  toggleValue: controller.monthlySummaryReminders.value,
                  onToggleChanged: (value) {
                    controller.monthlySummaryReminders.value = value;
                  },
                  onTap: () {
                    controller.monthlySummaryReminders.toggle();
                  },
                ),
              ),
              Obx(
                () => ToggleTile(
                  title: 'Achievement Notifications',
                  subtitle: 'Celebrate your milestones',
                  toggleValue: controller.achievementNotifications.value,
                  onToggleChanged: (value) {
                    controller.achievementNotifications.value = value;
                  },
                  onTap: () {
                    controller.achievementNotifications.toggle();
                  },
                ),
              ),
            ],
          ),
          SettingsSection(
            title: 'Other',
            children: [
              Obx(
                () => ToggleTile(
                  title: 'Marketing & Updates>',
                  subtitle: 'Tips, new features, and others',
                  toggleValue: controller.marketingUpdates.value,
                  onToggleChanged: (value) {
                    controller.marketingUpdates.value = value;
                  },
                  onTap: () {
                    controller.marketingUpdates.toggle();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ToggleTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String? choice;
  final String? subtitle;
  final bool toggleValue;
  final ValueChanged<bool>? onToggleChanged;

  const ToggleTile({
    super.key,
    this.onTap,
    required this.title,
    this.choice,
    this.subtitle,
    this.toggleValue = false,
    this.onToggleChanged,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      constraints: BoxConstraints(minHeight: 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyle(color: colorScheme.appTextMuted),
                ),
            ],
          ),
          Spacer(),
          Switch.adaptive(value: toggleValue, onChanged: onToggleChanged),
        ],
      ),
    );
  }
}

class SettingsController extends GetxController {
  final budgetReminders = false.obs;
  final billReminders = false.obs;
  final weeklySummaryReminders = false.obs;
  final monthlySummaryReminders = false.obs;
  final achievementNotifications = false.obs;
  final marketingUpdates = false.obs;
}
