import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

class UpdateBalanceTransactionCard extends GetView<TransactionController> {
  final TransactionWithDetails item;

  const UpdateBalanceTransactionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final adjustment = item.transaction.amount;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              "You adjusted this account's balance by",
              style: AppTextStyle.bodyS.copyWith(
                color: colorScheme.appTextMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(width: 6),

          Text(
            '${adjustment >= 0 ? '+' : '-'}'
            '${adjustment.abs().toCurrency()}',
            style: AppTextStyle.amountS.copyWith(
              color: adjustment >= 0
                  ? colorScheme.appSuccess
                  : colorScheme.appError,
            ),
          ),
        ],
      ),
    );
  }
}
