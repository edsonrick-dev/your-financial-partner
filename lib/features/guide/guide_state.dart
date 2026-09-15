import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum GuideState {
  available,
  locked,
  completed;

  String get statusLabel => switch (this) {
    GuideState.available => 'In Progress',
    GuideState.locked => 'Locked',
    GuideState.completed => 'Completed',
  };
  IconData get statusIcon => switch (this) {
    GuideState.available => PhosphorIconsRegular.caretRight,
    GuideState.locked => PhosphorIconsFill.lock,
    GuideState.completed => PhosphorIconsRegular.check,
  };

  Color statusColor(BuildContext context) {
    final colorScheme = context.colors;

    return switch (this) {
      GuideState.available => colorScheme.appText,
      GuideState.locked => colorScheme.appOutflow,
      GuideState.completed => colorScheme.appInflow,
    };
  }

  bool get isLocked => this == GuideState.locked;

  bool get isCompleted => this == GuideState.completed;
}
