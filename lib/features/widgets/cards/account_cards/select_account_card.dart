import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class SelectAccountCard extends StatelessWidget {
  final AccountsTableData account;

  final VoidCallback? onTap;

  const SelectAccountCard({super.key, required this.account, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(AppIcons.categories.resolve(account.icon), size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    account.name,
                    style: AppTextStyle.titleM,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            account.availableForPayment.toCurrency(),
            style: AppTextStyle.amountM,
          ),
        ],
      ),
    );
  }
}
