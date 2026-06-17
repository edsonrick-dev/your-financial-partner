import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
import 'package:getx_drift_app/domain/scheduling/month_pattern.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';

class SelectMonthPatternSheet extends StatelessWidget {
  const SelectMonthPatternSheet({
    super.key,
    required this.patterns,
    required this.frequency,
  });
  final List<MonthPattern> patterns;
  final FrequencyType frequency;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return FractionallySizedBox(
      heightFactor: AppSheetHeight.full,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(38)),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              ///HEADER
              Column(
                children: [
                  AppGrabber(),
                  AppToolbar(title: 'Choose Month/s'),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 12,
                    children: patterns.map((pattern) {
                      return GestureDetector(
                        onTap: () {
                          Get.back(result: pattern);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.pageHorizontal,
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: colorScheme.appOnSurface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: colorScheme.appBorder),
                            ),
                            child: Text(
                              frequency == FrequencyType.annual
                                  ? pattern.fullLabel()
                                  : pattern.shortLabel(),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
