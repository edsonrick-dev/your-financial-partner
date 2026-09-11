import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';

class DebtRepaymentCard extends StatelessWidget {
  final BillWithNextOccurrence item;
  final VoidCallback? onTap;
  const DebtRepaymentCard({super.key, required this.item, this.onTap});
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final bill = item.bill;
    final loan = item.loanAccount;

    final frequency = BillsFrequency.values.firstWhere(
      (frequency) => frequency.name == bill.frequency,
    );

    final annualAmount = frequency.toAnnual(bill.expectedAmount);
    final amount = bill.expectedAmount;
    final periodLabel = '${item.bill.frequency.capitalize} Budget';
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
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  AppIcons.categories.resolve(item.category?.icon ?? 'wallet'),
                  color: colorScheme.appOutflow,
                ),
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.appOutflow,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          loan?.name ?? bill.name,
                          style: AppTextStyle.bodyM,
                        ),
                      ),
                      Text(
                        annualAmount.toCurrency(),
                        style: AppTextStyle.amountM.copyWith(
                          color: colorScheme.appOutflow,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.appOutflow.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                periodLabel,
                                style: AppTextStyle.bodyS,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              amount.toCurrency(),
                              style: AppTextStyle.amountS,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   '${annualAmount.toCurrency()} / year',
                  //   style: AppTextStyle.labelS.copyWith(
                  //     color: colorScheme.appTextMuted,
                  //   ),
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
