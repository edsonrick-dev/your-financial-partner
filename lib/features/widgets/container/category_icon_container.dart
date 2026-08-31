import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/app_opacity.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';

class CategoryIconContainer extends StatelessWidget {
  const CategoryIconContainer({
    super.key,
    required this.item,
    required this.color,
  });

  final TransactionWithDetails item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final iconKey = switch (item.transaction.type) {
      TransactionType.give => 'handDeposit',
      TransactionType.receive => 'handWithdraw',
      TransactionType.transfer => 'sync_alt_sharp',
      _ => item.category?.icon ?? 'fallback',
    };
    item.transaction.type;
    return SizedBox(
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
                color: color,
              ),
            ),
          ),
          Icon(AppIcons.categories.resolve(iconKey), size: 24, color: color),
        ],
      ),
    );
  }
}
