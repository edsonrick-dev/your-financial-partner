import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum BalanceSheetType { asset, liability }

enum AccountGroup {
  cashAndBank(
    label: 'Cash & Bank',
    icon: PhosphorIconsRegular.money,
    color: Color(0xFF00B85A),
    balanceSheetType: BalanceSheetType.asset,
  ),

  receivable(
    label: 'Receivables',
    icon: PhosphorIconsRegular.handDeposit,
    color: Color(0xFF1683FF),
    balanceSheetType: BalanceSheetType.asset,
  ),

  tangibleProperty(
    label: 'Tangible Properties',
    icon: PhosphorIconsRegular.warehouse,
    color: Color(0xFFFF9F0A),
    balanceSheetType: BalanceSheetType.asset,
  ),

  intangibleProperty(
    label: 'Intangible Properties',
    icon: PhosphorIconsRegular.handWithdraw,
    color: Color(0xFF8E5CF6),
    balanceSheetType: BalanceSheetType.asset,
  ),

  creditCards(
    label: 'Credit Cards',
    icon: PhosphorIconsRegular.creditCard,
    color: Color(0xFFFF3B30),
    balanceSheetType: BalanceSheetType.liability,
  ),

  payable(
    label: 'Payables',
    icon: PhosphorIconsRegular.receipt,
    color: Color(0xFFFF6B35),
    balanceSheetType: BalanceSheetType.liability,
  ),

  loan(
    label: 'Loans',
    icon: PhosphorIconsRegular.bank,
    color: Color(0xFF8E5CF6),
    balanceSheetType: BalanceSheetType.liability,
  );

  final String label;
  final PhosphorIconData icon;
  final Color color;
  final BalanceSheetType balanceSheetType;

  const AccountGroup({
    required this.label,
    required this.icon,
    required this.color,
    required this.balanceSheetType,
  });

  bool get isAsset => balanceSheetType == BalanceSheetType.asset;

  bool get isLiability => balanceSheetType == BalanceSheetType.liability;
}

enum AccountType {
  cash(id: 'cash', label: 'Cash', group: AccountGroup.cashAndBank),

  savingsAccount(
    id: 'savingsAccount',
    label: 'Savings Account',
    group: AccountGroup.cashAndBank,
  ),

  checkingAccount(
    id: 'checkingAccount',
    label: 'Checking',
    group: AccountGroup.cashAndBank,
  ),

  eWallet(id: 'eWallet', label: 'E-Wallet', group: AccountGroup.cashAndBank),

  creditCard(
    id: 'creditCard',
    label: 'Credit Card',
    group: AccountGroup.creditCards,
  );

  final String id;
  final String label;
  final AccountGroup group;

  const AccountType({
    required this.id,
    required this.label,
    required this.group,
  });

  bool get isAsset => group.isAsset;

  bool get isLiability => group.isLiability;

  BalanceSheetType get balanceSheetType => group.balanceSheetType;

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

  final TextEditingController nameController = TextEditingController();

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
    nameFocusNode.dispose();
    super.onClose();
  }
}
