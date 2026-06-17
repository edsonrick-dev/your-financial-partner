import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/main_shell/controller/main_shell_controller.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainShell extends GetView<MainShellController> {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    return Obx(() {
      final tabIndex = controller.selectedTabIndex.value;
      return Scaffold(
        // backgroundColor: colorScheme.appSurface,
        // appBar: AppBar(title: Text(controller.currentTitle)),
        body: IndexedStack(index: tabIndex, children: controller.pages),

        bottomNavigationBar: AppBottomNav(controller: controller),
      );
    });
  }
}

class AppBottomNav extends StatelessWidget {
  final MainShellController controller;
  const AppBottomNav({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final tabIndex = controller.selectedTabIndex.value;
    return SafeArea(
      top: false,
      child: Row(
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
            label: 'Planners',
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
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final activeColor = colorScheme.appText;
    final inactiveColor = colorScheme.appTextMuted;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: SizedBox(
            height: 44,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isActive ? activeColor : inactiveColor,
                ),

                // const SizedBox(height: 2),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isActive ? 1 : 0,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      height: 16 / 11,
                      fontWeight: FontWeight.w600,
                      color: activeColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // InkWell(
      //   onTap: onTap,
      //   borderRadius: BorderRadius.circular(12),
      //   child: SizedBox(
      //     height: 44,
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Icon(
      //           icon,
      //           size: 20,
      //           color: isActive ? activeColor : inactiveColor,
      //         ),

      // const SizedBox(height: 2),

      // AnimatedOpacity(
      //   duration: const Duration(milliseconds: 150),
      //   opacity: isActive ? 1 : 0,
      //   child: Text(
      //     label,
      //     style: TextStyle(
      //       fontSize: 10,
      //       fontWeight: FontWeight.w600,
      //       color: activeColor,
      //     ),
      //   ),
      // ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isOpen;
  const AddButton({super.key, required this.onTap, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF0F172A),
          ),
          child: AnimatedRotation(
            turns: isOpen ? 0.125 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
