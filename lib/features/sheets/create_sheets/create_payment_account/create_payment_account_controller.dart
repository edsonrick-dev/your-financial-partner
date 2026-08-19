import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum BalanceSheetType { asset, liability }

enum AccountGroup {
  cashAndBank(
    label: 'Cash & Bank',
    icon: PhosphorIconsRegular.money,
    color: Color(0xFF00B85A),
    balanceSheetType: BalanceSheetType.asset,
  ),

  receivable(
    label: 'Receivables',
    icon: PhosphorIconsRegular.handDeposit,
    color: Color(0xFF1683FF),
    balanceSheetType: BalanceSheetType.asset,
  ),

  tangibleProperty(
    label: 'Tangible Properties',
    icon: PhosphorIconsRegular.warehouse,
    color: Color(0xFFFF9F0A),
    balanceSheetType: BalanceSheetType.asset,
  ),

  intangibleProperty(
    label: 'Intangible Properties',
    icon: PhosphorIconsRegular.handWithdraw,
    color: Color(0xFF8E5CF6),
    balanceSheetType: BalanceSheetType.asset,
  ),

  creditCards(
    label: 'Credit Cards',
    icon: PhosphorIconsRegular.creditCard,
    color: Color(0xFFFF3B30),
    balanceSheetType: BalanceSheetType.liability,
  ),

  payable(
    label: 'Payables',
    icon: PhosphorIconsRegular.receipt,
    color: Color(0xFFFF6B35),
    balanceSheetType: BalanceSheetType.liability,
  ),

  loan(
    label: 'Loans',
    icon: PhosphorIconsRegular.bank,
    color: Color(0xFF8E5CF6),
    balanceSheetType: BalanceSheetType.liability,
  );

  final String label;
  final PhosphorIconData icon;
  final Color color;
  final BalanceSheetType balanceSheetType;

  const AccountGroup({
    required this.label,
    required this.icon,
    required this.color,
    required this.balanceSheetType,
  });

  bool get isAsset => balanceSheetType == BalanceSheetType.asset;

  bool get isLiability => balanceSheetType == BalanceSheetType.liability;
}

enum AccountType {
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

  creditCard(
    id: 'creditCard',
    label: 'Credit Card',
    group: AccountGroup.creditCards,
    iconKey: 'creditCard',
  );

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
