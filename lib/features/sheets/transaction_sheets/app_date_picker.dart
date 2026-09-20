import 'package:flutter/cupertino.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';

class AppDatePicker {
  static Future<void> show({
    required BuildContext context,
    required ValueChanged<DateTime> onChanged,

    DateTime? initialDate,

    DateTime? minimumDate,

    DateTime? maximumDate,

    CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
  }) async {
    final colorScheme = context.colors;
    showCupertinoModalPopup(
      context: context,

      builder: (_) {
        return Container(
          height: 240,

          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: AppBorderRadius.sheetTop,
          ),

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
