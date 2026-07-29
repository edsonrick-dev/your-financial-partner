import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/app_opacity.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/person_debt_activity.dart';
import 'package:intl/intl.dart';

class PersonDebtActivityCard extends StatelessWidget {
  final PersonDebtActivity activity;

  const PersonDebtActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final transaction = activity.transaction;
    final obligation = activity.obligation;

    final transactionType = TransactionType.values.firstWhere(
      (e) => e.name == transaction.transactionType,
    );

    final title = switch (transactionType) {
      TransactionType.give => 'Give Money',
      TransactionType.receive => 'Receive Money',
      _ => 'Debt Activity',
    };

    final iconKey = switch (transactionType) {
      TransactionType.give => 'handDeposit',
      TransactionType.receive => 'handCoins',
      _ => 'usersThree',
    };
    final amountText = obligation.amount.toCurrency();
    // final amountText = transactionType == TransactionType.give
    //     ? '-${transaction.amount.toCurrency()}'
    //     : transaction.amount.toCurrency();

    final balanceLabel = activity.runningBalance == 0
        ? 'Settled'
        : activity.runningBalance > 0
        ? 'Owes You'
        : 'You Owe';

    final balanceAmount = activity.runningBalance.abs();

    final balanceColor = activity.runningBalance == 0
        ? colorScheme.appNeutral
        : activity.isReceivable
        ? colorScheme.appInflow
        : colorScheme.appOutflow;

    return Container(
      padding: const EdgeInsets.all(8),

      constraints: const BoxConstraints(minHeight: 44),

      width: double.infinity,

      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.appBorder),
      ),

      child: Row(
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: AppOpacity.transactionIcon,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.appText,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Icon(
                  AppIcons.categories.resolve(iconKey),
                  size: 20,
                  color: colorScheme.appText,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 17, height: 20 / 17),
                    ),

                    Text(
                      DateFormat('MMMM d, yyyy').format(transaction.date),
                      style: TextStyle(
                        fontSize: 10,
                        height: 12 / 10,
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amountText,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 20 / 17,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),

                    Text(
                      '$balanceLabel: ${balanceAmount.toCurrency()}',
                      style: TextStyle(
                        fontSize: 10,
                        height: 12 / 10,
                        color: balanceColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
