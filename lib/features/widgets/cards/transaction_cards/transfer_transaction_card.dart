import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/app_opacity.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/delete_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

class TransferTransactionCard extends GetView<TransactionController> {
  final TransactionWithDetails item;

  const TransferTransactionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AdaptivePressable(
      onTap: () {
        AppSheets.transaction.transfer(item);
      },
      onLongPress: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('Delete Transaction'),
              content: const Text('This action cannot be undone.'),
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
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints(minHeight: 44),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///Icon Holder
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
            SizedBox(width: 12),

            ///Details Row
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Transfer', style: AppTextStyle.titleL),
                      SizedBox(height: 2),
                      Text(
                        '${item.account.name} → ${item.linkedAccount?.name ?? 'Unknown'}',
                        style: AppTextStyle.bodyS.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ///Value
                      Text(
                        item.transaction.amount.toCurrency(),
                        style: AppTextStyle.amountL,
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
