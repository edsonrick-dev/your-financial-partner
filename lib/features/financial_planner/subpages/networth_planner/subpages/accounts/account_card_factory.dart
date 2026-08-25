import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/cash_and_bank_account_card.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/credit_card_account_card.dart';
import 'package:getx_drift_app/features/widgets/cards/person_balance_card.dart';
import 'package:getx_drift_app/organize_THIS/net_worth_item.dart';

class AccountCardFactory {
  static Widget build(NetWorthItem item) {
    switch (item.source) {
      case NetWorthItemSource.account:
        return _buildAccountCard(item);

      case NetWorthItemSource.personalBalance:
        return PersonBalanceCard(item: item.personBalance!);
    }
  }

  static Widget _buildAccountCard(NetWorthItem item) {
    final account = item.account!;
    final type = AccountType.fromName(account.accountType);

    switch (type) {
      case AccountType.creditCard:
        return CreditCardAccountCard(
          account: account,
          onTap: () {
            AppSheets.viewCreditCardDetailSheet(account);
          },
        );

      default:
        return CashAndBankAccountCard(
          account: account,
          onTap: () {
            AppSheets.viewCashAndBankDetailSheet(account);
          },
        );
    }
  }
}
