import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class LoanController extends GetxController {
  Future<void> updatePaymentSchedule({required int loanAccountId}) async {
    if (!paymentScheduleEnabled.value) return;

    if (paymentAmount.value <= 0 || paymentFrequency.value == null) {
      return;
    }

    await database.billsDao.updateLoanBill(
      loanAccountId: loanAccountId,
      paymentAmount: paymentAmount.value,
      frequency: paymentFrequency.value!,
      firstPaymentDate: firstPaymentDate.value,
      reminderEnabled: reminderEnabled.value,
      reminderDaysBefore: reminderDaysBefore.value,
    );
  }

  Future<void> initializeLoanEdit(AccountsTableData account) async {
    resetPaymentSchedule();

    final bill = await database.billsDao.getLoanBillForAccount(account.id);

    if (bill == null) {
      paymentScheduleEnabled.value = false;
      return;
    }

    final occurrences = await database.billsDao.getOccurrencesForBill(bill.id);

    if (occurrences.isEmpty) {
      paymentScheduleEnabled.value = false;
      return;
    }

    final firstOccurrence = occurrences.first;

    paymentScheduleEnabled.value = true;

    paymentAmount.value = bill.expectedAmount;

    paymentFrequency.value = BillsFrequency.values.firstWhere(
      (frequency) => frequency.name == bill.frequency,
    );

    firstPaymentDate.value = firstOccurrence.dueDate;

    reminderEnabled.value = bill.reminderEnabled;

    reminderDaysBefore.value = bill.reminderDaysBefore;
  }

  int? calculateNumberOfPayments(double balance) {
    final payment = paymentAmount.value;

    if (balance <= 0 || payment <= 0) {
      return null;
    }

    return (balance / payment).ceil();
  }

  DateTime? calculateFinalPaymentDate(double balance) {
    final payments = calculateNumberOfPayments(balance);
    final firstDate = firstPaymentDate.value;
    final frequency = paymentFrequency.value;

    if (payments == null || frequency == null) {
      return null;
    }

    final intervals = payments - 1;

    switch (frequency) {
      case BillsFrequency.monthly:
        return _addMonths(firstDate, intervals);

      case BillsFrequency.quarterly:
        return _addMonths(firstDate, intervals * 3);

      case BillsFrequency.semiAnnual:
        return _addMonths(firstDate, intervals * 6);

      case BillsFrequency.annual:
        return _addMonths(firstDate, intervals * 12);

      default:
        return null;
    }
  }

  DateTime _addMonths(DateTime date, int months) {
    final targetMonth = date.month - 1 + months;

    final year = date.year + targetMonth ~/ 12;
    final month = targetMonth % 12 + 1;

    final lastDayOfMonth = DateTime(year, month + 1, 0).day;

    final day = math.min(date.day, lastDayOfMonth);

    return DateTime(year, month, day);
  }

  Future<void> savePaymentSchedule({required int loanAccountId}) async {
    if (!paymentScheduleEnabled.value) return;

    debugPrint('${paymentAmount.value}');
    debugPrint('${paymentFrequency.value}');
    if (paymentAmount.value <= 0 || paymentFrequency.value == null) {
      return;
    }
    debugPrint('Form Created');
    final loan = await database.accountsDao.getAccountById(loanAccountId);

    if (loan == null) return;

    await database.billsDao.insertLoanBill(
      loanAccountId: loanAccountId,
      name: '${loan.name} Payment',
      paymentAmount: paymentAmount.value,
      frequency: paymentFrequency.value!,
      firstPaymentDate: firstPaymentDate.value,
      reminderEnabled: reminderEnabled.value,
      reminderDaysBefore: reminderDaysBefore.value,
    );
    resetForm();
  }

  void resetForm() {
    paymentScheduleEnabled.value = true;
    paymentAmount.value = 0;
    paymentFrequency.value = BillsFrequency.monthly;
    firstPaymentDate.value = DateTime.now();
    reminderEnabled.value = false;
    reminderDaysBefore.value = null;
  }
  // ============================================================
  // PAYMENT SCHEDULE
  // ============================================================

  final paymentScheduleEnabled = true.obs;

  final paymentAmount = 0.0.obs;

  final Rxn<BillsFrequency> paymentFrequency = Rxn<BillsFrequency>(
    BillsFrequency.monthly,
  );

  Rx<DateTime> firstPaymentDate = DateTime.now().obs;
  // ============================================================
  // REMINDER
  // ============================================================

  final reminderEnabled = false.obs;

  final reminderDaysBefore = Rxn<int>();

  // ============================================================
  // FORMATTING
  // ============================================================

  String? get formattedFirstPaymentDate {
    final date = firstPaymentDate.value;

    return DateFormat('MMMM d, yyyy').format(date);
  }

  // ============================================================
  // PAYMENT SCHEDULE
  // ============================================================

  void setPaymentScheduleEnabled(bool value) {
    paymentScheduleEnabled.value = value;

    if (!value) {
      resetPaymentSchedule();
    }
  }

  void setPaymentAmount(double value) {
    paymentAmount.value = value;
  }

  void setPaymentFrequency(BillsFrequency value) {
    paymentFrequency.value = value;
  }

  void setFirstPaymentDate(DateTime value) {
    firstPaymentDate.value = value;
  }

  // ============================================================
  // REMINDER
  // ============================================================

  void setReminderEnabled(bool value) {
    reminderEnabled.value = value;

    if (value) {
      reminderDaysBefore.value ??= 3;
    } else {
      reminderDaysBefore.value = null;
    }
  }

  void setReminderDaysBefore(int value) {
    reminderDaysBefore.value = value;
  }

  // ============================================================
  // VALIDATION
  // ============================================================

  bool get isPaymentScheduleValid {
    if (!paymentScheduleEnabled.value) {
      return true;
    }

    return paymentAmount.value > 0 && paymentFrequency.value != null;
  }

  // ============================================================
  // RESET
  // ============================================================

  void resetPaymentSchedule() {
    paymentAmount.value = 0;
    paymentFrequency.value = BillsFrequency.monthly;
    firstPaymentDate.value = DateTime.now();
    reminderEnabled.value = false;
    reminderDaysBefore.value = null;
  }
}
