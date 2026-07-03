import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/main_shell/controller/main_shell_controller.dart';
import 'package:getx_drift_app/features/main_shell/widgets/app_bottom_nav.dart';

class MainShell extends GetView<MainShellController> {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tabIndex = controller.selectedTabIndex.value;
      return Scaffold(
        body: IndexedStack(index: tabIndex, children: controller.pages),

        bottomNavigationBar: AppBottomNav(controller: controller),
      );
    });
  }
}
