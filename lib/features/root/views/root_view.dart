import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,

          children: const [
            Center(child: Text('Home')),
            Center(child: Text('Transactions')),
            Center(child: Text('Budget')),
            Center(child: Text('Net Worth')),
            Center(child: Text('Profile')),
          ],
        ),

        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
        ),
      );
    });
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          height: 72,

          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(24),

            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                offset: const Offset(0, 4),
                color: Colors.black.withAlpha(20),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              _NavItem(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: 'Home',
                selected: currentIndex == 0,
                onTap: () => onTap(0),
              ),

              _NavItem(
                icon: Icons.receipt_long_outlined,
                selectedIcon: Icons.receipt_long,
                label: 'Transactions',
                selected: currentIndex == 1,
                onTap: () => onTap(1),
              ),

              _NavItem(
                icon: Icons.pie_chart_outline,
                selectedIcon: Icons.pie_chart,
                label: 'Budget',
                selected: currentIndex == 2,
                onTap: () => onTap(2),
              ),

              _NavItem(
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'Profile',
                selected: currentIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        decoration: BoxDecoration(
          color: selected ? colors.primary.withAlpha(20) : Colors.transparent,

          borderRadius: BorderRadius.circular(16),
        ),

        child: Row(
          children: [
            Icon(
              selected ? selectedIcon : icon,
              color: selected ? colors.primary : colors.onSurfaceVariant,
            ),

            if (selected) ...[
              const SizedBox(width: 8),

              Text(
                label,
                style: TextStyle(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
