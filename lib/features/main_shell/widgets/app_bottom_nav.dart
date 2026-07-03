import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/main_shell/controller/main_shell_controller.dart';
import 'package:getx_drift_app/features/main_shell/widgets/add_button.dart';
import 'package:getx_drift_app/features/main_shell/widgets/nav_item.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppBottomNav extends StatelessWidget {
  final MainShellController controller;
  const AppBottomNav({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final tabIndex = controller.selectedTabIndex.value;
    return SafeArea(
      // top: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
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

            Obx(() {
              return AddButton(
                isOpen: controller.isAddSheetOpen.value,
                onTap: controller.isAddSheetOpen.value
                    ? Get.back
                    : controller.openAddTransaction,
              );
            }),

            NavItem(
              icon: tabIndex == 2
                  ? PhosphorIconsFill.gridFour
                  : PhosphorIconsRegular.gridFour,
              label: 'Account',
              isActive: tabIndex == 2,
              onTap: () => controller.changeTab(2),
            ),

            NavItem(
              icon: tabIndex == 3
                  ? PhosphorIconsFill.gear
                  : PhosphorIconsRegular.gear,
              label: 'Settings',
              isActive: tabIndex == 3,
              onTap: () => controller.changeTab(3),
            ),
          ],
        ),
      ),
    );
  }
}
