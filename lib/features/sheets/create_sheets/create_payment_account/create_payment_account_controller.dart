import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

enum AccountGroup {
  paymentAccount, // May include both assets and liabilities (credit card)
  receivable,
  payable,
  tangibleProperty,
  intangibleProperty,
  loan,
}

enum FlowDirection { positive, negative }

enum AccountType {
  cash(
    id: 'cash',
    label: 'Cash',
    group: AccountGroup.paymentAccount,
    flow: FlowDirection.positive,
  ),
  savingsAccount(
    id: 'savingsAccount',
    label: 'Savings Account',
    group: AccountGroup.paymentAccount,
    flow: FlowDirection.positive,
  ),
  checkingAccount(
    id: 'checkingAccount',
    label: 'Checking',
    group: AccountGroup.paymentAccount,
    flow: FlowDirection.positive,
  ),
  eWallet(
    id: 'eWallet',
    label: 'E-Wallet',
    group: AccountGroup.paymentAccount,
    flow: FlowDirection.positive,
  ),

  creditCard(
    id: 'creditCard',
    label: 'Credit Card',
    group: AccountGroup.paymentAccount,
    flow: FlowDirection.negative,
  );

  // cash, savingsAccount, checkingAccount, eWallet, creditCard
  final String label;
  final FlowDirection flow;
  final AccountGroup group;
  final String id;

  const AccountType({
    required this.id,
    required this.label,
    required this.group,
    required this.flow,
  });
  static AccountType fromName(String value) {
    return AccountType.values.firstWhere((e) => e.name == value);
  }
}

class CreateAccountController extends GetxController {
  CreateAccountController({required this.transactionType});

  final TransactionType transactionType;
  final RxString selectedIconKey = 'wallet'.obs;
  final Rx<AddButtonState> buttonState = AddButtonState.collapsed.obs;
  final nameFocusNode = FocusNode();
  final selectedAccountType = Rxn<AccountType>();
  void selectAccountType(AccountType type) {
    selectedAccountType.value = type;
  }

  void expandButton() {
    buttonState.value = AddButtonState.expanded;
  }

  void collapseButton() {
    buttonState.value = AddButtonState.collapsed;
  }

  List<AccountType> get availableAccountTypes {
    switch (transactionType) {
      case TransactionType.earn:
        return AccountType.values
            .where((e) => e.flow == FlowDirection.positive)
            .toList();

      case TransactionType.spend:
        return AccountType.values;

      case TransactionType.transfer:
        return AccountType.values
            .where((e) => e != AccountType.creditCard)
            .toList();

      default:
        return AccountType.values;
    }
  }

  Future<AccountsTableData?> saveAccount() async {
    final name = nameController.text.trim();

    if (name.isEmpty) return null;

    final type = selectedAccountType.value;

    if (type == null) return null;

    final insertedId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: name,
        icon: selectedIconKey.value,
        accountType: type.name,
        accountGroup: type.group.name,
      ),
    );

    final createdAccount = await (database.select(
      database.accountsTable,
    )..where((tbl) => tbl.id.equals(insertedId))).getSingleOrNull();

    collapseButton();

    return createdAccount;
  }

  final TextEditingController nameController = TextEditingController();
  void selectIcon(String iconKey) {
    selectedIconKey.value = iconKey;
  }
}
