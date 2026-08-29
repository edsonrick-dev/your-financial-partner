import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_group_enum.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/balance_sheet_type_enum.dart';

enum AccountType {
  /// =====================================
  /// ASSETS
  /// =====================================
  cash(
    id: 'cash',
    label: 'Cash Wallet',
    group: AccountGroup.cashAndBank,
    iconKey: 'money',
  ),

  savingsAccount(
    id: 'savingsAccount',
    label: 'Savings Account',
    group: AccountGroup.cashAndBank,
    iconKey: 'bank',
  ),

  checkingAccount(
    id: 'checkingAccount',
    label: 'Checking Account',
    group: AccountGroup.cashAndBank,
    iconKey: 'bank',
  ),

  eWallet(
    id: 'eWallet',
    label: 'E-Wallet',
    group: AccountGroup.cashAndBank,
    iconKey: 'device-mobile',
  ),
  realProperty(
    id: 'realProperty',
    label: 'Real Estate Property',
    group: AccountGroup.tangibleProperty,
    iconKey: 'house',
  ),

  /// =====================================
  /// ASSETS
  /// =====================================

  creditCard(
    id: 'creditCard',
    label: 'Credit Card',
    group: AccountGroup.creditCards,
    iconKey: 'creditCard',
  ),

  creditInstallment(
    id: 'creditInstallment',
    label: 'Credit Card Installment',
    group: AccountGroup.loan,
    iconKey: 'creditCard',
  ),
  loan(id: 'loan', label: 'Loans', group: AccountGroup.loan, iconKey: 'car');

  final String id;
  final String label;
  final AccountGroup group;
  final String iconKey;

  const AccountType({
    required this.id,
    required this.label,
    required this.group,
    required this.iconKey,
  });

  bool get isAsset => group.isAsset;

  bool get isLiability => group.isLiability;

  BalanceSheetType get balanceSheetType => group.balanceSheetType;

  static AccountType fromName(String value) {
    return AccountType.values.firstWhere((e) => e.name == value);
  }
}

enum LoanType { personal, installment, mortgage, auto, other }
