import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PortfolioEmptyView extends StatelessWidget {
  const PortfolioEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            PhosphorIconsRegular.chartLine,
            size: 60,
            color: colorScheme.appAccent,
          ),

          const SizedBox(height: 8),

          Text(
            'Your investment portfolio',
            style: AppTextStyle.headlineM,
            textAlign: TextAlign.center,
          ),

          Text(
            'See how your investments align with your investor profile.',

            style: AppTextStyle.headlineS,
            textAlign: TextAlign.center,
          ),

          Text(
            'See how much to invest this year and how to allocate it across asset classes based on your goals and investor profile.',
            style: AppTextStyle.bodyM.copyWith(color: colorScheme.appTextMuted),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          AppButton(
            type: ButtonType.outline,
            text: 'Add Investments',
            onTap: () {
              // Open GoalSetupSheet
            },
          ),
        ],
      ),
    );
  }
}
