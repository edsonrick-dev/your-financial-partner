import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/add_transaction_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/credit_card_details_sheet/credit_card_bills_payment_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/credit_card_details_sheet/credit_card_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/credit_card_details_sheet/credit_card_transactions_view.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/card_payment_transaction/card_payment_transaction_sheet.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/spend_transaction/spend_transaction_sheet.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/anchored_action_menu.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class CreditCardPaymentInfo {
  final double amountDue;
  final DateTime paymentDueDate;

  const CreditCardPaymentInfo({
    required this.amountDue,
    required this.paymentDueDate,
  });
}

class CreditCardDetailSheet extends GetView<CreditCardController> {
  final AccountsTableData account;

  const CreditCardDetailSheet({super.key, required this.account});

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

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AppSheet(
              height: AppSheetHeight.full,
              title: account.name,
              child: Stack(
                children: [
                  Column(
                    children: [
                      CreditCardSummarySection(account: currentAccount),

                      const SizedBox(height: 16),
                      FutureBuilder<CreditCardPaymentInfo?>(
                        future: database.creditCardDao.getPaymentInfo(
                          currentAccount.id,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Text(
                              'Unable to load payment details.',
                            );
                          }

                          final paymentInfo = snapshot.data;

                          if (paymentInfo == null) {
                            return const SizedBox.shrink();
                          }

                          return Column(
                            children: [
                              Text(
                                'Next Due Date: ${paymentInfo.paymentDueDate}',
                              ),
                              Text(
                                'Amount Due: ${paymentInfo.amountDue.toCurrency()}',
                              ),
                            ],
                          );
                        },
                      ),

                      // FutureBuilder(
                      //   future: Future.wait([
                      //     database.creditCardDao.getLatestUnpaidStatement(
                      //       currentAccount.id,
                      //     ),
                      //     database.creditCardDao.getAmountDue(
                      //       currentAccount.id,
                      //     ),
                      //   ]),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return const Padding(
                      //         padding: EdgeInsets.symmetric(vertical: 8),
                      //         child: CircularProgressIndicator(),
                      //       );
                      //     }

                      //     if (snapshot.hasError || snapshot.data == null) {
                      //       return const Text(
                      //         'Unable to load payment details.',
                      //       );
                      //     }

                      //     final statement =
                      //         snapshot.data![0]
                      //             as CreditCardStatementsTableData?;

                      //     final amountDue = snapshot.data![1] as double;

                      //     // No released unpaid statement = nothing to show.
                      //     if (statement == null) {
                      //       return const SizedBox.shrink();
                      //     }

                      //     return Column(
                      //       children: [
                      //         Text(
                      //           'Next Due Date: ${statement.paymentDueDate}',
                      //         ),
                      //         Text(
                      //           'Amount Due: ₱${amountDue.toStringAsFixed(2)}',
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // ),
                      // AppSection(
                      //   child: AppButton(
                      //     // type: ButtonType.outline,
                      //     text: 'Pay Balance',
                      //     onTap: () {
                      //       AppSheets.transaction.payCreditCard(
                      //         creditCard: currentAccount,
                      //       );
                      //     },
                      //   ),
                      // ),
                      AppDetailsPageActionSection(
                        selectedIndex: selectedIndex,
                        actions: const ['Transactions', 'Payment History'],
                        addButtonLink: addButtonLink,
                        onAdd: () {
                          isAddMenuOpen.toggle();
                        },
                        isAddMenuOpen: isAddMenuOpen,
                      ),

                      Expanded(
                        child: Obx(() {
                          final currentAccount = snapshot.data;

                          if (currentAccount == null) {
                            return const Center(
                              child: Text('Account no longer exists.'),
                            );
                          }

                          return IndexedStack(
                            index: selectedIndex.value,
                            children: [
                              CreditCardTransactionsView(
                                accountId: currentAccount.id,
                              ),
                              CreditCardBillsPaymentView(
                                accountId: currentAccount.id,
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
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
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          NewTransactionButton(
                            color: colorScheme.appAccent,
                            icon: Icons.sync_alt_sharp,
                            label: 'Pay Credit Balance',
                            onTap: () {
                              AppSheets.transaction.payCreditCard(
                                creditCard: currentAccount,
                              );
                              isAddMenuOpen.toggle();
                            },
                          ),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
