import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_setup/financial_setup_controller.dart';
import 'package:getx_drift_app/features/financial_setup/financial_setup_criterion.dart';
import 'package:getx_drift_app/features/home/views/home_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FinancialSetupGuide {
  FinancialSetupGuide({
    required this.criterion,
    required this.title,
    required this.description,
    required this.icon,
    required this.actionLabel,
    required this.onAction,
  });

  final FinancialSetupCriterion criterion;

  final String title;
  final String description;
  final IconData icon;

  final String actionLabel;
  final VoidCallback onAction;
}

class GuideCard extends StatelessWidget {
  const GuideCard({super.key, required this.guide});

  final FinancialSetupGuide guide;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    // render
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.elevated(colorScheme.appText),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(24),
            child: Row(
              spacing: 20,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('RECOMMENDED'),
                      Text(guide.title, style: AppTextStyle.headlineM),
                      Text(guide.description, style: AppTextStyle.bodyM),
                    ],
                  ),
                ),

                Icon(
                  guide.icon,
                  size: 120,
                  color: colorScheme.appAccent.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(bottom: 16, left: 16, right: 16),
            child: Column(
              children: [
                AppButton(text: guide.actionLabel, onTap: guide.onAction),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
