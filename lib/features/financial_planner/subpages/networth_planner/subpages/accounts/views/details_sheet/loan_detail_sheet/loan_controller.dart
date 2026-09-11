import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:intl/intl.dart';

class LoanController extends GetxController {
  Future<void> savePaymentSchedule({required int loanAccountId}) async {
    if (!paymentScheduleEnabled.value) return;

    if (paymentAmount.value <= 0 || paymentFrequency.value == null) {
      return;
    }

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
    paymentScheduleEnabled.value == false;
    paymentAmount.value == 0;
    paymentFrequency.value == BillsFrequency.monthly;
    firstPaymentDate.value == DateTime.now();
  }
  // ============================================================
  // PAYMENT SCHEDULE
  // ============================================================

  final paymentScheduleEnabled = false.obs;

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
