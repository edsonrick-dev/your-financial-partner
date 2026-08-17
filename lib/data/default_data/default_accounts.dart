import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';

class DefaultAccount {
  final String name;
  final String iconKey;
  final AccountType type;
  final double availableFund;
  final bool isSystem;

  const DefaultAccount({
    required this.name,
    required this.iconKey,
    required this.type,
    this.availableFund = 0,
    this.isSystem = false,
  });
}

class DefaultAccounts {
  static final assetAccounts = [
    DefaultAccount(
      name: 'Cash Wallet',
      iconKey: 'wallet',
      type: AccountType.cash,
      availableFund: 3250.00,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'Emergency Cash',
      iconKey: 'wallet',
      type: AccountType.cash,
      availableFund: 10000.00,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'BPI Savings Account',
      iconKey: 'wallet',
      type: AccountType.savingsAccount,
      availableFund: 48720.35,
      isSystem: true,
    ),

    DefaultAccount(
      name: 'BDO Checking',
      iconKey: 'wallet',
      type: AccountType.checkingAccount,
      availableFund: 22145.8,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'Maya Wallet',
      iconKey: 'wallet',
      type: AccountType.eWallet,
      availableFund: 2890.15,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'GCash',
      iconKey: 'wallet',
      type: AccountType.eWallet,
      availableFund: 1642.5,
      isSystem: true,
    ),
  ];
  static final liabilityAccounts = [
    DefaultAccount(
      name: 'BPI Blue MasterCard',
      iconKey: 'wallet',
      type: AccountType.creditCard,
      availableFund: 87154.4,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'UnionBank Rewards Visa',
      iconKey: 'wallet',
      type: AccountType.creditCard,
      availableFund: 56714.25,
      isSystem: true,
    ),
    DefaultAccount(
      name: 'Security Bank Gold',
      iconKey: 'wallet',
      type: AccountType.creditCard,
      availableFund: 125149.6,
      isSystem: true,
    ),
  ];
  static var all = [...assetAccounts, ...liabilityAccounts];
}

enum NetWorthType { asset, liability }
