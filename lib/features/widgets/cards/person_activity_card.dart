import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/app_opacity.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/person_debt_activity.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/save_functions.dart';
import 'package:intl/intl.dart';

class PersonDebtActivityCard extends StatelessWidget {
  final PersonDebtActivity activity;
  final VoidCallback? onTap;
  const PersonDebtActivityCard({super.key, required this.activity, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final transaction = activity.transaction;
    final obligation = activity.obligation;

    final debtType = DebtManagementType.values.firstWhere(
      (e) => e.name == obligation.type,
    );
    final title = switch (debtType) {
      DebtManagementType.expensePaidByOthers => 'Paid for You',
      DebtManagementType.splitExpense => 'Shared Expense',
      DebtManagementType.giveMoney => 'You Lent',
      DebtManagementType.receiveMoney => 'You Borrowed',
    };

    final iconKey = switch (debtType) {
      DebtManagementType.giveMoney => 'handDeposit',
      DebtManagementType.receiveMoney => 'handCoins',
      DebtManagementType.splitExpense => 'usersThree',
      DebtManagementType.expensePaidByOthers => 'user',
    };
    final balanceInflow = switch (debtType) {
      DebtManagementType.giveMoney => false,
      DebtManagementType.receiveMoney => true,
      DebtManagementType.splitExpense => false,
      DebtManagementType.expensePaidByOthers => true,
    };
    final obligationAmount = obligation.amount;
    // final obligationAmount = transactionType == TransactionType.give
    //     ? '-${transaction.amount.toCurrency()}'
    //     : transaction.amount.toCurrency();

    final balanceLabel = activity.runningBalance == 0
        ? 'Settled'
        : activity.runningBalance > 0
        ? 'Owes You'
        : 'You Owe';

    final balanceAmount = activity.runningBalance.abs();

    final flowColor = balanceInflow
        ? colorScheme.appInflow
        : colorScheme.appOutflow;
    // final balanceColor = activity.runningBalance == 0
    //     ? colorScheme.appNeutral
    //     : activity.isReceivable
    //     ? colorScheme.appInflow
    //     : colorScheme.appOutflow; //4938271509

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

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(title, style: AppTextStyle.bodyM)),
                    const SizedBox(width: 16),
                    Text(
                      obligationAmount.toCurrency(),
                      style: AppTextStyle.amountM.copyWith(color: flowColor),
                    ),
                  ],
                ),

                // const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat('MMMM d, yyyy').format(transaction.date),
                        style: AppTextStyle.bodyS.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$balanceLabel: ${balanceAmount.toCompactCurrency()}',
                      style: AppTextStyle.bodyS.copyWith(
                        color: colorScheme.appTextMuted,
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
