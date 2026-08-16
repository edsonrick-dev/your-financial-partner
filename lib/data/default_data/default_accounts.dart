import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';

class DefaultAccount {
  final String name;
  final String iconKey;
  final AccountType type;
  final double currentValue;
  final bool isSystem;

  const DefaultAccount({
    required this.name,
    required this.iconKey,
    required this.type,
    this.currentValue = 0,
    this.isSystem = false,
  });
}

class DefaultAccounts {
  static final assetAccounts = [
    DefaultAccount(
      name: 'Cash Wallet',
      iconKey: 'wallet',
      type: AccountType.cash,
      currentValue: 3250.00,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'Emergency Cash',
      iconKey: 'wallet',
      type: AccountType.cash,
      currentValue: 10000.00,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'BPI Savings Account',
      iconKey: 'wallet',
      type: AccountType.savingsAccount,
      currentValue: 48720.35,
      isSystem: true,
    ),

    DefaultAccount(
      name: 'BDO Checking',
      iconKey: 'wallet',
      type: AccountType.checkingAccount,
      currentValue: 22145.8,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'Maya Wallet',
      iconKey: 'wallet',
      type: AccountType.eWallet,
      currentValue: 2890.15,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'GCash',
      iconKey: 'wallet',
      type: AccountType.eWallet,
      currentValue: 1642.5,
      isSystem: true,
    ),
  ];
  static final liabilityAccounts = [
    DefaultAccount(
      name: 'Credit Card',
      iconKey: 'wallet',
      type: AccountType.creditCard,
      isSystem: true,
    ),
  ];
  static var all = [...assetAccounts];
}

enum NetWorthType { asset, liability }
