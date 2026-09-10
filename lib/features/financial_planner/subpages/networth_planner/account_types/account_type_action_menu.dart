import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/add_transaction_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';

class AccountTypeActionMenu extends StatelessWidget {
  const AccountTypeActionMenu({
    super.key,
    required this.accountTypes,
    required this.onSelected,
  });

  final List<AccountType> accountTypes;
  final ValueChanged<AccountType> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (int index = 0; index < accountTypes.length; index++) ...[
          NewTransactionButton(
            color: context.colors.appAccent,
            icon: AppIcons.categories.resolve(accountTypes[index].iconKey),
            label: accountTypes[index].label,
            onTap: () => onSelected(accountTypes[index]),
          ),

          if (index < accountTypes.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}
