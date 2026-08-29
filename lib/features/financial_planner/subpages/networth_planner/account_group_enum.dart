import 'package:flutter/animation.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/balance_sheet_type_enum.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
