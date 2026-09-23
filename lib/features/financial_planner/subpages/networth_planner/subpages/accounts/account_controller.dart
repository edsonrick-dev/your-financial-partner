import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:drift/drift.dart' as drift;
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/add_account_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/loan_detail_sheet/loan_controller.dart';
import 'package:intl/intl.dart';
import 'package:getx_drift_app/domain/credit_card/credit_card_dates.dart';

class AccountController extends GetxController {
  ///
  ///Credit Card

  final selectedStatementDate = Rxn<DateTime>();
  final selectedPaymentDueDate = Rxn<DateTime>();
  void setStatementDate(DateTime date) {
    selectedStatementDate.value = date;
  }

  void setPaymentDueDate(DateTime date) {
    selectedPaymentDueDate.value = date;
  }

  String? get formattedStatementDate {
    final value = selectedStatementDate.value;

    if (value == null) return null;

    return DateFormat('MMMM d, yyyy').format(value);
  }

  String? get formattedPaymentDueDate {
    final value = selectedPaymentDueDate.value;

    if (value == null) return null;

    return DateFormat('MMMM d, yyyy').format(value);
  }

  ///
  ///
  final LoanController loanController = Get.find<LoanController>();
  Future<void> openAddAccount(AccountType accountType) async {
    selectAccountType(accountType);

    Get.bottomSheet(
      AddAccountSheet(accountType: accountType),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(resetForm);
  }

  Future<bool> isAccountNameTaken() async {
    final name = accountName.value.trim();

    if (name.isEmpty) {
      return false;
    }

    return database.accountsDao.accountNameExists(name);
  }

  // ============================================================
  // FORM STATE
  // ============================================================
  final selectedInstitution = Rxn<EntitiesTableData>();
  void selectInstitution(EntitiesTableData institution) {
    selectedInstitution.value = institution;
  }

  final RxString accountName = ''.obs;
  void setAccountName(String value) {
    accountName.value = value;
  }

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
          accountId: drift.Value<int?>(account.id),
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

  Future<void> deleteAccount(AccountsTableData account) async {
    if (account.isSystem) {
      Get.snackbar(
        'Account cannot be deleted',
        'This account is required by Ascend.',
      );
      return;
    }

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete account?'),
        content: Text(
          'This will remove "${account.name}" from your net worth. '
          'Accounts with transaction history may need their transactions deleted first.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await database.transaction(() async {
        // Loan payment schedules are stored as bills.
        // Delete them before deleting the loan account.
        if (account.accountType == AccountType.loan.name) {
          await database.billsDao.deleteLoanBillsForAccount(account.id);
        }

        // Delete the account after its linked loan bills are gone.
        await database.accountsDao.deleteAccount(account.id);
      });
      Get.back();
      Get.snackbar('Account deleted', '${account.name} was removed.');
    } catch (_) {
      Get.snackbar(
        'Account not deleted',
        'Delete or move linked transactions before deleting this account.',
      );
    }
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

    final nameTaken = await isAccountNameTaken();

    if (nameTaken) {
      Get.snackbar(
        'Account Already Exists',
        'An account with this name already exists.',
      );
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
    if (type == AccountType.creditCard) {
      final statement = selectedStatementDate.value;
      final due = selectedPaymentDueDate.value;

      if (statement == null || due == null) {
        Get.snackbar(
          'Missing Billing Dates',
          'Select a statement date and payment due date.',
        );
        return null;
      }

      if (!due.isAfter(statement)) {
        Get.snackbar(
          'Invalid Billing Dates',
          'The payment due date must be after the statement date.',
        );
        return null;
      }
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
      // 2. Create credit card billing configuration
      if (type == AccountType.creditCard) {
        final selectedStatement = selectedStatementDate.value;
        final selectedDue = selectedPaymentDueDate.value;

        if (selectedStatement == null || selectedDue == null) {
          throw StateError(
            'Credit card statement and payment due dates are required.',
          );
        }

        final nextStatementDate = CreditCardDates.nextStatementDate(
          fromDate: DateTime.now(),
          statementDay: selectedStatement.day,
        );

        final nextPaymentDueDate = CreditCardDates.paymentDueDate(
          statementDate: nextStatementDate,
          paymentDueDay: selectedDue.day,
        );
        await database.creditCardDao.insert(
          CreditCardDetailsTableCompanion.insert(
            accountId: drift.Value(insertedId),
            statementDay: selectedStatement.day,
            paymentDueDay: selectedDue.day,
            nextStatementDate: nextStatementDate,
            nextPaymentDueDate: nextPaymentDueDate,
          ),
        );
        // await database
        //     .into(database.creditCardDetailsTable)
        //     .insert(
        //       CreditCardDetailsTableCompanion.insert(
        //         accountId: drift.Value(insertedId),

        //         statementDay: selectedStatement.day,
        //         paymentDueDay: selectedDue.day,

        //         nextStatementDate: nextStatementDate,
        //         nextPaymentDueDate: nextPaymentDueDate,
        //       ),
        //     );

        // Initialize exactly one open billing period
        final previousStatementDate = CreditCardDates.previousStatementDate(
          statementDate: nextStatementDate,
          statementDay: selectedStatement.day,
        );

        final billingPeriodStartDate = previousStatementDate.add(
          const Duration(days: 1),
        );

        final billingPeriodId = await database.creditCardDao
            .createInitialBillingPeriod(
              accountId: insertedId,
              startDate: billingPeriodStartDate,
              endDate: nextStatementDate,
            );

        debugPrint('=== CREDIT CARD CREATION ===');
        debugPrint('accountId: $insertedId');
        debugPrint('nextStatementDate: $nextStatementDate');
        debugPrint('previousStatementDate: $previousStatementDate');
        debugPrint('billingPeriodStartDate: $billingPeriodStartDate');
        debugPrint('billingPeriodId: $billingPeriodId');
        // final billId = await database.billsDao.insertBill(
        //   BillsTableCompanion.insert(
        //     name: '$name Statement',
        //     categoryId: const drift.Value(null),
        //     accountId: drift.Value(insertedId),
        //     expectedAmount: const drift.Value(null),
        //     frequency: BillsFrequency.monthly.name,
        //     dayOfMonth: drift.Value(nextPaymentDueDate.day),
        //   ),
        // );
      }
      // 3. Create initial balance transaction
      if (initialBalance >= 0) {
        await database.transactionsDao.insertTransaction(
          TransactionsTableCompanion.insert(
            amount: initialBalance,
            date: DateTime.now(),
            transactionType: TransactionType.balanceUpdate.name,
            accountId: drift.Value<int?>(insertedId),
            categoryId: const drift.Value(null),
            note: const drift.Value('Initial balance'),
            createdAt: drift.Value(DateTime.now()),
            updatedAt: drift.Value(DateTime.now()),
          ),
        );
      }

      // 4. Rebuild calculated balance
      await database.accountsDao.rebuildAccountBalance(insertedId);

      // 5. Return created account
      final createdAccount = await (database.select(
        database.accountsTable,
      )..where((tbl) => tbl.id.equals(insertedId))).getSingleOrNull();

      resetForm();

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
    selectedStatementDate.value = null;
    selectedPaymentDueDate.value = null;
    nameController.clear();
    accountName.value = '';

    bankNameController.clear();

    enteredBalance.value = 0;
    enteredCreditLimit.value = 0;

    selectedInstitution.value = null;
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
