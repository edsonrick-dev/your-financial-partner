import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/app_opacity.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

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
          Icon(
            AppIcons.categories.resolve(item.category?.icon ?? 'fallback'),
            size: 20,
            color: color,
          ),
        ],
      ),
    );
  }
}
