import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

enum InsuranceAssessmentState { notStarted, started, finished }

class InsuranceAssessmentCard extends StatelessWidget {
  const InsuranceAssessmentCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.state = InsuranceAssessmentState.notStarted,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String description;
  final InsuranceAssessmentState state;
  final VoidCallback? onTap;
  String _ctaText(BuildContext context) {
    return switch (state) {
      InsuranceAssessmentState.notStarted => 'Start Assessment',
      InsuranceAssessmentState.started => 'Continue Assessment',
      InsuranceAssessmentState.finished => 'Review Assessment',
    };
  }

  String _promptText(BuildContext context) {
    return switch (state) {
      InsuranceAssessmentState.notStarted => 'Not Started',
      InsuranceAssessmentState.started => 'Started',
      InsuranceAssessmentState.finished => 'Finished',
    };
  }

  Color _promptColor(BuildContext context) {
    final colorScheme = context.colors;
    return switch (state) {
      InsuranceAssessmentState.notStarted => colorScheme.appNeutral,
      InsuranceAssessmentState.started => colorScheme.appAccent,
      InsuranceAssessmentState.finished => colorScheme.appInflow,
    };
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              SizedBox(width: 12),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 28),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: AppTextStyle.titleL,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _promptColor(context).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(_promptText(context), style: AppTextStyle.labelM),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(description, style: AppTextStyle.bodyM),
          SizedBox(height: 12),
          Row(
            children: [
              Spacer(),
              Text(
                _ctaText(context),
                style: AppTextStyle.titleM,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
