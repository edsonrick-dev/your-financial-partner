import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

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
    );
  }
}
