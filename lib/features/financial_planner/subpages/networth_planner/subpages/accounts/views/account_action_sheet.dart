import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/update_account_balance_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/edit_cash_account_detail.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/credit_card_details_sheet/edit_credit_card_details.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
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
        padding: EdgeInsets.fromLTRB(16, 0, 16, context.bottomPaddingSub),
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AccountActionCard(
              controller: controller,
              subtitle: 'Adjust the recorded balance',
              account: account,
              title: 'Update Balance',
              icon: PhosphorIconsRegular.arrowsClockwise,
              onTap: () {
                Get.back();
                controller.initializeBalanceUpdate(account);
                Get.bottomSheet(
                  UpdateAccountBalanceSheet(account: account),
                  isScrollControlled: true,
                );
              },
            ),

            _AccountActionCard(
              controller: controller,
              subtitle: 'Change account details',
              account: account,
              title: 'Edit Account',
              icon: PhosphorIconsRegular.pencilSimple,
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
                  default:
                    break;
                }
              },
            ),

            _AccountActionCard(
              controller: controller,
              account: account,
              title: 'Delete Account',
              subtitle: 'Remove this account from net worth',
              icon: PhosphorIconsRegular.trash,
              onTap: () {
                Get.back();
                controller.deleteAccount(account);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountActionCard extends StatelessWidget {
  const _AccountActionCard({
    // super.key,
    required this.controller,
    required this.account,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  final AccountController controller;
  final AccountsTableData account;
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.titleL),
              Text(subtitle, style: AppTextStyle.bodyM),
            ],
          ),
        ],
      ),
      //  ListTile(
      //   contentPadding: EdgeInsets.zero,
      //   leading: const Icon(PhosphorIconsRegular.arrowsClockwise),
      //   title: const Text('Update Balance'),
      //   subtitle: const Text('Adjust the recorded balance'),
      //   onTap: () {
      //     Get.back();
      //     controller.initializeBalanceUpdate(account);
      //     Get.bottomSheet(
      //       UpdateAccountBalanceSheet(account: account),
      //       backgroundColor: Colors.transparent,
      //       isScrollControlled: true,
      //     );
      //   },
      // ),
    );
  }
}
