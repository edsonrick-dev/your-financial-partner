import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FinancialStabilityProfileEmptyState
    extends GetView<FinancialProfileController> {
  final bool hasNetWorthPlan;
  final bool hasIncomePlan;
  final bool hasBudgetPlan;
  final bool hasAssessment;
  final VoidCallback onAction;

  const FinancialStabilityProfileEmptyState({
    super.key,
    required this.hasNetWorthPlan,
    required this.hasIncomePlan,
    required this.hasBudgetPlan,
    required this.hasAssessment,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final isProfileComplete =
        hasNetWorthPlan && hasIncomePlan && hasBudgetPlan && hasAssessment;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Icon(
            PhosphorIconsRegular.userCircle,
            size: 64,
            color: colorScheme.appAccent,
          ),

          const SizedBox(height: 16),

          Text(
            "Ascend's\nFinancial Stability Profile",
            style: AppTextStyle.headlineL,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            'Understand your financial position beyond a single number.',
            style: AppTextStyle.headlineS,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.bgLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Complete your profile', style: AppTextStyle.titleM),

                const SizedBox(height: 16),

                _ProfileRequirement(
                  title: 'Net Worth Plan',
                  description: 'Record what you own and what you owe.',
                  isComplete: hasNetWorthPlan,
                ),

                const SizedBox(height: 16),

                _ProfileRequirement(
                  title: 'Income Plan',
                  description: 'Plan how much money comes in.',
                  isComplete: hasIncomePlan,
                ),

                const SizedBox(height: 16),

                _ProfileRequirement(
                  title: 'Budget Plan',
                  description: 'Plan where your money goes.',
                  isComplete: hasBudgetPlan,
                ),

                const SizedBox(height: 16),

                _ProfileRequirement(
                  title: "Financial Profile Assessment",
                  description:
                      'Tell us about how you manage and think about your finances.',
                  isComplete: hasAssessment,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          AppButton(
            onTap: onAction,
            trailingIcon: PhosphorIconsRegular.arrowRight,
            text: isProfileComplete
                ? 'View Financial Stability Profile'
                : !hasNetWorthPlan
                ? 'Complete net worth plan'
                : !hasIncomePlan
                ? 'Build income plan'
                : !hasBudgetPlan
                ? 'Build budget plan'
                : "Take Ascend's Assessment",
          ),

          const SizedBox(height: 12),

          Text(
            'Your Financial Stability Profile appears once everything is complete.',
            style: AppTextStyle.bodyS.copyWith(color: colorScheme.appTextMuted),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: context.bottomPadding),
        ],
      ),
    );
  }
}

class _ProfileRequirement extends StatelessWidget {
  final String title;
  final String description;
  final bool isComplete;

  const _ProfileRequirement({
    required this.title,
    required this.description,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isComplete
              ? PhosphorIconsFill.checkCircle
              : PhosphorIconsRegular.circle,
          size: 24,
          color: isComplete ? colorScheme.appInflow : colorScheme.appTextMuted,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.titleM),

              const SizedBox(height: 2),

              Text(
                description,
                style: AppTextStyle.bodyS.copyWith(color: colorScheme.appText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
