import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';

class AccountCard extends StatelessWidget {
  final AccountsTableData account;

  final VoidCallback? onTap;

  const AccountCard({super.key, required this.account, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    Color valueColor;

    if (account.currentValue < 0) {
      valueColor = colorScheme.appOutflow;
    } else {
      valueColor = colorScheme.appText;
    }

    return AdaptivePressable(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 44),
        decoration: BoxDecoration(color: colorScheme.bgLight),
        child: Row(
          children: [
            Row(
              spacing: 12,
              children: [
                Icon(AppIcons.categories.resolve(account.icon), size: 24),

                Text(
                  account.name,
                  style: TextStyle(fontSize: 15, height: 20 / 15),
                ),
              ],
            ),
            Spacer(),
            Text(
              account.currentValue.toCurrency(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 20 / 15,
                color: valueColor,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
