import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class AccountSelectionCard extends StatelessWidget {
  final AccountsTableData account;
  final bool isSelected;
  final VoidCallback? onTap;

  const AccountSelectionCard({
    super.key,
    required this.account,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final accountType = AccountType.fromName(account.accountType);
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(AppIcons.categories.resolve(account.icon), size: 16),
                    const SizedBox(width: 4),
                    Text(accountType.label, style: AppTextStyle.labelM),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        account.name,
                        style: AppTextStyle.titleL,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            account.availableForPayment.toCurrency(),
            style: AppTextStyle.amountL,
          ),
        ],
      ),
    );
  }
}
