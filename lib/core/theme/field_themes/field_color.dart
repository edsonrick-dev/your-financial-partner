import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/field_states.dart';

class FieldColors {
  static const Color background = Colors.white;
  static Color border(FieldState state, BuildContext context) {
    switch (state) {
      case FieldState.error:
        return Colors.red;

      case FieldState.success:
        return Colors.green;

      case FieldState.filled:
        return context.colors.filledBorder;

      case FieldState.empty:
        return context.colors.emptyBorder;

      case FieldState.disabled:
        return const Color(0xFFE0E0E0);
    }
  }

  static Color text(FieldState state, BuildContext context) {
    switch (state) {
      case FieldState.error:
        return Colors.red;

      case FieldState.success:
        return Colors.green;

      case FieldState.filled:
        return context.colors.appText;

      case FieldState.empty:
        return context.colors.appTextMuted;

      case FieldState.disabled:
        return const Color(0xFFB0B0B0);
    }
  }

  static Color label(FieldState state, BuildContext context) {
    switch (state) {
      case FieldState.disabled:
        return const Color(0xFFB0B0B0);

      default:
        return context.colors.appText;
    }
  }

  static Color icon(FieldState state, BuildContext context) {
    switch (state) {
      case FieldState.disabled:
        return const Color(0xFFB0B0B0);

      default:
        return context.colors.appText;
    }
  }
}
