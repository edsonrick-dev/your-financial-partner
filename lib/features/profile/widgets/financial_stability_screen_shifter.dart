import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_details_screen_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

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
      return AdaptivePressable(
        onTap: () {
          controller.selectTab(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.ease,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.appText : colorScheme.bgLight,
            borderRadius: BorderRadius.circular(999),
            boxShadow: AppShadows.pill(colorScheme.text),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            style: TextStyle(
              color: isSelected
                  ? colorScheme.appInversedtext
                  : colorScheme.text,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
            child: Text(title),
          ),
        ),
      );
    });
  }
}
