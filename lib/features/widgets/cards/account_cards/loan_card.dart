import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class LoanAccountCard extends StatelessWidget {
  final AccountsTableData account;
  final VoidCallback? onTap;

  const LoanAccountCard({super.key, required this.account, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(AppIcons.categories.resolve(account.icon), size: 24),
          const SizedBox(width: 12),

          Expanded(
            child: Text(
              account.name,
              style: AppTextStyle.bodyM,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: 8),

          Text(
            account.currentValue.toCurrency(),
            style: AppTextStyle.amountL.copyWith(color: colorScheme.appOutflow),
            softWrap: false,
            maxLines: 1,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
