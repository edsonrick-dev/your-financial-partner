import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/controller/protection_questionnaire_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/3_lifestyle_continuity_questionnaire/widgets/lifestyle_continuity_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class ExpenseContinuityBudgetCard
    extends GetView<ProtectionQuestionnaireController> {
  const ExpenseContinuityBudgetCard({
    super.key,
    required this.plan,
    required this.type,
    required this.continuityShare,
    required this.onShareChanged,
  });

  final SavedCashflowPlanData plan;
  final ProtectionType type;
  final double continuityShare;
  final ValueChanged<double> onShareChanged;

  @override
  Widget build(BuildContext context) {
    final annualAmount = plan.budgetPeriod.toAnnual(plan.amount);
    final continuityAmount = annualAmount * continuityShare;
    final monthlyAmount = continuityAmount / 12;
    final colorScheme = context.colors;

    return AppCard(
      onTap: () {
        Get.bottomSheet(
          LifestyleContinuitySheet(
            plan: plan,
            type: type,
            continuityShare: continuityShare,
            onShareChanged: (share) async {
              await controller.updateContinuityShare(
                planId: plan.planId,
                protectionType: type,
                share: share,
              );
            },
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
                  Text(
                    continuityAmount.toCurrency(),
                    style: AppTextStyle.amountL,
                  ),
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
        ],
      ),
    );
  }
}
