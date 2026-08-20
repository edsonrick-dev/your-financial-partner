import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashflowPlanCard extends StatelessWidget {
  final FrequencyType budgetPeriod;
  final String category;
  final double amount;
  final VoidCallback? onTap;
  const CashflowPlanCard({
    super.key,
    required this.budgetPeriod,
    required this.category,
    required this.amount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final monthlyAmount = budgetPeriod.toMonthly(amount);
    final annualAmount = budgetPeriod.toAnnual(amount);
    return AdaptivePressable(
      onTap: onTap,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(PhosphorIconsRegular.car, color: colorScheme.appInfo),
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.appInfo,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(category, style: AppTextStyle.bodyM),
                      Spacer(),
                      Row(
                        spacing: 3,
                        children: [
                          Text(
                            amount.toCurrency(),
                            style: AppTextStyle.amountM,
                          ),
                          Text('/', style: AppTextStyle.bodyM),
                          Text(budgetPeriod.period, style: AppTextStyle.bodyM),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    spacing: 3,
                    children: [
                      if (budgetPeriod != FrequencyType.monthly)
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: '~ '),
                              TextSpan(
                                text: monthlyAmount.toCurrency(),
                                style: AppTextStyle.amountS,
                              ),
                              const TextSpan(text: ' / month'),
                            ],
                          ),
                          style: AppTextStyle.labelS,
                        ),

                      if (budgetPeriod != FrequencyType.monthly &&
                          budgetPeriod != FrequencyType.annual)
                        Text('|', style: AppTextStyle.labelM),

                      if (budgetPeriod != FrequencyType.annual)
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: '~ '),
                              TextSpan(
                                text: annualAmount.toCurrency(),
                                style: AppTextStyle.amountS,
                              ),
                              const TextSpan(text: ' / year'),
                            ],
                          ),
                          style: AppTextStyle.labelS,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
