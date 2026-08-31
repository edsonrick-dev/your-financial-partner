import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

enum BalanceUpdateContext { accountBalance, creditCardPayable }

class UpdateBalanceTransactionCard extends StatelessWidget {
  final TransactionWithDetails item;
  final bool isCreditCard;

  const UpdateBalanceTransactionCard({
    super.key,
    required this.item,
    this.isCreditCard = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final adjustment = item.transaction.amount;

    final description = isCreditCard
        ? "You adjusted this account's payable by"
        : "You adjusted this account's balance by";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              description,
              style: AppTextStyle.bodyS.copyWith(
                color: colorScheme.appTextMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 3),
          Text(
            '${adjustment >= 0 ? '+' : '-'}'
            '${adjustment.abs().toCurrency()}',
            style: AppTextStyle.amountS.copyWith(
              color: isCreditCard
                  ? adjustment >= 0
                        ? colorScheme.appOutflow
                        : colorScheme.appInflow
                  : adjustment >= 0
                  ? colorScheme.appInflow
                  : colorScheme.appOutflow,
            ),
          ),
        ],
      ),
    );
  }
}
