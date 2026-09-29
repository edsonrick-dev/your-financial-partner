import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_details_screen_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/core/design_system/shifters/page_shifter/app_page_shifter_button.dart';

class FinancialStabilityScreenShifter
    extends GetView<FinancialProfileController> {
  const FinancialStabilityScreenShifter({
    super.key,
    required this.title,
    required this.index,
  });
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      final isSelected = controller.selectedDetailsIndex.value == index;
      return AppPageShifterButton(
        onTap: () {
          controller.selectTab(index);
        },
        isSelected: isSelected,
        colorScheme: colorScheme,
        title: title,
      );
    });
  }
}
