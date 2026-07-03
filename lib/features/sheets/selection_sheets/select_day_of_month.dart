import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/fields/shared/field_container.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';

class SelectDayOfMonthSheet extends StatelessWidget {
  const SelectDayOfMonthSheet({super.key, this.selectedDay});
  final int? selectedDay;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return FractionallySizedBox(
      heightFactor: AppSheetHeight.half,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppBorderRadius.sheetTop,
        ),
        child: Column(
          children: [
            Column(
              children: [
                AppGrabber(),
                AppToolbar(title: 'Select day of Month'),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: AppSection(
                  child: Column(
                    spacing: 12,
                    children: List.generate(31, (index) {
                      final day = index + 1;
                      final isSelected = day == selectedDay;

                      return AppFieldContainer(
                        onTap: () => Get.back(result: day),
                        child: Row(
                          children: [
                            Text('${ordinal(day)} day of the month'),
                            const Spacer(),
                            if (isSelected) const Icon(Icons.check),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String ordinal(int value) {
  if (value >= 11 && value <= 13) {
    return '${value}th';
  }
  switch (value % 10) {
    case 1:
      return '${value}st';
    case 2:
      return '${value}nd';
    case 3:
      return '${value}rd';
    default:
      return '${value}th';
  }
}
