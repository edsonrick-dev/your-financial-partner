import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/credit_card_billings_table.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/transaction_card_shell.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/update_balance_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreditCardTransactionsView extends GetView<CreditCardController> {
  final int accountId;

  const CreditCardTransactionsView({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    // Make sure the controller has loaded this account's
    // billing periods.
    if (controller.billingPeriods.isEmpty) {
      controller.loadBillingPeriods(accountId);
    }

    return Obx(() {
      final period = controller.selectedBillingPeriod.value;

      if (period == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return StreamBuilder<Map<String, List<TransactionWithDetails>>>(
        stream: database.transactionsDao.watchGroupedCreditCardTransactions(
          accountId: accountId,
          startDate: period.startDate,
          endDate: period.endDate,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load transactions.'));
          }

          final groupedTransactions = snapshot.data ?? {};

          return ListView(
            padding: const EdgeInsets.only(top: 0, bottom: 24),
            children: [
              _BillingPeriodHeader(controller: controller, period: period),

              if (groupedTransactions.isEmpty)
                const _EmptyTransactionsView()
              else
                ...groupedTransactions.entries.map((entry) {
                  final sectionTitle = entry.key;
                  final transactions = entry.value;

                  return AppSection(
                    sectionTitle: sectionTitle,
                    child: Column(
                      spacing: 12,
                      children: transactions.map((item) {
                        if (item.transaction.transactionType ==
                            TransactionType.balanceUpdate.name) {
                          return UpdateBalanceTransactionCard(
                            item: item,
                            isCreditCard: true,
                          );
                        }

                        return TransactionCard(item: item);
                      }).toList(),
                    ),
                  );
                }),
            ],
          );
        },
      );
    });
  }
}

class _BillingPeriodHeader extends StatelessWidget {
  final CreditCardController controller;
  final CreditCardBillingPeriodsTableData period;

  const _BillingPeriodHeader({required this.controller, required this.period});

  @override
  Widget build(BuildContext context) {
    final isCurrent = controller.currentBillingPeriod.value?.id == period.id;

    final dateFormat = DateFormat('MMMM d');

    return Row(
      children: [
        AdaptivePressable(
          onTap: controller.canGoPrevious
              ? controller.previousBillingPeriod
              : null,
          child: SizedBox(
            height: 44,
            width: 44,
            child: Center(child: Icon(PhosphorIconsRegular.caretLeft)),
          ),
        ),

        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  isCurrent ? 'Current billing period' : 'Billing period',
                  style: AppTextStyle.labelM.copyWith(
                    color: context.colors.textMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Text(
                '${dateFormat.format(period.startDate)} – '
                '${dateFormat.format(period.endDate)}',
                style: AppTextStyle.bodyM,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        AdaptivePressable(
          onTap: controller.canGoNext ? controller.nextBillingPeriod : null,
          child: SizedBox(
            height: 44,
            width: 44,
            child: Center(child: Icon(PhosphorIconsRegular.caretRight)),
          ),
        ),
      ],
    );
  }
}

class _EmptyTransactionsView extends StatelessWidget {
  const _EmptyTransactionsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.receipt_long_outlined, size: 48),
            const SizedBox(height: 16),
            Text(
              'No transactions yet',
              style: AppTextStyle.titleL,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Transactions charged to this card will appear here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CreditCardController extends GetxController {
  final selectedBillingPeriod = Rxn<CreditCardBillingPeriodsTableData>();

  final currentBillingPeriod = Rxn<CreditCardBillingPeriodsTableData>();

  List<CreditCardBillingPeriodsTableData> billingPeriods = [];
  Future<void> loadBillingPeriods(int accountId) async {
    billingPeriods = await database.creditCardDao.getBillingPeriodsForAccount(
      accountId,
    );

    if (billingPeriods.isEmpty) {
      selectedBillingPeriod.value = null;
      currentBillingPeriod.value = null;
      return;
    }

    currentBillingPeriod.value = billingPeriods.firstWhere(
      (period) => period.status == CreditCardBillingPeriodStatus.open.name,
      orElse: () => billingPeriods.last,
    );

    selectedBillingPeriod.value = currentBillingPeriod.value;
  }

  void previousBillingPeriod() {
    final selected = selectedBillingPeriod.value;
    if (selected == null) return;

    final index = billingPeriods.indexWhere(
      (period) => period.id == selected.id,
    );

    if (index > 0) {
      selectedBillingPeriod.value = billingPeriods[index - 1];
    }
  }

  void nextBillingPeriod() {
    final selected = selectedBillingPeriod.value;
    if (selected == null) return;

    final index = billingPeriods.indexWhere(
      (period) => period.id == selected.id,
    );

    if (index >= 0 && index < billingPeriods.length - 1) {
      selectedBillingPeriod.value = billingPeriods[index + 1];
    }
  }

  bool get canGoPrevious {
    final selected = selectedBillingPeriod.value;
    if (selected == null) return false;

    final index = billingPeriods.indexWhere(
      (period) => period.id == selected.id,
    );

    return index > 0;
  }

  bool get canGoNext {
    final selected = selectedBillingPeriod.value;
    final current = currentBillingPeriod.value;

    if (selected == null || current == null) return false;

    return selected.id != current.id;
  }
}
