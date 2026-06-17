import 'package:flutter/material.dart';
import 'package:getx_drift_app/data/enums/field_states.dart';

class FieldColors {
  static const Color background = Colors.white;
  static Color border(FieldState state) {
    switch (state) {
      case FieldState.error:
        return Colors.red;

      case FieldState.success:
        return Colors.green;

      case FieldState.filled:
        return const Color(0xFF1C1C29);

      case FieldState.empty:
        return const Color(0xFFCAC3BB);

      case FieldState.disabled:
        return const Color(0xFFE0E0E0);
    }
  }

  static Color text(FieldState state) {
    switch (state) {
      case FieldState.error:
        return Colors.red;

      case FieldState.success:
        return Colors.green;

      case FieldState.filled:
        return const Color(0xFF1C1C29);

      case FieldState.empty:
        return const Color(0xFF84746B);

      case FieldState.disabled:
        return const Color(0xFFB0B0B0);
    }
  }

  static Color label(FieldState state) {
    switch (state) {
      case FieldState.disabled:
        return const Color(0xFFB0B0B0);

      default:
        return const Color(0xFF1C1C29);
    }
  }

  static Color icon(FieldState state) {
    switch (state) {
      case FieldState.disabled:
        return const Color(0xFFB0B0B0);

      default:
        return const Color(0xFF1C1C29);
    }
  }
}
