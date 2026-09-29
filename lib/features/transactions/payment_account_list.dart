import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_group_enum.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/add_payment_account_button.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/account_selection_card.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PaymentAccountList extends StatefulWidget {
  final TransactionType transactionType;
  final int? excludedAccountId;
  final bool isLinkedAccount;
  final AccountGroup? accountGroup;

  const PaymentAccountList({
    super.key,
    required this.transactionType,
    this.excludedAccountId,
    this.isLinkedAccount = false,
    this.accountGroup,
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

  bool _isAddAccountExpanded = false;
  void _scrollToAddAccount() {
    setState(() {
      _isAddAccountExpanded = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    });
  }
  // void _scrollToAddAccount() {
  //   if (!_scrollController.hasClients) return;

  //   _scrollController.animateTo(
  //     _scrollController.position.maxScrollExtent,
  //     duration: const Duration(milliseconds: 350),
  //     curve: Curves.easeOutCubic,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
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
          if (widget.accountGroup != null) {
            return account.group == widget.accountGroup;
          }
          switch (widget.transactionType) {
            case TransactionType.spend:
              return account.group == AccountGroup.cashAndBank ||
                  account.group == AccountGroup.creditCards;

            case TransactionType.debtRepayment:
            case TransactionType.earn:
            case TransactionType.transfer:
            case TransactionType.give:
            case TransactionType.receive:
            case TransactionType.cardPayment:
            case TransactionType.balanceUpdate:
              return account.group == AccountGroup.cashAndBank;
          }
        }).toList();
        if (filteredAccounts.isEmpty) {
          if (_isAddAccountExpanded) {
            return AddPaymentAccountButton(
              transactionType: widget.transactionType,
              onExpand: _scrollToAddAccount,
            );
          }

          return AppSection(
            child: Column(
              children: [
                Column(
                  children: [
                    Icon(
                      PhosphorIconsRegular.cardholder,
                      size: 60,
                      color: colorScheme.appAccent,
                    ),
                    Text(
                      'No Payment Accounts Yet',
                      style: AppTextStyle.headlineL,
                    ),
                    Text(
                      'Add your first account',
                      style: AppTextStyle.headlineS,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap the button below to add your first account.',
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AddPaymentAccountButton(
                  transactionType: widget.transactionType,
                  onExpand: _scrollToAddAccount,
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filteredAccounts.length + 1,
          itemBuilder: (context, index) {
            if (index == filteredAccounts.length) {
              return Column(
                children: [
                  const SizedBox(height: 12),
                  AddPaymentAccountButton(
                    transactionType: widget.transactionType,
                    onExpand: _scrollToAddAccount,
                  ),
                  SizedBox(height: context.bottomPaddingSub),
                ],
              );
            }

            final account = filteredAccounts[index];

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12), //Spacing
                  child: AccountSelectionCard(
                    account: account,
                    onTap: () {
                      Get.back(result: account);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
