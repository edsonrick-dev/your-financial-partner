import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/cash_and_bank_account_card.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/credit_card_account_card.dart';

class AccountCardFactory {
  static Widget build(AccountsTableData account) {
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
