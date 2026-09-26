import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/models/participant_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/domain/enums/paid_by.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';

extension LoadSpendTransaction on TransactionController {
  void loadSpendTransaction(TransactionWithDetails item) async {
    editingTransaction.value = item;

    // BASIC
    selectedDate.value = item.transaction.date;
    amount.value = item.transaction.amount;
    amountController.text = item.transaction.amount.toCurrency();
    // ----------------------------------------------------------
    // BILL / CATEGORY
    // ----------------------------------------------------------

    if (item.isBillPayment &&
        item.bill != null &&
        item.billOccurrence != null) {
      selectedBill.value = BillWithNextOccurrence(
        bill: item.bill!,
        occurrence: item.billOccurrence!,
        category: item.category,
        loanAccount: item.linkedAccount,
      );

      selectedCategory.value = null;
    } else {
      selectedBill.value = null;
      selectedCategory.value = item.category;
    }

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

    inferSplitMode();
  }
}
