import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';

class HomeController extends GetxController {
  final isFundHidden = false.obs;

  void toggleIsFundHidden() {
    isFundHidden.toggle();
  }

  final selectedMonth = DateTime.now().obs;

  final availableFundsStream = database.accountsDao.watchAvailableFunds();

  Stream<MonthlyCashFlowSummary> get monthlySummaryStream =>
      database.transactionsDao.watchMonthlySummary(month: selectedMonth.value);

  void previousMonth() {
    final current = selectedMonth.value;
    selectedMonth.value = DateTime(current.year, current.month - 1);
  }

  bool get canGoNext {
    final now = DateTime.now();
    final selected = selectedMonth.value;

    return selected.year < now.year ||
        (selected.year == now.year && selected.month < now.month);
  }

  void nextMonth() {
    if (!canGoNext) return;

    final current = selectedMonth.value;
    selectedMonth.value = DateTime(current.year, current.month + 1);
  }

  void setMonth(DateTime month) {
    selectedMonth.value = DateTime(month.year, month.month);
  }

  bool get isCurrentMonth {
    final now = DateTime.now();

    return selectedMonth.value.year == now.year &&
        selectedMonth.value.month == now.month;
  }

  void goToCurrentMonth() {
    selectedMonth.value = DateTime.now();
  }
}

class MonthlyCashFlowSummary {
  final double totalIn;
  final double totalOut;

  const MonthlyCashFlowSummary({required this.totalIn, required this.totalOut});

  double get netCashFlow => totalIn - totalOut;
}
