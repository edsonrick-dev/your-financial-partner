import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/settings/widgets/settings_section.dart';
import 'package:getx_drift_app/features/settings/widgets/tapable_tile.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preferences')),
      body: Column(
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
              TappableTile(title: 'Theme', choice: 'System'),
              TappableTile(title: 'Date Format', choice: 'MMM d, yyyy'),
              TappableTile(title: 'Start of Week', choice: 'Monday'),
            ],
          ),
        ],
      ),
    );
  }
}
