import 'package:flutter/widgets.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 44),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: colorScheme.surface,
          border: Border.all(color: colorScheme.appBorder),
        ),
        child: Row(
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(AppIcons.categories.resolve(account.icon), size: 20),
                // Container(
                //   height: 36,
                //   width: 36,
                //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(999), color: Colors.grey),
                // ),
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
                height: 20 / 15,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
