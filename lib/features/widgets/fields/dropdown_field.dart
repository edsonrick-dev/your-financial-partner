import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/features/widgets/fields/shared/field_container.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/field_themes/field_color.dart';
import 'package:getx_drift_app/data/enums/field_states.dart';

class AppDropdownField extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,

    this.defaultIcon,
    this.hint = 'Select',
    this.showIcon = true,
    this.iconKey = '',
    this.state,
    this.errorText,
    this.successText,
  });

  final String label;
  final String? value;
  final String hint;
  final String? iconKey;
  final bool showIcon;
  final VoidCallback onTap;

  final FieldState? state;
  final Icon? defaultIcon;
  final String? errorText;
  final String? successText;

  bool get isFilled => value != null && value!.isNotEmpty;
  bool get isDisabled => effectiveState == FieldState.disabled;
  FieldState get effectiveState {
    if (state != null) return state!;

    if (isFilled) {
      return FieldState.filled;
    }

    return FieldState.empty;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = FieldColors.text(effectiveState);

    return AdaptivePressable(
      child: AppFieldContainer(
        state: effectiveState,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        label,

                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,

                          height: 16 / 13,

                          color: FieldColors.label(effectiveState),
                        ),
                      ),

                      Text(
                        isFilled ? value! : hint,

                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                          fontWeight: isFilled
                              ? FontWeight.w600
                              : FontWeight.w400,
                          height: 24 / 16,
                        ),
                      ),
                    ],
                  ),
                ),
                if (showIcon == true)
                  SizedBox(
                    width: 28,
                    height: 44,

                    child: Row(
                      children: [
                        defaultIcon ??
                            Icon(
                              AppIcons.categories.resolve(iconKey!),
                              size: 18,
                              color: FieldColors.icon(effectiveState),
                            ),
                      ],
                    ),
                  ),
              ],
            ),

            if (state == FieldState.error && errorText != null) ...[
              const SizedBox(height: 6),

              Text(
                errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],

            if (state == FieldState.success && successText != null) ...[
              const SizedBox(height: 6),

              Text(
                successText!,
                style: const TextStyle(color: Colors.green, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
