import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';

class DefaultAccount {
  final String name;
  final String iconKey;
  final AccountType type;
  final double currentValue;
  final double? creditLimit;
  final bool isSystem;

  const DefaultAccount({
    required this.name,
    required this.iconKey,
    required this.type,
    this.currentValue = 0,
    this.creditLimit,
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
      name: 'BPI Blue Mastercard',
      iconKey: 'wallet',
      type: AccountType.creditCard,
      creditLimit: 100000,
      currentValue: 87154.4,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'UnionBank Rewards Visa',
      iconKey: 'wallet',
      type: AccountType.creditCard,
      currentValue: 56714.25,
      creditLimit: 60000,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'Security Bank Gold',
      iconKey: 'wallet',
      type: AccountType.creditCard,
      currentValue: 125149.6,
      creditLimit: 150000,
      isSystem: true,
    ),
  ];
  static var all = [...assetAccounts, ...liabilityAccounts];
}
