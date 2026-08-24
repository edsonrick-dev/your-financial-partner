import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/update_account_balance_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/edit_cash_account_detail.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/credit_card_details_sheet/edit_credit_card_details.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AccountActionsSheet extends GetView<AccountController> {
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
                controller.initializeBalanceUpdate(account);
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

                final accountType = AccountType.values.firstWhere(
                  (type) => type.id == account.accountType,
                );
                switch (accountType) {
                  case AccountType.cash:
                  case AccountType.savingsAccount:
                  case AccountType.checkingAccount:
                  case AccountType.eWallet:
                    controller.initializeEditAccount(account);
                    Get.bottomSheet(
                      EditCashAccountDetail(account: account),
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                    );
                  // Open cash/bank edit sheet
                  // break;

                  case AccountType.creditCard:
                    controller.initializeEditAccount(account);
                    Get.bottomSheet(
                      EditCreditCardDetails(account: account),
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                    );
                    break;
                  // default:
                  //   break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
