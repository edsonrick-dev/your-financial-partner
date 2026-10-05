import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum GoalType {
  emergencyFund,
  retirement,
  education,
  general;

  static GoalType fromName(String name) {
    return GoalType.values.firstWhere(
      (type) => type.name == name,
      orElse: () => GoalType.general,
    );
  }
}

extension GoalTypeExtension on GoalType {
  String get title {
    return switch (this) {
      GoalType.emergencyFund => 'Emergency Fund',
      GoalType.retirement => 'Retirement',
      GoalType.education => 'Education',
      GoalType.general => 'Other Goal',
    };
  }

  String get shortDescription {
    return switch (this) {
      GoalType.emergencyFund =>
        'Build a financial buffer for unexpected expenses and income disruptions.',

      GoalType.retirement =>
        'Build long-term wealth to support your desired lifestyle in retirement.',

      GoalType.education =>
        'Plan for future education expenses for yourself or someone you support.',

      GoalType.general =>
        'Create a custom goal for something important to you.',
    };
  }

  String get description {
    return switch (this) {
      GoalType.emergencyFund =>
        'An emergency fund helps you cover '
            'essential expenses when your income '
            'is disrupted or an unexpected expense occurs.',

      GoalType.retirement =>
        'A retirement plan helps you build '
            'enough wealth to support your desired '
            'lifestyle when you stop working.',

      GoalType.education =>
        'Plan for future education expenses for yourself or someone you support.',

      GoalType.general =>
        'Create a custom goal for something important to you.',
    };
  }

  IconData get icon {
    return switch (this) {
      GoalType.emergencyFund => PhosphorIconsRegular.shieldPlus,
      GoalType.retirement => PhosphorIconsRegular.sun,
      GoalType.education => PhosphorIconsRegular.graduationCap,
      GoalType.general => PhosphorIconsRegular.target,
    };
  }
}
