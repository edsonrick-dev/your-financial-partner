import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/features/profile/controller/profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_stability_detail_picker.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class FinancialStabilitySheetShell extends GetView<ProfileController> {
  const FinancialStabilitySheetShell({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Financial Stability Details',
      child: Column(
        children: [
          FinancialStabilityDetailPicker(),

          Expanded(
            child: Obx(() {
              final pages = controller.stabilityProfileDetails
                  .map((e) => e.page)
                  .toList();

              final index = controller.selectedDetailsIndex.value;

              debugPrint('INDEX = $index');
              debugPrint('PAGES = ${pages.length}');

              return IndexedStack(index: index, children: pages);
            }),
          ),
        ],
      ),
    );
  }
}
