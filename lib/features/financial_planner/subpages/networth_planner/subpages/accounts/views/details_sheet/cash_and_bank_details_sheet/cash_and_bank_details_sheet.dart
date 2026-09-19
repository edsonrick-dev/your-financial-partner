import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/add_transaction_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/cash_and_bank_reservation_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/cash_and_bank_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/cash_and_bank_transactions_view.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/anchored_action_menu.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashAndBankDetailsSheet extends StatelessWidget {
  final AccountsTableData account;

  const CashAndBankDetailsSheet({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;
    final colorScheme = context.colors;
    final LayerLink addButtonLink = LayerLink();
    final RxBool isAddMenuOpen = false.obs;
    return StreamBuilder<AccountsTableData?>(
      stream: database.accountsDao.watchAccount(account.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Unable to load account.'));
        }

        final currentAccount = snapshot.data;

        if (currentAccount == null) {
          return const Center(child: Text('Account no longer exists.'));
        }

        return AppSheet(
          height: AppSheetHeight.full,

          // ✅ This now comes from the streamed account
          title: currentAccount.name,

          child: Stack(
            children: [
              Column(
                children: [
                  CashAndBankSummarySection(account: currentAccount),

                  AppDetailsPageActionSection(
                    selectedIndex: selectedIndex,
                    actions: const ['Transactions', 'Goal Reservation'],
                    addButtonLink: addButtonLink,
                    onAdd: () {
                      isAddMenuOpen.toggle();
                    },
                    isAddMenuOpen: isAddMenuOpen,
                  ),

                  Expanded(
                    child: Obx(
                      () => IndexedStack(
                        index: selectedIndex.value,
                        children: [
                          CashAndBankTransactionsView(
                            accountId: currentAccount.id,
                          ),
                          CashAndBankReservationView(
                            accountId: currentAccount.id,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => AnchoredActionMenu(
                  isOpen: isAddMenuOpen.value,
                  link: addButtonLink,
                  onDismiss: () {
                    isAddMenuOpen.value = false;
                  },
                  child: selectedIndex.value == 0
                      ? Column(
                          spacing: 12,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            NewTransactionButton(
                              color: colorScheme.appInflow,
                              icon: Icons.add,
                              label: 'Earn Money',
                              onTap: () {
                                AppSheets.transaction.earn(
                                  account: currentAccount,
                                );
                                isAddMenuOpen.toggle();
                              },
                            ),
                            NewTransactionButton(
                              color: colorScheme.appOutflow,
                              icon: Icons.remove,
                              label: 'Spend Money',
                              onTap: () {
                                AppSheets.transaction.spend(
                                  account: currentAccount,
                                );
                                isAddMenuOpen.toggle();
                              },
                            ),
                            NewTransactionButton(
                              color: colorScheme.appAccent,
                              icon: Icons.sync_alt_sharp,
                              label: 'Transfer Money',
                              onTap: () {
                                AppSheets.transaction.transfer(
                                  fromAccount: currentAccount,
                                );
                                isAddMenuOpen.toggle();
                              },
                            ),
                            NewTransactionButton(
                              color: colorScheme.appInflow,
                              icon: PhosphorIconsRegular.handCoins,
                              label: 'Receive Money',
                              onTap: () {
                                AppSheets.transaction.receiveMoney(
                                  account: currentAccount,
                                );
                                isAddMenuOpen.toggle();
                              },
                            ),
                            NewTransactionButton(
                              color: colorScheme.appOutflow,
                              icon: PhosphorIconsRegular.handDeposit,
                              label: 'Give Money',
                              onTap: () {
                                AppSheets.transaction.giveMoney(
                                  account: currentAccount,
                                );
                                isAddMenuOpen.toggle();
                              },
                            ),
                          ],
                        )
                      : const Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [Text('Add Goal Reservation')],
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
