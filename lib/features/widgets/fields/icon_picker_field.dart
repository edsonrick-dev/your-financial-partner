import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/widgets/fields/shared/field_container.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/core/theme/field_themes/field_color.dart';
import 'package:getx_drift_app/data/enums/field_states.dart';

class AppIconPickerField extends StatelessWidget {
  const AppIconPickerField({
    super.key,
    required this.onTap,

    this.iconKey,
    this.state,

    this.errorText,
    this.successText,
  });

  final String? iconKey;

  final VoidCallback onTap;

  final FieldState? state;

  final String? errorText;
  final String? successText;

  bool get isFilled => iconKey != null && iconKey!.isNotEmpty;

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
    // final borderColor = FieldColors.border(effectiveState, context);

    final iconColor = FieldColors.icon(effectiveState, context);

    return Column(
      children: [
        AppFieldContainer(
          // padding: 0,
          trailingPadding: 12,
          fixedWidth: true,
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Icon', style: AppTextStyle.titleM),
                  Center(
                    child: Icon(
                      isFilled
                          ? AppIcons.categories.resolve(iconKey!)
                          : Icons.image_outlined,

                      size: 24,

                      color: iconColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
    );
  }
}

class AppIconPickerFieldTest extends StatelessWidget {
  final VoidCallback onTap;
  final String? iconKey;
  const AppIconPickerFieldTest({super.key, required this.onTap, this.iconKey});

  bool get isFilled => iconKey != null && iconKey!.isNotEmpty;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppFieldContainer(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Icon',
            style: TextStyle(
              fontSize: 13,
              height: 16 / 13,
              color: colorScheme.appAccent,
            ),
          ),
          Center(
            child: Icon(
              isFilled
                  ? AppIcons.categories.resolve(iconKey!)
                  : Icons.image_outlined,

              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
