import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/details/budget_plan/loan_payment/debt_repayment_card.dart';

import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class DebtRepaymentList extends StatelessWidget {
  const DebtRepaymentList({super.key, required this.bills});
  final List<BillWithNextOccurrence> bills;

  Future<void> _openLoan(
    BuildContext context,
    BillWithNextOccurrence item,
  ) async {
    final accountId = item.bill.accountId;

    if (accountId == null) {
      Get.snackbar(
        'Loan unavailable',
        'This repayment is not linked to a loan account.',
      );
      return;
    }

    final account = await database.accountsDao.getAccountById(accountId);

    if (account == null) {
      Get.snackbar('Loan unavailable', 'The loan account could not be found.');
      return;
    }

    await AppSheets.viewLoanDetailSheet(account);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final annualTotal = bills.fold<double>(0, (total, item) {
      final frequency = BillsFrequency.values.firstWhere(
        (frequency) => frequency.name == item.bill.frequency,
      );

      return total + frequency.toAnnual(item.bill.expectedAmount ?? 0);
    });

    return AppSection(
      sectionTitle: 'Loan Payment',
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
                _openLoan(context, item);
                // Get.bottomSheet(
                //   DebtRepaymentDetailsSheet(
                //     bill: item,
                //     // plan: plan,
                //     // selectedIndex: selectedIndex,
                //   ),
                //   backgroundColor: Colors.transparent,
                //   isDismissible: true,
                //   isScrollControlled: true,
                // );
              },
            ),
        ],
      ),
    );
  }
}
