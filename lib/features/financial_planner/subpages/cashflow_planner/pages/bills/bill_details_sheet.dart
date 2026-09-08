import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_payment_history.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_category.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:intl/intl.dart';

class BillDetailsSheet extends GetView<BillController> {
  const BillDetailsSheet({super.key, required this.item});

  final BillWithCategory item;
  DateTime? _getNextDueDate({
    required BillsTableData bill,
    required List<BillOccurrencesTableData> occurrences,
  }) {
    final day = bill.dayOfMonth;

    if (day == null) {
      return null;
    }

    final lastDate = occurrences.isEmpty
        ? DateTime.now()
        : occurrences
              .map((e) => e.dueDate)
              .reduce((a, b) => a.isAfter(b) ? a : b);

    final frequency = BillsFrequency.values.firstWhere(
      (e) => e.name == bill.frequency,
    );

    switch (frequency) {
      case BillsFrequency.monthly:
        return _nextMonthlyDate(after: lastDate, day: day);

      case BillsFrequency.quarterly:
      case BillsFrequency.semiAnnual:
      case BillsFrequency.annual:
        return _nextPatternDate(
          after: lastDate,
          day: day,
          monthMask: bill.monthMask ?? 0,
        );

      default:
        return null;
    }
  }

  DateTime _nextMonthlyDate({required DateTime after, required int day}) {
    var year = after.year;
    var month = after.month + 1;

    if (month > 12) {
      month = 1;
      year++;
    }

    final lastDay = DateTime(year, month + 1, 0).day;

    return DateTime(year, month, day.clamp(1, lastDay));
  }

