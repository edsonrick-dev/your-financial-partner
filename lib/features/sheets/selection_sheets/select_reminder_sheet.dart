import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class SelectReminderSheet extends StatelessWidget {
  const SelectReminderSheet({required this.selectedDaysBefore, super.key});

  final int? selectedDaysBefore;

  static const options = <int>[1, 2, 3, 5, 7];

  String labelFor(int days) {
    switch (days) {
      case 1:
        return '1 day before';
      case 2:
        return '2 days before';
      case 3:
        return '3 days before';
      case 5:
        return '5 days before';
      case 7:
        return '1 week before';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((days) {
            final isSelected = days == selectedDaysBefore;

            return ListTile(
              title: Text(labelFor(days), style: AppTextStyle.bodyM),
              trailing: isSelected ? const Icon(Icons.check) : null,
              onTap: () {
                Navigator.of(context).pop(days);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
