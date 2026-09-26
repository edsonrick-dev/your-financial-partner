import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/card_payment_transaction/card_payment_transaction_sheet.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:intl/intl.dart';

class CreditCardBillsPaymentView extends StatelessWidget {
  final int accountId;

  const CreditCardBillsPaymentView({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, List<TransactionWithDetails>>>(
      stream: database.transactionsDao.watchGroupedCreditCardPayments(
        accountId,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Unable to load payment history.'));
        }

        final groupedPayments = snapshot.data ?? {};

        if (groupedPayments.isEmpty) {
          return const _EmptyPaymentHistoryView();
        }

        return ListView(
          padding: const EdgeInsets.only(top: 0, bottom: 24),
          children: groupedPayments.entries.map((entry) {
            final sectionTitle = entry.key;
            final payments = entry.value;

            return AppSection(
              sectionTitle: sectionTitle,
              child: Column(
                spacing: 12,
                children: payments.map((item) {
                  return _CreditCardPaymentCard(item: item);
                }).toList(),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _CreditCardPaymentCard extends StatelessWidget {
  final TransactionWithDetails item;

  const _CreditCardPaymentCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final transaction = item.transaction;

    return AdaptivePressable(
      onTap: () {
        AppSheets.transaction.payCreditCard(transaction: item);
      },

      child: Row(
        children: [
          const CircleAvatar(child: Icon(Icons.payments_outlined)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text('Credit Card Payment')),
                    Text(
                      transaction.amount.toCurrency(),
                      style: AppTextStyle.amountL,
                    ),
                  ],
                ),
                Text(DateFormat('MMM d').format(transaction.date)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyPaymentHistoryView extends StatelessWidget {
  const _EmptyPaymentHistoryView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.payments_outlined, size: 48),
            const SizedBox(height: 16),
            Text(
              'No payments yet',
              style: AppTextStyle.titleL,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Payments made toward this credit card will appear here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