  DateTime? _nextPatternDate({
    required DateTime after,
    required int day,
    required int monthMask,
  }) {
    for (var offset = 1; offset <= 12; offset++) {
      final candidateMonth = after.month + offset;

      final year = after.year + ((candidateMonth - 1) ~/ 12);
      final month = ((candidateMonth - 1) % 12) + 1;

      final isSelected = monthMask & (1 << (month - 1)) != 0;

      if (!isSelected) {
        continue;
      }

      final lastDay = DateTime(year, month + 1, 0).day;

      return DateTime(year, month, day.clamp(1, lastDay));
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;
    // final transactionController = Get.find<TransactionController>();

    return StreamBuilder<List<BillOccurrencesTableData>>(
      stream: database.billsDao.watchOccurrencesForBill(item.bill.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppSheet(
            height: AppSheetHeight.full,
            title: 'Bill',
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return AppSheet(
            height: AppSheetHeight.full,
            title: item.bill.name,
            child: Center(
              child: Text('Something went wrong: ${snapshot.error}'),
            ),
          );
        }

        final occurrences = snapshot.data ?? [];
        final nextOccurrence = occurrences
            .where((occurrence) => !occurrence.isPaid)
            .firstOrNull;

        final nextDueDate =
            nextOccurrence?.dueDate ??
            _getNextDueDate(bill: item.bill, occurrences: occurrences);

        final nextAmount =
            nextOccurrence?.expectedAmount ?? item.bill.expectedAmount;

        return AppSheet(
          height: AppSheetHeight.full,
          title: item.bill.name,
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                AppSection(
                  child: Column(
                    spacing: 12,
                    children: [
                      _buildBillSummary(
                        context,
                        bill: item.bill,
                        nextDueDate: nextDueDate,
                        nextAmount: nextAmount,
                        category: item.category,
                      ),
                      AppButton(
                        text: 'Make Payment',
                        onTap: () {
                          controller.makePayment(item);
                        },
                        // nextOccurrence == null
                        //     ? null
                        //     : () async {
                        //         final bill = BillWithNextOccurrence(
                        //           bill: item.bill,
                        //           occurrence: nextOccurrence,
                        //           category: item.category,
                        //         );

                        //         Get.back();

                        //         await AppSheets.transaction.spendBill(bill);
                        // },
                      ),
                    ],
                  ),
                ),

                AppDetailsPageActionSection(
                  selectedIndex: selectedIndex,
                  actions: const ['Payment History'],
                ),

                Obx(
                  () => IndexedStack(
                    index: selectedIndex.value,
                    children: [_buildPaymentHistory(context)],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  // ---------------------------------------------------------------------------
  // BILL SUMMARY
  // ---------------------------------------------------------------------------

  Widget _buildBillSummary(
    BuildContext context, {
    required BillsTableData bill,
    required DateTime? nextDueDate,
    required double nextAmount,
    required CashflowCategoriesTableData category,
  }) {
    final colorScheme = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppGradient.gradientA(colorScheme),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------------------------------------------------------
          // AMOUNT + NEXT DUE DATE
          // -------------------------------------------------------------------
          Center(
            child: Column(
              spacing: 4,
              children: [
                Text(
                  nextAmount.toCurrency(),
                  style: AppTextStyle.amountXL.copyWith(
                    color: colorScheme.appInversedtext,
                  ),
                ),

                if (nextDueDate != null)
                  Text(
                    DateFormat('MMM d, yyyy').format(nextDueDate),
                    style: AppTextStyle.bodyM.copyWith(
                      color: colorScheme.appInversedtextMuted,
                    ),
                  ),
              ],
            ),
          ),

          Divider(color: colorScheme.appInversedtextMuted),

          // -------------------------------------------------------------------
          // RECURRENCE
          // -------------------------------------------------------------------
          _buildDetailRow(
            context,
            label: 'Recurrence',
            value: _getFrequencyLabel(bill.frequency),
          ),

          // -------------------------------------------------------------------
          // MONTH PATTERN
          // -------------------------------------------------------------------
          if (bill.monthMask != null)
            _buildDetailRow(
              context,
              label: 'Months',
              value: _getMonthMaskLabel(bill.monthMask),
            ),

          // -------------------------------------------------------------------
          // DAY OF MONTH
          // -------------------------------------------------------------------
          if (bill.dayOfMonth != null)
            _buildDetailRow(
              context,
              label: 'Due Every',
              value: _getDayLabel(bill.dayOfMonth!),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DETAIL ROW
  // ---------------------------------------------------------------------------

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    final colorScheme = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyle.bodyM.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyle.bodyM.copyWith(
              color: colorScheme.appInversedtext,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PAYMENT HISTORY
  // ---------------------------------------------------------------------------

  Widget _buildPaymentHistory(BuildContext context) {
    return StreamBuilder<List<BillPaymentHistory>>(
      stream: database.billsDao.watchPaymentHistoryForBill(item.bill.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppSection(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return AppSection(
            child: Text(
              'Unable to load payment history.',
              style: AppTextStyle.bodyM,
            ),
          );
        }

        final payments = snapshot.data ?? [];

        if (payments.isEmpty) {
          return AppSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Text('Payment History', style: AppTextStyle.titleM),
                Text(
                  'No payments recorded yet.',
                  style: AppTextStyle.bodyM.copyWith(
                    color: context.colors.appTextMuted,
                  ),
                ),
              ],
            ),
          );
        }

        return AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Text('Payment History', style: AppTextStyle.titleM),

              ...payments.map(
                (payment) => _PaymentHistoryItem(
                  payment: payment,
                  onTap: () async {
                    final transaction = await database.transactionsDao
                        .getTransactionWithDetailsById(payment.transaction.id);

                    if (transaction == null) {
                      return;
                    }

                    Get.back();

                    await AppSheets.transaction.spend(item: transaction);
                  },
                  onLongPress: () {
                    controller.deletePaymentHistory(payment);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // FREQUENCY
  // ---------------------------------------------------------------------------

  String _getFrequencyLabel(String frequency) {
    switch (frequency) {
      case 'monthly':
        return 'Monthly';

      case 'quarterly':
        return 'Quarterly';

      case 'semiAnnual':
        return 'Every 6 months';

      case 'annual':
        return 'Annually';

      default:
        return frequency;
    }
  }

  // ---------------------------------------------------------------------------
  // MONTH MASK
  // ---------------------------------------------------------------------------

  String _getMonthMaskLabel(int? mask) {
    if (mask == null) {
      return '—';
    }

    final months = AppMonth.values.where((month) {
      return (mask & (1 << (month.number - 1))) != 0;
    }).toList();

    if (months.isEmpty) {
      return '—';
    }

    return months.map((month) => month.shortName).join(' | ');
  }

  // ---------------------------------------------------------------------------
  // DAY OF MONTH
  // ---------------------------------------------------------------------------

  String _getDayLabel(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }

    switch (day % 10) {
      case 1:
        return '${day}st';

      case 2:
        return '${day}nd';

      case 3:
        return '${day}rd';

      default:
        return '${day}th';
    }
  }
}

class _PaymentHistoryItem extends StatelessWidget {
  const _PaymentHistoryItem({
    required this.payment,
    this.onTap,
    this.onLongPress,
  });

  final BillPaymentHistory payment;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final occurrence = payment.occurrence;
    final transaction = payment.transaction;

    return AdaptivePressable(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.amount.toCurrency(),
                    style: AppTextStyle.amountM,
                  ),

                  const SizedBox(height: 2),

                  Text(
                    'Paid ${DateFormat('MMM d, yyyy').format(transaction.date)}',
                    style: AppTextStyle.labelS.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Due ${DateFormat('MMM d, yyyy').format(occurrence.dueDate)}',
                  style: AppTextStyle.labelS.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  'Expected ${occurrence.expectedAmount.toCurrency()}',
                  style: AppTextStyle.labelS.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
