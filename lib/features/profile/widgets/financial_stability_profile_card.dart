import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_stability_profile_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_stability_guage.dart';

class FinancialStabilityProfileCard
    extends GetView<FinancialProfileController> {
  const FinancialStabilityProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: () {
        AppSheets.viewStabilityProfileDetails(null);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 20, 16),
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(24),
          boxShadow: AppShadows.card(colorScheme.appText),
        ),
        child: Obx(() {
          final isAssessed = controller.hasCompleteFinancialStabilityProfile;

          if (!isAssessed) {
            return _UnassessedView();
          }

          return _AssessedView(controller: controller);
        }),
      ),
    );
  }
}

class _AssessedView extends StatelessWidget {
  const _AssessedView({required this.controller});

  final FinancialProfileController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FinancialStabilityGauge(
          score: controller.financialScore,
          colorScheme: colorScheme,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.stability.title,
                style: AppTextStyle.headlineM.copyWith(
                  color: colorScheme.appText,
                ),
              ),

              Text(
                controller.stability.shortDescription,
                style: AppTextStyle.bodyM.copyWith(color: colorScheme.appText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UnassessedView extends StatelessWidget {
  const _UnassessedView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.appTextMuted.withValues(alpha: 0.10),
          ),
          child: Icon(
            Icons.analytics_outlined,
            color: colorScheme.appTextMuted,
            size: 28,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Financial Stability',
                style: AppTextStyle.headlineM.copyWith(
                  color: colorScheme.appText,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                'Complete your financial profile to see your stability score.',
                style: AppTextStyle.bodyM.copyWith(
                  color: colorScheme.appTextMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
