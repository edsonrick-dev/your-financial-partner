import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/delete_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/features/widgets/container/category_icon_container.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GiveMoneyTransactionCard extends GetView<TransactionController> {
  final TransactionWithDetails item;

  const GiveMoneyTransactionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final participantName = item.participants.isNotEmpty
        ? item.participants.first.entity.name
        : 'Unknown Person';

    return AdaptivePressable(
      onTap: () {
        AppSheets.transaction.giveMoney(item);
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
            CategoryIconContainer(item: item, color: colorScheme.appOutflow),

            const SizedBox(width: 12),

            ///Details Row
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Top Column
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text('Give Money', style: AppTextStyle.titleM),
                      ),
                      const SizedBox(width: 16),
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
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                item.account!.name,
                                style: AppTextStyle.bodyS.copyWith(
                                  color: colorScheme.appTextMuted,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            Text(
                              ' → ',
                              style: AppTextStyle.bodyS.copyWith(
                                color: colorScheme.appTextMuted,
                              ),
                            ),

                            Icon(
                              PhosphorIconsRegular.user,
                              color: colorScheme.appTextMuted,
                              size: 14,
                            ),

                            const SizedBox(width: 3),

                            Flexible(
                              child: Text(
                                participantName,
                                style: AppTextStyle.bodyS.copyWith(
                                  color: colorScheme.appTextMuted,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),
                      if (item.hasDebtImpact)
                        Column(
                          children: [
                            SizedBox(height: 2),
                            Icon(
                              PhosphorIconsRegular.coins,
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
