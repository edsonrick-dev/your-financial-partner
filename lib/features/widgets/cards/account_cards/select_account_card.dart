import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/data/app_database.dart';

class SelectAccountCard extends StatelessWidget {
  final AccountsTableData account;

  final VoidCallback? onTap;

  const SelectAccountCard({super.key, required this.account, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AdaptivePressable(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // color: colorScheme.bgLight,
          // boxShadow: [
          //   BoxShadow(
          //     color: colorScheme.text.withValues(alpha: 0.06),
          //     blurRadius: 8,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        child: Row(
          children: [
            Row(
              spacing: 12,
              children: [
                Icon(AppIcons.categories.resolve(account.icon), size: 24),

                Text(account.name, style: AppTextStyle.titleM),
              ],
            ),
            Spacer(),
            Text(
              account.availableForPayment.toCurrency(),
              style: AppTextStyle.amountM,
            ),
          ],
        ),
      ),
    );
  }
}
