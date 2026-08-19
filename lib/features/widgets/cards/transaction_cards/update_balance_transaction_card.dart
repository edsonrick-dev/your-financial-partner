import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_opacity.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/delete_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

class UpdateBalanceTransactionCard extends GetView<TransactionController> {
  final TransactionWithDetails item;

  const UpdateBalanceTransactionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final amount = item.transaction.amount;

    return AdaptivePressable(
      onTap: () {
        // TODO:
        // Open Update Balance sheet in edit mode.
        //
        // Example:
        // AppSheets.account.updateBalance(item);
      },
      onLongPress: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('Delete Balance Update'),
              content: const Text(
                'This will remove the balance adjustment '
                'from this account.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );

        if (confirmed == true) {
          await controller.deleteTransaction(item);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minHeight: 44),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.appBorder),
        ),
        child: Row(
          spacing: 8,
          children: [
            /// Icon Holder
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
                        borderRadius: BorderRadius.circular(999),
                        color: colorScheme.appText,
                      ),
                    ),
                  ),
                  Icon(
                    AppIcons.categories.resolve('sync_alt_sharp'),
                    size: 20,
                    color: colorScheme.appText,
                  ),
                ],
              ),
            ),

            /// Details
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Balance Updated',
                        style: TextStyle(fontSize: 17, height: 20 / 17),
                      ),
                      Text(
                        item.account.name,
                        style: TextStyle(
                          fontSize: 10,
                          height: 12 / 10,
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// Amount
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${amount >= 0 ? '+' : '-'}${amount.abs().toCurrency()}',
                        style: TextStyle(
                          fontSize: 17,
                          fontFeatures: const [FontFeature.tabularFigures()],
                          height: 20 / 17,
                          color: amount >= 0
                              ? colorScheme.appSuccess
                              : colorScheme.appError,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
