import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/delete_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/widgets/container/category_icon_container.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

class EarnTransactionCard extends GetView<TransactionController> {
  final TransactionWithDetails item;
  const EarnTransactionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return GestureDetector(
      onTap: () {
        AppSheets.transaction.earn(item);
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
          await controller.deleteTransactionWithBalanceUpdate(item);
        }
      },
      child: Container(
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints(minHeight: 44),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.appOnSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.appBorder),
        ),
        child: Row(
          spacing: 8,
          children: [
            ///Icon Holder
            CategoryIconContainer(item: item, color: colorScheme.appText),

            ///Details Row
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        item.category?.name ?? 'Unknown',
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
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.transaction.amount.toCurrency(),
                        style: TextStyle(
                          fontSize: 17,
                          height: 20 / 17,
                          color: colorScheme.appInflow,
                          // fontWeight: FontWeight(600),
                          fontFeatures: [FontFeature.tabularFigures()],
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
