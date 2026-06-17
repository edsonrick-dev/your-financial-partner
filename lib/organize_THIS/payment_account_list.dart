import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/organize_THIS/add_payment_account_button.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/account_card.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class PaymentAccountList extends StatelessWidget {
  final TransactionType transactionType;
  final int? excludedAccountId;
  const PaymentAccountList({
    super.key,
    required this.transactionType,
    this.excludedAccountId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: database.accountsDao.watchAccounts(),

      builder: (context, snapshot) {
        /// LOADING

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        /// ERROR

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final accounts = snapshot.data ?? [];

        final filteredAccounts = accounts.where((account) {
          /// ✅ EXCLUDE SAME ACCOUNT
          if (excludedAccountId != null && account.id == excludedAccountId) {
            return false;
          }
          final type = AccountType.fromName(account.accountType);

          /// ✅ EARN FILTER
          if (transactionType == TransactionType.earn) {
            return type.flow == FlowDirection.positive;
          }

          return true;
        }).toList();

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          itemCount: filteredAccounts.length + 1,

          itemBuilder: (context, index) {
            /// LAST ITEM
            /// ADD CATEGORY BUTTON

            if (index == filteredAccounts.length) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 36),

                child: AddPaymentAccountButton(
                  transactionType: transactionType,
                ),
                // GestureDetector(
                //   onTap: () {
                //     AppSheets.createPaymentAccount();
                //   },

                //   child: Container(
                //     alignment: Alignment.center,

                //     constraints: const BoxConstraints(minHeight: 44),

                //     width: double.infinity,

                //     decoration: BoxDecoration(
                //       color: Colors.grey[200],

                //       borderRadius: BorderRadius.circular(999),
                //     ),

                //     child: const Text('Add New Payment Account'),
                //   ),
                // ),
              );
            }

            /// CATEGORY ITEM

            final account = filteredAccounts[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),

              child: AccountCard(
                account: account,

                onTap: () {
                  Get.back(result: account);
                },
              ),
            );
          },
        );
      },
    );
  }
}
