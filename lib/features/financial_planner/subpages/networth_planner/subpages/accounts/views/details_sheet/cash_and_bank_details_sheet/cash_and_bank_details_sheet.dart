import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/cash_and_bank_reservation_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/cash_and_bank_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/cash_and_bank_transactions_view.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_page_action_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class CashAndBankDetailsSheet extends StatelessWidget {
  final AccountsTableData account;

  const CashAndBankDetailsSheet({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;

    return AppSheet(
      height: AppSheetHeight.full,
      title: account.name,
      child: StreamBuilder<AccountsTableData?>(
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

          return Column(
            children: [
              CashAndBankSummarySection(account: currentAccount),

              AppDetailsPageActionSection(
                selectedIndex: selectedIndex,
                actions: const ['Transactions', 'Goal Reservation'],
                onAdd: () {},
              ),

              Expanded(
                child: Obx(
                  () => IndexedStack(
                    index: selectedIndex.value,
                    children: [
                      CashAndBankTransactionsView(accountId: currentAccount.id),

                      CashAndBankReservationView(accountId: currentAccount.id),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
