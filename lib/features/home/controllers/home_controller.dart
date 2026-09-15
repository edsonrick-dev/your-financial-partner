import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';

class HomeController extends GetxController {
  String get timeBasedGreeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    }

    if (hour < 18) {
      return 'Good afternoon';
    }

    return 'Good evening';
  }

  final GetStorage _storage = GetStorage();

  static const _userNameKey = 'user_name';

  final userName = ''.obs;

  final isFundHidden = false.obs;
  final RxBool hasAccounts = false.obs;
  void toggleIsFundHidden() {
    isFundHidden.toggle();
  }

  late final StreamSubscription _accountSubscription;

  @override
  void onInit() {
    super.onInit();
    userName.value = _storage.read<String>(_userNameKey) ?? '';
    _accountSubscription = database.accountsDao.watchAccounts().listen((
      accounts,
    ) {
      hasAccounts.value = accounts.isNotEmpty;
    });
  }

  @override
  void onClose() {
    _accountSubscription.cancel();
    super.onClose();
  }

  final selectedMonth = DateTime.now().obs;

  final availableFundsStream = database.accountsDao.watchAvailableFunds();

  Stream<MonthlyCashFlowSummary> get monthlySummaryStream =>
      database.transactionsDao.watchMonthlySummary(month: selectedMonth.value);
  Stream<List<MonthlyCashFlowTrend>> get monthlyTrendStream =>
      database.transactionsDao.watchMonthlyTrend(endMonth: selectedMonth.value);
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

class MonthlyCashFlowTrend {
  MonthlyCashFlowTrend({
    required this.month,
    this.inflow = 0,
    this.outflow = 0,
  });

  final DateTime month;

  double inflow;
  double outflow;

  double get netCashFlow => inflow - outflow;
}
