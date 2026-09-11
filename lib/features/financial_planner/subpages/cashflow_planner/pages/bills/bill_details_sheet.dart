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
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_form.dart';
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

        final firstOccurrence = occurrences.isEmpty ? null : occurrences.first;

        final nextOccurrence = occurrences
            .where((occurrence) => !occurrence.isPaid)
            .firstOrNull;

        final nextDueDate = nextOccurrence?.dueDate;

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
                        firstOccurrence: firstOccurrence,
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
    required CashflowCategoriesTableData? category,
    required BillOccurrencesTableData? firstOccurrence,
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
          if (firstOccurrence != null)
            _buildDetailRow(
              context,
              label: 'Months',
              value: _getScheduledMonthsLabel(
                startDate: firstOccurrence.dueDate,
                bill: bill,
              ),
            ),

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

  String _getScheduledMonthsLabel({
    required DateTime startDate,
    required BillsTableData bill,
  }) {
    final frequency = BillsFrequency.values.firstWhere(
      (value) => value.name == bill.frequency,
    );

    if (frequency == BillsFrequency.monthly) {
      return 'Every Month';
    }

    final anchorDay = bill.dayOfMonth;

    if (anchorDay == null) {
      return '—';
    }

    final months = const BillScheduleCalculator().getImpactedMonths(
      startDate: startDate,
      frequency: frequency,
      anchorDay: anchorDay,
    );

    return months
        .map((month) => DateFormat('MMM').format(DateTime(2000, month)))
        .join(' | ');
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

  // ---------------------------------------------------------------------------
  // MONTH MASK
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
