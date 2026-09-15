import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/update_account_balance_sheet.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class CashAndBankAccountCard extends GetView<AccountController> {
  final AccountsTableData account;
  final VoidCallback? onTap;

  const CashAndBankAccountCard({super.key, required this.account, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final isNegative = account.currentValue < 0;
    final accountType = AccountType.fromName(account.accountType);

    final accountIcon = AppIcons.categories.resolve(accountType.iconKey);
    // final IconData? accountIcon = switch (account.accountType) {
    //   AccountType.cash.name => Icons.account_balance_wallet,
    //   'savings' => Icons.account_balance,
    //   'checking' => Icons.account_balance,
    //   'eWallet' => Icons.phone_android,
    //   _ => null,
    // };
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.6,
            child: Row(
              children: [
                Icon(accountIcon, size: 20),
                SizedBox(width: 4),
                Expanded(
                  child: Text(accountType.label, style: AppTextStyle.labelS),
                ),
                if (isNegative) ...[
                  // const SizedBox(width: 16),

                  // Expanded(
                  //   child: Text(
                  //     '',
                  //     style: AppTextStyle.labelS.copyWith(
                  //       color: colorScheme.appOutflow,
                  //     ),
                  //   ),
                  // ),
                  AdaptivePressable(
                    onTap: () {
                      controller.initializeBalanceUpdate(account);
                      Get.bottomSheet(
                        UpdateAccountBalanceSheet(account: account),
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: colorScheme.appText,
                        border: Border.all(color: colorScheme.appOutflow),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 16,
                              color: colorScheme.appOutflow,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Update balance',
                              style: AppTextStyle.labelS.copyWith(
                                color: colorScheme.appOutflow,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Icon(accountIcon, size: 24),
                    // const SizedBox(width: 12),
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
              ),
              const SizedBox(width: 8),
              Text(
                account.currentValue.toCurrency(),
                style: AppTextStyle.amountL.copyWith(
                  color: isNegative
                      ? colorScheme.appOutflow
                      : colorScheme.appInflow,
                ),
                softWrap: false,
                maxLines: 1,
                textAlign: TextAlign.right,
              ),
            ],
          ),

          // if (isNegative) ...[
          //   const SizedBox(height: 12),

          //   Container(
          //     padding: const EdgeInsets.only(
          //       left: 12,
          //       top: 4,
          //       bottom: 4,
          //       right: 4,
          //     ),
          //     decoration: BoxDecoration(
          //       color: colorScheme.appOutflow.withValues(alpha: 0.08),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     child: Row(
          //       children: [
          //         Icon(
          //           Icons.warning_amber_rounded,
          //           size: 24,
          //           color: colorScheme.appOutflow,
          //         ),

          //         const SizedBox(width: 8),

          //         Expanded(
          //           child: Text(
          //             'Balance needs updating',
          //             style: AppTextStyle.labelS.copyWith(
          //               color: colorScheme.appOutflow,
          //             ),
          //           ),
          //         ),
          //         AdaptivePressable(
          //           onTap: () {
          //             controller.initializeBalanceUpdate(account);
          //             Get.bottomSheet(
          //               UpdateAccountBalanceSheet(account: account),
          //               backgroundColor: Colors.transparent,
          //               isScrollControlled: true,
          //             );
          //           },
          //           child: Container(
          //             decoration: BoxDecoration(
          //               // color: colorScheme.appText,
          //               border: Border.all(color: colorScheme.appOutflow),
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             child: Padding(
          //               padding: EdgeInsets.symmetric(
          //                 vertical: 4,
          //                 horizontal: 8,
          //               ),
          //               child: Text(
          //                 'Update',
          //                 style: TextStyle(color: colorScheme.appOutflow),
          //               ),
          //             ),
          //           ),
          //         ),
          //         // TextButton(
          //         //   onPressed: () {
          //         //     controller.initializeBalanceUpdate(account);
          //         //     Get.bottomSheet(
          //         //       UpdateAccountBalanceSheet(account: account),
          //         //       backgroundColor: Colors.transparent,
          //         //       isScrollControlled: true,
          //         //     );
          //         //   },
          //         //   child: const Text('Update'),
          //         // ),
          //       ],
          //     ),
          //   ),

          // ],
        ],
      ),
    );
  }
}
