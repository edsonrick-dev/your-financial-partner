import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/widgets/financial_planner_picker.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FinancialPlannerScreen extends GetView<FinancialPlannerController> {
  const FinancialPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tabIndex = controller.selectedTabIndex.value;
      return Scaffold(
        appBar: AppBar(
          title: Text('Financial Planner', style: AppTextStyle.headlineL),
          actions: [
            AdaptivePressable(
              onTap: () {
                Get.bottomSheet(
                  isScrollControlled: true,
                  AppSheet(
                    height: AppSheetHeight.full,
                    title: 'Ascend Learning Library',
                    child: SingleChildScrollView(
                      child: AppSection(
                        child: Column(
                          spacing: 16,
                          children: [
                            Icon(PhosphorIconsRegular.bookOpenText, size: 60),
                            Text(
                              'This sheet will house future contents of Ascend that beset suit your profile.',
                              style: AppTextStyle.bodyL,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'You will be notified once this page is up.',
                              style: AppTextStyle.labelM.copyWith(
                                color: context.colors.appTextMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: 44,
                height: 44,
                child: Icon(PhosphorIconsRegular.bookOpenText),
              ),
            ),
            SizedBox(width: 8),
          ],
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FinancialPlannerPicker(),
              // SizedBox(height: 4),
              Expanded(
                child: IndexedStack(
                  index: tabIndex,
                  children: controller.financialPlannerPages
                      .map((e) => e.page)
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
