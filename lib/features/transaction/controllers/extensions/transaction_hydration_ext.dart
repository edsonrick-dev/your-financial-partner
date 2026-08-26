import 'package:getx_drift_app/features/sheets/transaction_sheets/spend_transaction_sheet.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';
import 'package:getx_drift_app/data/models/participant_model.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

extension TransactionHydration on TransactionController {
  void resetForm() {
    editingTransaction.value = null;

    selectedDate.value = DateTime.now();

    selectedCategory.value = null;

    selectedAccount.value = null;

    selectedLinkedAccount.value = null;
    noteController.clear();
    amount.value = 0;
    selectedPerson.value = null;
    selectedPersonBalance.value = null;
    amountController.clear();
    isSharedExpense.value = false;
    isDebt.value = false;
    participants.clear();
  }

  void loadEarnTransaction(TransactionWithDetails item) {
    editingTransaction.value = item;
    selectedDate.value = item.transaction.date;
    selectedCategory.value = item.category;
    selectedAccount.value = item.account;
    amount.value = item.transaction.amount;
    amountController.text = item.transaction.amount.toCurrency();
  }

  void loadGiveMoneyTransaction(TransactionWithDetails item) {
    editingTransaction.value = item;

    selectedDate.value = item.transaction.date;
    selectedAccount.value = item.account;
    amount.value = item.transaction.amount;
    if (item.participants.isNotEmpty) {
      selectedPerson.value = item.participants.first.entity;
    }

    isDebt.value = item.hasDebtImpact;
    amountController.text = item.transaction.amount.toCurrency();
  }

  void loadReceiveMoneyTransaction(TransactionWithDetails item) {
    editingTransaction.value = item;

    selectedDate.value = item.transaction.date;
    selectedAccount.value = item.account;
    amount.value = item.transaction.amount;
    if (item.participants.isNotEmpty) {
      selectedPerson.value = item.participants.first.entity;
    }

    isDebt.value = item.hasDebtImpact;
    amountController.text = item.transaction.amount.toCurrency();
  }

  void loadSpendTransaction(TransactionWithDetails item) {
    editingTransaction.value = item;

    // BASIC
    selectedDate.value = item.transaction.date;
    selectedCategory.value = item.category;
    amount.value = item.transaction.amount;
    amountController.text = item.transaction.amount.toCurrency();

    // ----------------------------------------------------------
    // PAID BY
    // ----------------------------------------------------------

    if (item.account != null) {
      paidBy.value = PaidBy.self;
      selectedAccount.value = item.account;
      selectedPerson.value = null;
    } else {
      paidBy.value = PaidBy.others;
      selectedAccount.value = null;

      final payer = item.participants.isNotEmpty
          ? item.participants.first
          : null;

      selectedPerson.value = payer?.entity;
    }

    // ----------------------------------------------------------
    // PARTICIPANTS
    // ----------------------------------------------------------

    participants
      ..clear()
      ..addAll(
        item.participants.map(
          (participant) => ParticipantModel(
            entityId: participant.entity.id,
            name: participant.entity.name,
            amount: participant.participant.allocatedAmount,
            percentage: participant.participant.allocationPercentage ?? 0,
          ),
        ),
      );

    // ----------------------------------------------------------
    // SHARED STATE
    // ----------------------------------------------------------

    isSharedExpense.value =
        paidBy.value == PaidBy.self && participants.length > 1;

    // ----------------------------------------------------------
    // SPLIT MODE
    // ----------------------------------------------------------

    _inferSplitMode();
  }
  // void loadSpendTransaction(TransactionWithDetails item) {
  //   editingTransaction.value = item;

  //   /// BASIC

  //   selectedDate.value = item.transaction.date;

  //   selectedCategory.value = item.category;

  //   selectedAccount.value = item.account;

  //   amount.value = item.transaction.amount;

  //   amountController.text = item.transaction.amount.toCurrency();

  //   /// SPLIT PARTICIPANTS
  //   participants.clear();

  //   participants.value = item.participants.map((participant) {
  //     return ParticipantModel(
  //       entityId: participant.entity.id,

  //       name: participant.entity.name,

  //       amount: participant.participant.allocatedAmount,

  //       percentage: participant.participant.allocationPercentage ?? 0,
  //     );
  //   }).toList();

  //   /// SHARED STATE

  //   isSharedExpense.value = participants.length > 1;

  //   /// SPLIT MODE

  //   _inferSplitMode();
  // }

  void _inferSplitMode() {
    if (participants.isEmpty) {
      splitMode.value = SplitMode.equal;

      return;
    }

    final firstAmount = participants.first.amount.value;

    final allEqual = participants.every(
      (participant) => participant.amount.value == firstAmount,
    );

    splitMode.value = allEqual ? SplitMode.equal : SplitMode.custom;
  }

  void loadTransferTransaction(TransactionWithDetails item) {
    editingTransaction.value = item;
    selectedDate.value = item.transaction.date;
    selectedAccount.value = item.account;
    selectedLinkedAccount.value = item.linkedAccount;
    amount.value = item.transaction.amount;
    amountController.text = item.transaction.amount.toCurrency();
  }
}
