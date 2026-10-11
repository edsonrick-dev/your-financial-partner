import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

enum DisplayMode { grid, list }

class DisplayModeToggle extends StatelessWidget {
  const DisplayModeToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final DisplayMode value;
  final ValueChanged<DisplayMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.appBorderMuted),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: _ModeButton(
                regularIcon: PhosphorIconsRegular.list,
                fillIcon: PhosphorIconsFill.list,
                selected: value == DisplayMode.list,
                onTap: () => onChanged(DisplayMode.list),
                name: 'List',
              ),
            ),
            Expanded(
              child: _ModeButton(
                regularIcon: PhosphorIconsRegular.squaresFour,
                fillIcon: PhosphorIconsFill.squaresFour,
                selected: value == DisplayMode.grid,
                onTap: () => onChanged(DisplayMode.grid),
                name: 'Grid',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.regularIcon,
    required this.fillIcon,
    required this.selected,
    required this.onTap,
    this.name,
  });

  final IconData regularIcon;
  final IconData fillIcon;
  final bool selected;
  final VoidCallback onTap;
  final String? name;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.pageShifterFillSelected
              : colorScheme.pageShifterFillUnselected,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            Icon(
              selected ? fillIcon : regularIcon,
              size: 20,
              color: selected
                  ? colorScheme.pageShifterTextSelected
                  : colorScheme.pageShifterTextUnselected,
            ),

            if (name != null)
              Text(
                name!,
                style: AppTextStyle.titleM.copyWith(
                  color: selected
                      ? colorScheme.pageShifterTextSelected
                      : colorScheme.pageShifterTextUnselected,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
