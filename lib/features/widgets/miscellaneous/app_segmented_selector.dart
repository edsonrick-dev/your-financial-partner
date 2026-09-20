import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppSegmentedSelector extends StatelessWidget {
  const AppSegmentedSelector({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: colorScheme.pageShifterFillUnselected,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colorScheme.appBorderMuted),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / items.length;

          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                left: selectedIndex * itemWidth,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.pageShifterFillSelected,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),

              Row(
                children: List.generate(items.length, (index) {
                  final isSelected = selectedIndex == index;

                  return Expanded(
                    child: AdaptivePressable(
                      onTap: () => onChanged(index),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 180),
                          style: AppTextStyle.titleL.copyWith(
                            color: isSelected
                                ? colorScheme.pageShifterTextSelected
                                : colorScheme.pageShifterTextUnselected,
                          ),
                          child: Text(items[index]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
