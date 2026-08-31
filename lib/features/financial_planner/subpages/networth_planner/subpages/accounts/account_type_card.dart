import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class AccountTypeCard extends StatelessWidget {
  const AccountTypeCard({super.key, required this.type, this.onTap});
  final VoidCallback? onTap;
  final AccountType type;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(AppIcons.categories.resolve(type.iconKey)),
          const SizedBox(width: 12),
          Expanded(child: Text(type.label)),
        ],
      ),
    );
  }
}
