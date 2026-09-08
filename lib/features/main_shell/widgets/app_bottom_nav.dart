import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/main_shell/controller/main_shell_controller.dart';
import 'package:getx_drift_app/features/main_shell/widgets/add_button.dart';
import 'package:getx_drift_app/features/main_shell/widgets/nav_item.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppBottomNav extends StatelessWidget {
  final MainShellController controller;
  const AppBottomNav({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final tabIndex = controller.selectedTabIndex.value;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
        child: Row(
          children: [
            Expanded(
              child: Material(
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                // color: Colors.transparent,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.bgLight,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: colorScheme.appBorder),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      NavItem(
                        icon: tabIndex == 0
                            ? PhosphorIconsFill.houseLine
                            : PhosphorIconsRegular.houseLine,
                        label: 'Home',
                        isActive: tabIndex == 0,
                        onTap: () => controller.changeTab(0),
                      ),

                      NavItem(
                        icon: tabIndex == 1
                            ? PhosphorIconsFill.calendarBlank
                            : PhosphorIconsRegular.calendarBlank,
                        label: 'Transactions',
                        isActive: tabIndex == 1,
                        onTap: () => controller.changeTab(1),
                      ),

                      NavItem(
                        icon: tabIndex == 2
                            ? PhosphorIconsFill.gridFour
                            : PhosphorIconsRegular.gridFour,
                        label: 'Planner',
                        isActive: tabIndex == 2,
                        onTap: () => controller.changeTab(2),
                      ),

                      NavItem(
                        icon: tabIndex == 3
                            ? PhosphorIconsFill.user
                            : PhosphorIconsRegular.user,
                        label: 'Profile',
                        isActive: tabIndex == 3,
                        onTap: () => controller.changeTab(3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Obx(() {
              return AddButton(
                isOpen: controller.isAddSheetOpen.value,
                onTap: controller.isAddSheetOpen.value
                    ? Get.back
                    : controller.openAddTransaction,
              );
            }),
          ],
        ),
      ),
    );
  }
}
