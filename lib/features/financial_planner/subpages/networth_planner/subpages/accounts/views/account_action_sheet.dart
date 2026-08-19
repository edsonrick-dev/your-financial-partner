import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/update_account_balance_sheet.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccountActionsSheet extends StatelessWidget {
  final AccountsTableData account;

  const AccountActionsSheet({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: 'Account Actions',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(PhosphorIconsRegular.arrowsClockwise),
              title: const Text('Update Balance'),
              subtitle: const Text('Adjust the recorded balance'),
              onTap: () {
                Get.back();

                Get.bottomSheet(
                  UpdateAccountBalanceSheet(account: account),
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                );
              },
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(PhosphorIconsRegular.pencilSimple),
              title: const Text('Edit Account'),
              subtitle: const Text('Change account details'),
              onTap: () {
                Get.back();

                // Open your existing edit account sheet here.
                //
                // Example:
                // AppSheets.account.edit(account);
              },
            ),
          ],
        ),
      ),
    );
  }
}
