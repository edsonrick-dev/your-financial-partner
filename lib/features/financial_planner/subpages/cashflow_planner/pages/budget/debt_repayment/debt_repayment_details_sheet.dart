import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_payment_history.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_category.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:intl/intl.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class DebtRepaymentDetailsSheet extends GetView<BillController> {
  const DebtRepaymentDetailsSheet({super.key, required this.bill});

  final BillWithNextOccurrence bill;

  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;

    final loan = bill.loanAccount;

    final frequency = BillsFrequency.values.firstWhere(
      (frequency) => frequency.name == bill.bill.frequency,
    );

    final paymentAmount = bill.bill.expectedAmount;

    final annualAmount = frequency.toAnnual(paymentAmount);

    return AppSheet(
      height: AppSheetHeight.full,
      title: bill.bill.name,
      child: Column(
        children: [
          _DebtRepaymentSummarySection(
            loanName: loan?.name,
            paymentAmount: paymentAmount,
            annualAmount: annualAmount,
            frequency: frequency,
            nextPaymentDate: bill.occurrence.dueDate,
          ),
          SizedBox(height: 20),
          AppSection(
            child: AppButton(
              type: ButtonType.outline,
              text: 'Make Payment',
              onTap: () {
                controller.makePayment(
                  BillWithCategory(
                    bill: bill.bill,
                    category: bill.category,
                    loanAccount: bill.loanAccount,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          AppDetailsPageActionSection(
            selectedIndex: selectedIndex,
            actions: const ['Payment History'],
          ),

          Expanded(
            child: Obx(
              () => IndexedStack(
                index: selectedIndex.value,
                children: [
                  _PaymentHistory(
                    billId: bill.bill.id,
                    onDelete: controller.deletePaymentHistory,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentHistory extends StatelessWidget {
  const _PaymentHistory({required this.billId, required this.onDelete});

  final int billId;
  final void Function(BillPaymentHistory payment) onDelete;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BillPaymentHistory>>(
      stream: database.billsDao.watchPaymentHistoryForBill(billId),
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
            child: Text(
              'No payments recorded yet.',
              style: AppTextStyle.bodyM.copyWith(
                color: context.colors.appTextMuted,
              ),
            ),
          );
        }

        return AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
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
                    onDelete(payment);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DebtRepaymentSummarySection extends StatelessWidget {
  const _DebtRepaymentSummarySection({
    required this.loanName,
    required this.paymentAmount,
    required this.annualAmount,
    required this.frequency,
    required this.nextPaymentDate,
  });

  final String? loanName;
  final double paymentAmount;
  final double annualAmount;
  final BillsFrequency frequency;
  final DateTime nextPaymentDate;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      child: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppGradient.gradientA(colorScheme),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loanName ?? 'Loan Payment',
              style: AppTextStyle.titleL.copyWith(
                color: colorScheme.appInversedtext,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              billFrequencyLabel(frequency),
              style: AppTextStyle.bodyS.copyWith(
                color: colorScheme.appInversedtext,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _Metric(
                    label: 'Payment',
                    value: paymentAmount.toCurrency(),
                  ),
                ),
                Expanded(
                  child: _Metric(
                    label: 'Annual',
                    value: annualAmount.toCurrency(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              'Next payment',
              style: AppTextStyle.bodyS.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              DateFormat('MMMM d, yyyy').format(nextPaymentDate),
              style: AppTextStyle.bodyM.copyWith(
                color: colorScheme.appInversedtext,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String billFrequencyLabel(BillsFrequency frequency) {
    return frequency.label;
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyS.copyWith(
            color: colorScheme.appInversedtext,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyle.amountM.copyWith(
            color: colorScheme.appInversedtext,
          ),
        ),
      ],
    );
  }
}

// class _PaymentHistoryPlaceholder extends StatelessWidget {
//   const _PaymentHistoryPlaceholder({required this.loanAccountId});

//   final int? loanAccountId;

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text('Payment history'));
//   }
// }

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
