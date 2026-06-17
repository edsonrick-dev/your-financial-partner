import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/field_themes/field_color.dart';
import 'package:getx_drift_app/data/enums/field_states.dart';

class AppFieldContainer extends StatelessWidget {
  final Widget child;
  final FieldState? state;
  final String? value;
  final VoidCallback onTap;
  final double trailingPadding;
  const AppFieldContainer({
    super.key,
    required this.child,
    required this.onTap,
    this.trailingPadding = 4,
    this.state,
    this.value,
  });

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
    final borderColor = FieldColors.border(effectiveState);

    return Opacity(
      opacity: isDisabled ? 0.6 : 1,
      child: IgnorePointer(
        ignoring: isDisabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 12,
                  right: trailingPadding,
                ),

                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor, width: 1),
                  color: FieldColors.background,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
