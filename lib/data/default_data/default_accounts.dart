import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';

class DefaultAccount {
  final String name;
  final String iconKey;
  final String type;
  // final String group;
  final bool isSystem;

  const DefaultAccount({
    required this.name,
    required this.iconKey,
    required this.type,
    // required this.group,
    this.isSystem = false,
  });
}

class DefaultAccounts {
  static final assetAccounts = [
    DefaultAccount(
      name: 'Cash Wallet',
      iconKey: 'wallet',
      type: AccountType.cash.name,
      // group: AccountGroup.paymentAccount.name,
      isSystem: true,
    ),

    DefaultAccount(
      name: 'Savings Account',
      iconKey: 'wallet',
      type: AccountType.savingsAccount.name,
      // group: AccountGroup.paymentAccount.name,
      isSystem: true,
    ),
  ];
  static final liabilityAccounts = [
    DefaultAccount(
      name: 'Credit Card',
      iconKey: 'wallet',
      // group: AccountGroup.paymentAccount.name,
      type: AccountType.creditCard.name,
      isSystem: true,
    ),
  ];
  static var all = [...assetAccounts];
}

enum NetWorthType { asset, liability }
