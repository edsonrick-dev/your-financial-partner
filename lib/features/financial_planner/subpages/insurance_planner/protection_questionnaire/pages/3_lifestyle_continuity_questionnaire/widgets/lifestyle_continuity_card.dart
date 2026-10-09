import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/3_lifestyle_continuity_questionnaire/widgets/lifestyle_continuity_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class LifestyleContinuityCard extends StatelessWidget {
  const LifestyleContinuityCard({
    super.key,
    required this.plan,
    required this.continuityShares,
    required this.onSharesChanged,
  });

  final SavedCashflowPlanData plan;

  final Map<ProtectionType, double> continuityShares;

  final ValueChanged<Map<ProtectionType, double>> onSharesChanged;

  @override
  Widget build(BuildContext context) {
    final annualAmount = plan.budgetPeriod.toAnnual(plan.amount);
    final monthlyAmount = annualAmount / 12;
    final colorScheme = context.colors;
    return AppCard(
      onTap: () {
        Get.bottomSheet(
          LifestyleContinuitySheet(
            plan: plan,
            continuityShares: continuityShares,
            onSharesChanged: onSharesChanged,
          ),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(AppIcons.categories.resolve(plan.iconKey), size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plan.category, style: AppTextStyle.titleL),
                    Text(
                      'Tap card to adjust',
                      style: AppTextStyle.bodyS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(annualAmount.toCurrency(), style: AppTextStyle.amountL),
                  Text(
                    '${monthlyAmount.toCurrency()}/mo',
                    style: AppTextStyle.bodyS.copyWith(
                      color: colorScheme.appTextMuted,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),

              // Icon(Icons.tune, color: colors.appTextMuted),
            ],
          ),
          const SizedBox(height: 16),
          for (final type in ProtectionType.values) ...[
            _ShareSummary(
              label: type.label,
              share: continuityShares[type] ?? 1.0,
              color: type.color,
              annualAmount: annualAmount,
            ),
            if (type != ProtectionType.values.last) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _ShareSummary extends StatelessWidget {
  const _ShareSummary({
    required this.label,
    required this.share,
    required this.color,
    required this.annualAmount,
  });

  final String label;
  final double share;
  final Color color;
  final double annualAmount;
  @override
  Widget build(BuildContext context) {
    final percentage = (share * 100).round();
    final continuedAmount = annualAmount * share;
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Row(
            spacing: 4,
            children: [
              Text(label, style: AppTextStyle.bodyM),
              Text('•', style: AppTextStyle.bodyM),
              Text('$percentage%', style: AppTextStyle.amountS),
            ],
          ),
        ),
        Text(continuedAmount.toCurrency(), style: AppTextStyle.amountM),
      ],
    );
  }
}
