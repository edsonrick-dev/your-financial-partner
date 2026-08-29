import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';

class CashflowPlanCard extends GetView<CashflowController> {
  final BudgetPeriod budgetPeriod;
  final String category;
  final double amount;
  final String iconKey;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final bool isCustom;
  final String? customSummary;
  final Color? color;
  const CashflowPlanCard({
    super.key,
    required this.budgetPeriod,
    required this.category,
    required this.amount,
    required this.iconKey,
    required this.isCustom,
    this.color,
    this.customSummary,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final annualAmount = budgetPeriod.toAnnual(amount);

    final periodLabel = isCustom
        ? 'Custom ${budgetPeriod.label} Budget'
        : '${budgetPeriod.label} Budget';

    return AdaptivePressable(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        constraints: BoxConstraints(minHeight: 60),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  AppIcons.categories.resolve(iconKey),
                  color: color ?? colorScheme.appText,
                ),
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color ?? colorScheme.appText,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  // SizedBox(height: 7),
                  Row(
                    children: [
                      Text(category, style: AppTextStyle.cardTitle),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            annualAmount.toCurrency(),
                            style: AppTextStyle.cardAmount.copyWith(
                              color: color,
                            ),
                          ),

                          // Text(
                          //   ' / ${budgetPeriod.shortLabel}',
                          //   style: AppTextStyle.cardTitleSmall,
                          // ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: color?.withAlpha(20) ?? Colors.transparent,
                      // border: Border.all(color: colorScheme.appBorder),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                periodLabel,
                                style: AppTextStyle.bodyS,
                              ),
                            ),
                            Text(
                              amount.toCurrency(),
                              style: AppTextStyle.amountS,
                            ),
                          ],
                        ),

                        if (isCustom && customSummary != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            customSummary!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.bodyS.copyWith(
                              color: colorScheme.appTextMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Row(
                  //   spacing: 3,
                  //   children: [
                  //     if (budgetPeriod != BudgetPeriod.monthly)
                  //       Text.rich(
                  //         TextSpan(
                  //           children: [
                  //             const TextSpan(text: '~ '),
                  //             TextSpan(
                  //               text: monthlyAmount.toCurrency(),
                  //               style: AppTextStyle.amountS,
                  //             ),
                  //             const TextSpan(text: ' / month'),
                  //           ],
                  //         ),
                  //         style: AppTextStyle.labelS,
                  //       ),

                  //     if (budgetPeriod != BudgetPeriod.monthly &&
                  //         budgetPeriod != BudgetPeriod.yearly)
                  //       Text('|', style: AppTextStyle.labelM),

                  //     if (budgetPeriod != BudgetPeriod.yearly)
                  //       Text.rich(
                  //         TextSpan(
                  //           children: [
                  //             const TextSpan(text: '~ '),
                  //             TextSpan(
                  //               text: annualAmount.toCurrency(),
                  //               style: AppTextStyle.amountS,
                  //             ),
                  //             const TextSpan(text: ' / year'),
                  //           ],
                  //         ),
                  //         style: AppTextStyle.labelS,
                  //       ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
