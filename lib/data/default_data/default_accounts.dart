import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';

class DefaultAccount {
  final String name;
  final String iconKey;
  final AccountType type;
  final double startingBalance;
  final double? creditLimit;
  final bool isSystem;

  const DefaultAccount({
    required this.name,
    required this.iconKey,
    required this.type,
    this.startingBalance = 0,
    this.creditLimit,
    this.isSystem = false,
  });
}

class DefaultAccounts {
  static final assetAccounts = [
    // DefaultAccount(
    //   name: 'Cash Wallet',
    //   iconKey: 'wallet',
    //   type: AccountType.cash,
    //   startingBalance: 3250.00,
    //   isSystem: true,
    // ),
    // DefaultAccount(
    //   name: 'Emergency Cash',
    //   iconKey: 'wallet',
    //   type: AccountType.cash,
    //   startingBalance: 10000.00,
    //   isSystem: true,
    // ),
    // DefaultAccount(
    //   name: 'BPI Savings Account',
    //   iconKey: 'wallet',
    //   type: AccountType.savingsAccount,
    //   startingBalance: 48720.35,
    //   isSystem: true,
    // ),

    // DefaultAccount(
    //   name: 'BDO Checking',
    //   iconKey: 'wallet',
    //   type: AccountType.checkingAccount,
    //   startingBalance: 22145.8,
    //   isSystem: true,
    // ),
    // DefaultAccount(
    //   name: 'Maya Wallet',
    //   iconKey: 'wallet',
    //   type: AccountType.eWallet,
    //   startingBalance: 2890.15,
    //   isSystem: true,
    // ),
    // DefaultAccount(
    //   name: 'GCash',
    //   iconKey: 'wallet',
    //   type: AccountType.eWallet,
    //   startingBalance: 1642.5,
    //   isSystem: true,
    // ),
  ];
  static final liabilityAccounts = [
    // DefaultAccount(
    //   name: 'BPI Blue Mastercard',
    //   iconKey: 'wallet',
    //   type: AccountType.creditCard,
    //   creditLimit: 100000,
    //   startingBalance: 87154.4,
    //   isSystem: true,
    // ),
    // DefaultAccount(
    //   name: 'UnionBank Rewards Visa',
    //   iconKey: 'wallet',
    //   type: AccountType.creditCard,
    //   startingBalance: 56714.25,
    //   creditLimit: 60000,
    //   isSystem: true,
    // ),
    // DefaultAccount(
    //   name: 'Security Bank Gold',
    //   iconKey: 'wallet',
    //   type: AccountType.creditCard,
    //   startingBalance: 125149.6,
    //   creditLimit: 150000,
    //   isSystem: true,
    // ),
  ];
  static var all = [...assetAccounts, ...liabilityAccounts];
}
