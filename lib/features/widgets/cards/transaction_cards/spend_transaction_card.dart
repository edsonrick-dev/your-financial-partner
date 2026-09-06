import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/delete_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/widgets/container/category_icon_container.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SpendTransactionCard extends GetView<TransactionController> {
  final TransactionWithDetails item;

  const SpendTransactionCard({super.key, required this.item});
  String get paymentSource {
    if (item.account != null) {
      return item.account!.name;
    }

    if (item.participants.isNotEmpty) {
      return 'Paid by ${item.participants.first.entity.name}';
    }

    return 'Paid by someone else';
  }

  @override
  Widget build(BuildContext context) {
    // final othersCount = item.participants.length - 1;
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: () {
        AppSheets.transaction.spend(item: item);
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
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ///Icon Holder
            CategoryIconContainer(item: item, color: colorScheme.appOutflow),
            const SizedBox(width: 12),

            ///Details Row
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Expanded(
                        child: Text(
                          item.category?.name ?? 'Unknown',
                          style: AppTextStyle.titleL,
                        ),
                      ),

                      Text(
                        item.transaction.amount.toCurrency(),
                        style: AppTextStyle.amountL.copyWith(
                          color: colorScheme.appOutflow,
                        ),
                      ),
                    ],
                  ),

                  ///Right Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          paymentSource,
                          style: AppTextStyle.bodyS.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (item.isSharedExpense)
                        Column(
                          children: [
                            SizedBox(width: 2),
                            Icon(
                              PhosphorIconsRegular.users,
                              color: colorScheme.appInfo,
                              size: 16,
                            ),
                          ],
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
