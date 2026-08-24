import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:drift/drift.dart' as drift;

class AccountController extends GetxController {
  // ============================================================
  // FORM STATE
  // ============================================================

  final TextEditingController nameController = TextEditingController();

  final TextEditingController bankNameController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();

  final FocusNode bankNameFocusNode = FocusNode();

  final selectedAccountType = Rxn<AccountType>();

  final RxString selectedIconKey = 'wallet'.obs;

  final Rx<AddButtonState> buttonState = AddButtonState.collapsed.obs;

  // ============================================================
  // MONETARY STATE
  // ============================================================

  /// Initial/current balance entered through AppAmountField.
  final RxDouble enteredBalance = 0.0.obs;

  /// Credit limit entered through AppAmountField.
  final RxDouble enteredCreditLimit = 0.0.obs;

  // ============================================================
  // BALANCE UPDATE
  // ============================================================

  void initializeBalanceUpdate(AccountsTableData account) {
    enteredBalance.value = account.currentValue;
  }

  double get actualBalance => enteredBalance.value;

  double getBalanceAdjustment(double currentBalance) {
    return actualBalance - currentBalance;
  }

  // ============================================================
  // ACCOUNT EDITING
  // ============================================================

  void initializeEditAccount(AccountsTableData account) {
    nameController.text = account.name;

    enteredCreditLimit.value = account.creditLimit ?? 0;
  }

  // ============================================================
  // ACCOUNT TYPE
  // ============================================================

  void selectAccountType(AccountType type) {
    selectedAccountType.value = type;
  }

  // ============================================================
  // ACCOUNT BUTTON
  // ============================================================

  void expandButton() {
    buttonState.value = AddButtonState.expanded;
  }

  void collapseButton() {
    buttonState.value = AddButtonState.collapsed;
  }

  // ============================================================
  // UPDATE ACCOUNT DETAILS
  // ============================================================

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

  // ============================================================
  // UPDATE ACCOUNT BALANCE
  // ============================================================

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

    enteredBalance.value = 0;

    Get.back();
  }

  // ============================================================
  // UPDATE CREDIT CARD
  // ============================================================

  Future<void> updateCreditCardDetails(AccountsTableData account) async {
    final name = nameController.text.trim();
    final creditLimit = enteredCreditLimit.value;

    if (name.isEmpty) {
      Get.snackbar('Missing Account Name', 'Enter an account name.');
      return;
    }

    if (creditLimit <= 0) {
      Get.snackbar('Invalid Credit Limit', 'Enter a valid credit limit.');
      return;
    }

    await database.accountsDao.updateAccount(
      account.id,
      AccountsTableCompanion(
        name: drift.Value(name),
        creditLimit: drift.Value(creditLimit),
      ),
    );

    nameController.clear();
    enteredCreditLimit.value = 0;

    Get.back();
  }

  // ============================================================
  // CREATE ACCOUNT
  // ============================================================

  Future<AccountsTableData?> saveAccount() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      return null;
    }

    final type = selectedAccountType.value;

    if (type == null) {
      return null;
    }

    final initialBalance = enteredBalance.value;
    final creditLimit = enteredCreditLimit.value;

    if (initialBalance < 0) {
      Get.snackbar('Invalid Balance', 'Initial balance cannot be negative.');
      return null;
    }

    if (type == AccountType.creditCard && creditLimit <= 0) {
      Get.snackbar('Invalid Credit Limit', 'Enter a valid credit limit.');
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
              ? drift.Value<double?>(creditLimit)
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

  // ============================================================
  // ICON
  // ============================================================

  void selectIcon(String iconKey) {
    selectedIconKey.value = iconKey;
  }

  // ============================================================
  // RESET
  // ============================================================

  void resetForm() {
    nameController.clear();
    bankNameController.clear();

    enteredBalance.value = 0;
    enteredCreditLimit.value = 0;

    selectedAccountType.value = null;
    selectedIconKey.value = 'wallet';

    collapseButton();
  }

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void onClose() {
    nameController.dispose();
    bankNameController.dispose();

    nameFocusNode.dispose();
    bankNameFocusNode.dispose();

    super.onClose();
  }
}
