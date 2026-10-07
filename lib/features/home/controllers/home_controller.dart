import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';

class HomeController extends GetxController {
  final userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    userName.value = _storage.read<String>(_userNameKey) ?? '';
    _accountSubscription = database.accountsDao.watchAccounts().listen((
      accounts,
    ) {
      hasAccounts.value = accounts.isNotEmpty;
    });
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final profile = await database.userProfileDao.getProfile();

    userName.value = profile?.name?.trim() ?? '';
  }

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

  final isFundHidden = false.obs;
  final RxBool hasAccounts = false.obs;
  void toggleIsFundHidden() {
    isFundHidden.toggle();
  }

  late final StreamSubscription _accountSubscription;

  @override
  void onClose() {
    _accountSubscription.cancel();
    super.onClose();
  }

  final availableFundsStream = database.accountsDao.watchAvailableFunds();
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
