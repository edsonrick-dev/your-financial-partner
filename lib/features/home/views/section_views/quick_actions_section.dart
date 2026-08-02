import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/home_initial/widget/transaction_button.dart';

class QuickActionSection extends StatelessWidget {
  const QuickActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        AppBorderRadius.xL, //16,
      ),
      child: Container(
        color: colorScheme.bgLight,
        child: Row(
          // spacing: 12,
          children: [
            TransactionButton(
              label: 'Earn',
              color: colorScheme.appInflow,
              icon: Icons.add,
              onTap: () {
                AppSheets.transaction.earn();
              },
            ),
            TransactionButton(
              color: colorScheme.appOutflow,
              icon: Icons.remove,
              label: 'Spend',
              onTap: () {
                AppSheets.transaction.spend();
              },
            ),
            TransactionButton(
              color: colorScheme.appAccent,
              icon: Icons.sync_alt_sharp,
              label: 'Transfer',
              onTap: () {
                AppSheets.transaction.transfer();
              },
            ),
            TransactionButton(
              color: colorScheme.appNeutral,
              icon: Icons.more_horiz,
              label: 'Others',
              onTap: () {
                AppSheets.selection.selectOtherTransaction();
              },
            ),
          ],
        ),
      ),
    );
  }
}
