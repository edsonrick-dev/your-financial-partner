import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_details_screen_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_stability_screen_shifter.dart';

class FinancialStabilityDetailPicker
    extends GetView<FinancialProfileController> {
  const FinancialStabilityDetailPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.detailsScrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: [
          const SizedBox(width: 16),
          ...controller.stabilityProfileDetails.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return FinancialStabilityScreenShifter(
              key: controller.stabilityDetailKeys[index],
              title: item.title,
              index: index,
            );
          }),

          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
