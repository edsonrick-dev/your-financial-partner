import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';

class BillsFrequencySelector extends StatelessWidget {
  const BillsFrequencySelector({
    required this.period,
    required this.isSelected,
    this.onTap,
    super.key,
  });

  final BillsFrequency period;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Expanded(
      child: AdaptivePressable(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          onTap?.call();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.ease,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.pageShifterFillSelected
                : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                period.initials,
                maxLines: 1,
                style: isSelected
                    ? AppTextStyle.titleM.copyWith(
                        color: colorScheme.pageShifterTextSelected,
                        // fontWeight: FontWeight.w600,
                      )
                    : AppTextStyle.bodyM.copyWith(
                        color: colorScheme.pageShifterTextUnselected,
                        // fontWeight: FontWeight.w400,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
