import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/forms/cash_wallet_account_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/forms/checking_account_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/forms/credit_card_account_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/forms/credit_card_installment_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/forms/ewallet_account_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/forms/real_property_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/forms/savings_account_form.dart';

class AccountFormRegistry {
  static Widget form(AccountType type) {
    switch (type) {
      case AccountType.cash:
        return const CashWalletAccountForm();

      case AccountType.savingsAccount:
        return const SavingsAccountForm();

      case AccountType.checkingAccount:
        return const CheckingAccountForm();

      case AccountType.eWallet:
        return const EWalletAccountForm();

      case AccountType.realProperty:
        return const RealPropertyForm();

      case AccountType.creditCard:
        return const CreditCardAccountForm();

      case AccountType.creditInstallment:
        return const CreditCardInstallmentForm();

      default:
        return const SizedBox.shrink();
    }
  }
}
