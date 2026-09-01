import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';

class FinancialPlannerEmptySection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? actionText;
  final VoidCallback? onTap;
  const FinancialPlannerEmptySection({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradient.gradientA(colorScheme),
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.floating(colorScheme.appText),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Icon(icon, size: 56, color: colorScheme.appAccent),

                const SizedBox(height: 20),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.headlineL.copyWith(
                    color: colorScheme.appInversedtext,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodyL.copyWith(
                    color: colorScheme.appInversedtextMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (actionText != null)
                  AppButton(
                    text: actionText ?? '',
                    onTap: onTap,
                    isInversed: true,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
