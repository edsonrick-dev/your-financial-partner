import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/organize_THIS/app_mode_item.dart';

class ModeShifter extends StatelessWidget {
  const ModeShifter({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
    this.isFullWidth = true,
  });

  final ModeItem item;
  final bool selected;
  final VoidCallback onTap;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: AnimatedContainer(
        // height: 44,
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.pageShifterFillSelected
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6,
              children: [
                Icon(
                  selected ? item.selectedIcon : item.unselectedIcon,
                  size: 24,
                  color: selected ? colorScheme.bg : colorScheme.appTextMuted,
                ),

                if (isFullWidth)
                  Expanded(
                    child: item.title != null
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                item.title!,
                                style: AppTextStyle.titleM.copyWith(
                                  color: selected
                                      ? colorScheme.bg
                                      : colorScheme.appText,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  )
                else if (item.title != null)
                  Text(
                    item.title!,
                    style: AppTextStyle.titleM.copyWith(
                      color: selected ? colorScheme.bg : colorScheme.appText,
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
