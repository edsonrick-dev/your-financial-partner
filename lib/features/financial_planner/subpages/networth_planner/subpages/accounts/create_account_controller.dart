import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:drift/drift.dart' as drift;

class CreateAccountController extends GetxController {
  CreateAccountController({required this.transactionType});

  final TransactionType transactionType;

  final RxString selectedIconKey = 'wallet'.obs;

  final Rx<AddButtonState> buttonState = AddButtonState.collapsed.obs;

  final nameFocusNode = FocusNode();

  final selectedAccountType = Rxn<AccountType>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController creditLimitController = TextEditingController();
  final FocusNode creditLimitFocusNode = FocusNode();
  double? get creditLimit {
    final value = double.tryParse(
      creditLimitController.text.trim().replaceAll(',', ''),
    );

    return value;
  }

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
        // Earning money must go into an asset account.
        return AccountType.values.where((account) => account.isAsset).toList();

      case TransactionType.spend:
        // Spending can use both assets and credit cards.
        return AccountType.values;

      case TransactionType.transfer:
        // Transfers are only between asset/payment accounts.
        return AccountType.values
            .where((account) => account.group == AccountGroup.cashAndBank)
            .toList();

      case TransactionType.give:
      case TransactionType.receive:
        // Give/receive use payment accounts for the actual money movement.
        return AccountType.values
            .where((account) => account.group == AccountGroup.cashAndBank)
            .toList();
      case TransactionType.balanceUpdate:
        return [];
    }
  }

  Future<AccountsTableData?> saveAccount() async {
    final name = nameController.text.trim();

    if (name.isEmpty) return null;

    final type = selectedAccountType.value;

    if (type == null) return null;

    final parsedCreditLimit = double.tryParse(
      creditLimitController.text.trim().replaceAll(',', ''),
    );

    if (type == AccountType.creditCard &&
        (parsedCreditLimit == null || parsedCreditLimit <= 0)) {
      return null;
    }

    final insertedId = await database.accountsDao.insertAccount(
      AccountsTableCompanion.insert(
        name: name,
        icon: selectedIconKey.value,
        accountType: type.name,
        creditLimit: type == AccountType.creditCard
            ? drift.Value<double?>(parsedCreditLimit)
            : const drift.Value<double?>(null),
      ),
    );

    final createdAccount = await (database.select(
      database.accountsTable,
    )..where((tbl) => tbl.id.equals(insertedId))).getSingleOrNull();

    collapseButton();

    return createdAccount;
  }

  void selectIcon(String iconKey) {
    selectedIconKey.value = iconKey;
  }

  @override
  void onClose() {
    nameController.dispose();
    creditLimitController.dispose();
    nameFocusNode.dispose();

    super.onClose();
  }
}
