import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_group_enum.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/add_payment_account_button.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/select_account_card.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';

class PaymentAccountList extends StatefulWidget {
  final TransactionType transactionType;
  final int? excludedAccountId;

  const PaymentAccountList({
    super.key,
    required this.transactionType,
    this.excludedAccountId,
  });

  @override
  State<PaymentAccountList> createState() => _PaymentAccountListState();
}

class _PaymentAccountListState extends State<PaymentAccountList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToAddAccount() {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: database.accountsDao.watchAccounts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final accounts = snapshot.data ?? [];

        final filteredAccounts = accounts.where((account) {
          if (widget.excludedAccountId != null &&
              account.id == widget.excludedAccountId) {
            return false;
          }

          switch (widget.transactionType) {
            case TransactionType.spend:
              return account.group == AccountGroup.cashAndBank ||
                  account.group == AccountGroup.creditCards;

            case TransactionType.earn:
            case TransactionType.transfer:
            case TransactionType.give:
            case TransactionType.receive:
            case TransactionType.balanceUpdate:
              return account.group == AccountGroup.cashAndBank;
          }
        }).toList();

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filteredAccounts.length + 1,
          itemBuilder: (context, index) {
            if (index == filteredAccounts.length) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 36),
                child: AddPaymentAccountButton(
                  transactionType: widget.transactionType,
                  onExpand: _scrollToAddAccount,
                ),
              );
            }

            final account = filteredAccounts[index];

            return filteredAccounts.isEmpty
                ? Text('Add mo first account ngani!')
                : Padding(
                    padding: const EdgeInsets.only(bottom: 12), //Spacing
                    child: SelectAccountCard(
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
