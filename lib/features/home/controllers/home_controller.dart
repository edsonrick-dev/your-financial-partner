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

  void nextMonth() {
    final current = selectedMonth.value;
    selectedMonth.value = DateTime(current.year, current.month + 1);
  }

  void setMonth(DateTime month) {
    selectedMonth.value = DateTime(month.year, month.month);
  }
}

class MonthlyCashFlowSummary {
  final double income;
  final double expenses;
  final double savings;

  const MonthlyCashFlowSummary({
    required this.income,
    required this.expenses,
    required this.savings,
  });

  double get netCashFlow => income - expenses;
}
