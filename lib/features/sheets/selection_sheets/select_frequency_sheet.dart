import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/widgets/fields/shared/field_container.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class SelectFrequencySheet extends StatelessWidget {
  const SelectFrequencySheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final frequencies = BillsFrequency.values.where((f) => f.isSupported);
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.75, minHeight: 200),

      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppBorderRadius.sheetTop,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              AppGrabber(),
              AppToolbar(title: 'Select Frequency'),
            ],
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 24),
            child: AppSection(
              child: Column(
                spacing: 12,
                children: frequencies.map((frequency) {
                  return AppFieldContainer(
                    child: Text(frequency.label),
                    onTap: () {
                      Get.back(result: frequency);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
