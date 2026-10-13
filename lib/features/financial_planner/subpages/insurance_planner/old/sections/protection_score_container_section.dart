import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/enums/protection_profile_enum.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class ProtectionScoreContainerSection extends StatelessWidget {
  final ProtectionProfile profile;
  final int unmetGoals;
  // final bool isComplete;
  final ProtectionAssessmentStatus status;
  const ProtectionScoreContainerSection({
    super.key,
    required this.profile,
    required this.unmetGoals,
    required this.status,
    // required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppGradient.gradientA(colorScheme),
          borderRadius: BorderRadius.circular(24),
        ),
        child: switch (status) {
          ProtectionAssessmentStatus.notStarted => _buildStatusContent(
            context,
            title: status.title,
            description: status.description,
          ),
          ProtectionAssessmentStatus.inProgress => _buildStatusContent(
            context,
            title: status.title,
            description: status.description,
          ),
          ProtectionAssessmentStatus.completed => _buildProtectionScore(
            context,
          ),
        },
      ),
    );
  }

  Widget _buildStatusContent(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          title,
          style: AppTextStyle.titleL.copyWith(
            color: context.colors.appInversedtext,
          ),
        ),
        Text(
          description,
          style: AppTextStyle.bodyL.copyWith(
            color: context.colors.appInversedtext,
          ),
        ),
      ],
    );
  }

  Widget _buildProtectionScore(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          'Protection Score',
          style: AppTextStyle.titleL.copyWith(
            color: context.colors.appInversedtextMuted,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                profile.title,
                style: AppTextStyle.displayL.copyWith(
                  color: context.colors.appInversedtext,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$unmetGoals of 3 protection goals are not yet met.',
              style: AppTextStyle.labelM.copyWith(
                color: context.colors.appInversedtext,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

enum ProtectionAssessmentStatus { notStarted, inProgress, completed }

extension ProtectionAssessmentStatusX on ProtectionAssessmentStatus {
  String get title => switch (this) {
    ProtectionAssessmentStatus.notStarted => 'Assess Your Protection Needs',
    ProtectionAssessmentStatus.inProgress => 'Protection Assessment Incomplete',
    ProtectionAssessmentStatus.completed => 'Protection Assessment Complete',
  };

  String get description => switch (this) {
    ProtectionAssessmentStatus.notStarted =>
      'Calculate how much financial protection you may need.',
    ProtectionAssessmentStatus.inProgress =>
      'Complete your remaining assessments to see your overall protection needs.',
    ProtectionAssessmentStatus.completed =>
      'Review your coverage and identify any protection gaps.',
  };
}
