import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/profile_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class FinancialStabilityDetailsSheet extends GetView<ProfileController> {
  const FinancialStabilityDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Financial Stability Details',
      child: Column(
        children: [
          SingleChildScrollView(
            controller: controller.detailsScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              children: [
                const SizedBox(width: 16),

                // ...controller.stabilityProfileDetails.asMap().entries.map((
                //   entry,
                // ) {
                //   final index = entry.key;
                //   final item = entry.value;

                //   return FinancialStabilityScreenShifter(
                //     title: item.title,
                //     index: index,
                //   );
                // }),
                ...controller.stabilityProfileDetails.asMap().entries.map((
                  entry,
                ) {
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
          ),

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
          // Expanded(
          //   child: Obx(
          //     () => IndexedStack(
          //       index: controller.selectedDetailsIndex.value,
          //       children: controller.stabilityProfileDetails
          //           .map((e) => e.page)
          //           .toList(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class FinancialStabilityScreenShifter extends GetView<ProfileController> {
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
        child: GestureDetector(
          onTap: () {
            controller.selectTab(index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: colorScheme.text,
                width: isSelected ? 0.5 : 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                color: colorScheme.text,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                // fontSize: 1,
              ),
            ),
          ),
        ),
      );
    });
  }
}
