import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:intl/intl.dart';

class LoanSummarySection extends StatelessWidget {
  final AccountsTableData account;

  const LoanSummarySection({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return StreamBuilder<BillsTableData?>(
      stream: database.billsDao.watchLoanBillForAccount(account.id),
      builder: (context, snapshot) {
        final bill = snapshot.data;

        return AppSection(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: AppGradient.gradientA(colorScheme),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Current Balance',
                        style: AppTextStyle.titleL.copyWith(
                          color: colorScheme.appInversedtextMuted,
                        ),
                      ),
                    ),
                    AdaptivePressable(
                      onTap: () {
                        AppSheets.openAccountActionSheet(account);
                      },
                      child: Icon(
                        Icons.more_horiz,
                        color: colorScheme.appInversedtext,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    account.currentValue.toCurrency(),
                    style: AppTextStyle.amountXL.copyWith(
                      color: colorScheme.appInversedtext,
                    ),
                  ),
                ),

                if (bill != null) ...[
                  const SizedBox(height: 20),
                  _LoanPaymentSchedule(accountId: account.id, bill: bill),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LoanPaymentSchedule extends StatelessWidget {
  final int accountId;
  final BillsTableData bill;

  const _LoanPaymentSchedule({required this.accountId, required this.bill});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return StreamBuilder<List<BillOccurrencesTableData>>(
      stream: database.billsDao.watchOccurrencesForBill(bill.id),
      builder: (context, snapshot) {
        final occurrences = snapshot.data ?? [];

        final nextPayment = occurrences
            .where((occurrence) => !occurrence.isPaid)
            .firstOrNull;

        if (nextPayment == null) {
          return const SizedBox.shrink();
        }

        final frequency = BillsFrequency.values.firstWhere(
          (value) => value.name == bill.frequency,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: colorScheme.appInversedtextMuted),

            const SizedBox(height: 12),

            Text(
              'Next Payment',
              style: AppTextStyle.bodyM.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                Expanded(
                  child: Text(
                    nextPayment.expectedAmount?.toCurrency() ??
                        bill.expectedAmount?.toCurrency() ??
                        '—',
                    style: AppTextStyle.titleL.copyWith(
                      color: colorScheme.appInversedtext,
                    ),
                  ),
                ),

                Text(
                  DateFormat('MMM d, yyyy').format(nextPayment.dueDate),
                  style: AppTextStyle.bodyM.copyWith(
                    color: colorScheme.appInversedtextMuted,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              frequency.billsLabel,
              style: AppTextStyle.labelS.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),
          ],
        );
      },
    );
  }
}
