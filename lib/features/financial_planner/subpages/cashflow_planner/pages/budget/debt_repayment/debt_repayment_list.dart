import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/debt_repayment/debt_repayment_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/debt_repayment/debt_repayment_details_sheet.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class DebtRepaymentList extends StatelessWidget {
  const DebtRepaymentList({super.key, required this.bills});
  final List<BillWithNextOccurrence> bills;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final annualTotal = bills.fold<double>(0, (total, item) {
      final frequency = BillsFrequency.values.firstWhere(
        (frequency) => frequency.name == item.bill.frequency,
      );

      return total + frequency.toAnnual(item.bill.expectedAmount);
    });
    return AppSection(
      sectionTitle: 'Debt Repayment',
      trailingType: SectionTrailingType.custom,
      trailingWidget: Text(
        annualTotal.toCurrency(),
        style: AppTextStyle.amountM.copyWith(color: colorScheme.appOutflow),
      ),
      child: Column(
        spacing: 8,
        children: [
          for (final item in bills)
            DebtRepaymentCard(
              item: item,
              onTap: () {
                Get.bottomSheet(
                  DebtRepaymentDetailsSheet(
                    bill: item,
                    // plan: plan,
                    // selectedIndex: selectedIndex,
                  ),
                  backgroundColor: Colors.transparent,
                  isDismissible: true,
                  isScrollControlled: true,
                );
              },
            ),
        ],
      ),
    );
  }
}
