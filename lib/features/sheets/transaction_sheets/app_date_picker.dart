import 'package:flutter/cupertino.dart';

class AppDatePicker {
  static Future<void> show({
    required BuildContext context,
    required ValueChanged<DateTime> onChanged,

    DateTime? initialDate,

    DateTime? minimumDate,

    DateTime? maximumDate,

    CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
  }) async {
    showCupertinoModalPopup(
      context: context,

      builder: (_) {
        return Container(
          height: 240,

          color: CupertinoColors.systemBackground,

          child: CupertinoDatePicker(
            mode: mode,

            initialDateTime: initialDate ?? DateTime.now(),

            minimumDate: minimumDate,

            maximumDate: maximumDate,

            onDateTimeChanged: onChanged,
          ),
        );
      },
    );
  }
}
