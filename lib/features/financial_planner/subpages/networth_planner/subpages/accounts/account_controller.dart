import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:drift/drift.dart' as drift;

class AccountController extends GetxController {
  void initializeEditAccount(AccountsTableData account) {
    nameController.text = account.name;

    // bankNameController.text = account.bankName ?? '';

    creditLimitController.text = account.creditLimit?.toStringAsFixed(2) ?? '';

    balanceController.clear();
  }

  double get initialBalance {
    return double.tryParse(balanceController.text.trim().replaceAll(',', '')) ??
        0;
  }

  final TextEditingController balanceController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final FocusNode bankNameFocusNode = FocusNode();
  final FocusNode balanceFocusNode = FocusNode();
  final RxDouble enteredBalance = 0.0.obs;
  void onBalanceChanged(String value) {
    enteredBalance.value =
        double.tryParse(value.replaceAll(',', '').trim()) ?? 0;
  }

  double get actualBalance => enteredBalance.value;

  double getBalanceAdjustment(double currentBalance) {
    return actualBalance - currentBalance;
  }

  Future<void> updateAccountDetails(AccountsTableData account) async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      Get.snackbar('Missing Account Name', 'Enter an account name.');
      return;
    }

    await database.accountsDao.updateAccount(
      account.id,
      AccountsTableCompanion(name: drift.Value(name)),
    );

    nameController.clear();

    Get.back();
  }

  Future<void> updateAccountBalance(AccountsTableData account) async {
    final actual = actualBalance;
    final adjustment = actual - account.currentValue;

    if (actual < 0) {
      Get.snackbar('Invalid Balance', 'Balance cannot be negative.');
      return;
    }

    if (adjustment == 0) {
      Get.back();
      return;
    }

    await database.transaction(() async {
      await database.transactionsDao.insertTransaction(
        TransactionsTableCompanion.insert(
          amount: adjustment,
          date: DateTime.now(),
          transactionType: TransactionType.balanceUpdate.name,
          accountId: account.id,
          categoryId: const drift.Value(null),
          note: const drift.Value(null),
          createdAt: drift.Value(DateTime.now()),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );

      await database.accountsDao.rebuildAccountBalance(account.id);
    });

    balanceController.clear();

    Get.back();
  }

  final RxString selectedIconKey = 'wallet'.obs;

  final Rx<AddButtonState> buttonState = AddButtonState.collapsed.obs;

  final nameFocusNode = FocusNode();

  final selectedAccountType = Rxn<AccountType>();
  Future<void> updateCreditCardDetails(AccountsTableData account) async {
    final name = nameController.text.trim();
    final creditLimitValue = creditLimit;

    if (name.isEmpty) {
      Get.snackbar('Missing Account Name', 'Enter an account name.');
      return;
    }

    if (creditLimitValue == null || creditLimitValue <= 0) {
      Get.snackbar('Invalid Credit Limit', 'Enter a valid credit limit.');
      return;
    }

    await database.accountsDao.updateAccount(
      account.id,
      AccountsTableCompanion(
        name: drift.Value(name),
        creditLimit: drift.Value(creditLimitValue),
      ),
    );

    nameController.clear();
    creditLimitController.clear();
    bankNameController.clear();

    Get.back();
  }

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

  Future<AccountsTableData?> saveAccount({double initialBalance = 0}) async {
    final name = nameController.text.trim();

    if (name.isEmpty) return null;

    final type = selectedAccountType.value;

    if (type == null) return null;

    if (initialBalance < 0) {
      Get.snackbar('Invalid Balance', 'Initial balance cannot be negative.');
      return null;
    }

    final parsedCreditLimit = double.tryParse(
      creditLimitController.text.trim().replaceAll(',', ''),
    );

    if (type == AccountType.creditCard &&
        (parsedCreditLimit == null || parsedCreditLimit <= 0)) {
      return null;
    }

    return await database.transaction(() async {
      // 1. Create account
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

      // 2. Create initial balance transaction
      if (initialBalance > 0) {
        await database.transactionsDao.insertTransaction(
          TransactionsTableCompanion.insert(
            amount: initialBalance,
            date: DateTime.now(),
            transactionType: TransactionType.balanceUpdate.name,
            accountId: insertedId,
            categoryId: const drift.Value(null),
            note: const drift.Value('Initial balance'),
            createdAt: drift.Value(DateTime.now()),
            updatedAt: drift.Value(DateTime.now()),
          ),
        );
      }

      // 3. Rebuild calculated balance
      await database.accountsDao.rebuildAccountBalance(insertedId);

      // 4. Return created account
      final createdAccount = await (database.select(
        database.accountsTable,
      )..where((tbl) => tbl.id.equals(insertedId))).getSingleOrNull();

      collapseButton();

      return createdAccount;
    });
  }

  void selectIcon(String iconKey) {
    selectedIconKey.value = iconKey;
  }

  @override
  void onClose() {
    nameController.dispose();
    creditLimitController.dispose();
    bankNameController.dispose();

    nameFocusNode.dispose();
    creditLimitFocusNode.dispose();
    bankNameFocusNode.dispose();

    balanceController.dispose();

    super.onClose();
  }

  final TextEditingController amountController = TextEditingController();
}
