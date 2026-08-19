import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/domain/enums/net_worth_comparison_enum.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';

class NetWorthController extends GetxController {
  final netWorthComparison = NetWorthComparison.mtd.obs;

  DateTime get baselineDate {
    final now = DateTime.now();

    switch (netWorthComparison.value) {
      case NetWorthComparison.wtd:
        // End of previous week
        final startOfThisWeek = DateTime(
          now.year,
          now.month,
          now.day,
        ).subtract(Duration(days: now.weekday - DateTime.monday));

        return startOfThisWeek.subtract(const Duration(seconds: 1));

      case NetWorthComparison.mtd:
        // End of previous month
        return DateTime(
          now.year,
          now.month,
          1,
        ).subtract(const Duration(seconds: 1));

      case NetWorthComparison.ytd:
        // End of previous year
        return DateTime(now.year, 1, 1).subtract(const Duration(seconds: 1));
    }
  }

  final baselineNetWorth = 0.0.obs;
  Future<void> calculateBaselineNetWorth() async {
    final date = baselineDate;

    final value = await database.accountsDao.calculateNetWorthAt(date);

    baselineNetWorth.value = value;
  }

  void setNetWorthComparison(NetWorthComparison value) {
    netWorthComparison.value = value;
    calculateBaselineNetWorth();
  }

  final seletectedDetailsTabIndex = 0.obs;
  double get assetRatio {
    final total = totalAssets + totalLiabilities;

    if (total == 0) return 0;

    return totalAssets / total;
  }

  double get liabilityRatio {
    final total = totalAssets + totalLiabilities;

    if (total == 0) return 0;

    return totalLiabilities / total;
  }

  double get netWorthRatio {
    if (totalAssets <= 0) return 0;

    return (netWorth / totalAssets).clamp(0.0, 1.0);
  }

  final accounts = <AccountsTableData>[].obs;

  @override
  void onInit() {
    super.onInit();
    calculateBaselineNetWorth();
    accounts.bindStream(database.accountsDao.watchAccounts());
  }

  final selectedView = BalanceSheetType.asset.obs;

  void selectBalanceSheetType(BalanceSheetType type) {
    selectedView.value = type;
  }

  List<AccountsTableData> get displayedAccounts {
    switch (selectedView.value) {
      case BalanceSheetType.asset:
        return assetAccounts;

      case BalanceSheetType.liability:
        return liabilityAccounts;
    }
  }
  // ------------------------------------------------------------
  // ASSETS
  // ------------------------------------------------------------

  List<AccountsTableData> get assetAccounts {
    return accounts.where((account) {
      final type = AccountType.fromName(account.accountType);

      return type.isAsset;
    }).toList();
  }

  // ------------------------------------------------------------
  // LIABILITIES
  // ------------------------------------------------------------

  List<AccountsTableData> get liabilityAccounts {
    return accounts.where((account) {
      final type = AccountType.fromName(account.accountType);

      return type.isLiability;
    }).toList();
  }

  // ------------------------------------------------------------
  // TOTALS
  // ------------------------------------------------------------

  double get totalAssets {
    return assetAccounts.fold<double>(
      0,
      (sum, account) => sum + account.currentValue,
    );
  }

  double get totalLiabilities {
    return liabilityAccounts.fold<double>(
      0,
      (sum, account) => sum + account.currentValue.abs(),
    );
  }

  double get netWorth {
    return totalAssets - totalLiabilities;
  }

  // ------------------------------------------------------------
  // GROUPED ASSETS
  // ------------------------------------------------------------

  Map<AccountGroup, List<AccountsTableData>> get groupedAssetAccounts {
    final grouped = <AccountGroup, List<AccountsTableData>>{};

    for (final account in assetAccounts) {
      final type = AccountType.fromName(account.accountType);

      grouped.putIfAbsent(type.group, () => []);
      grouped[type.group]!.add(account);
    }

    return grouped;
  }

  // ------------------------------------------------------------
  // GROUPED LIABILITIES
  // ------------------------------------------------------------

  Map<AccountGroup, List<AccountsTableData>> get groupedLiabilityAccounts {
    final grouped = <AccountGroup, List<AccountsTableData>>{};

    for (final account in liabilityAccounts) {
      final type = AccountType.fromName(account.accountType);

      grouped.putIfAbsent(type.group, () => []);
      grouped[type.group]!.add(account);
    }

    return grouped;
  }

  // ------------------------------------------------------------
  // GROUP LABELS
  // ------------------------------------------------------------

  Map<AccountGroup, double> get displayedGroupTotals {
    final totals = <AccountGroup, double>{};

    final accounts = selectedView.value == BalanceSheetType.asset
        ? assetAccounts
        : liabilityAccounts;

    for (final account in accounts) {
      final type = AccountType.fromName(account.accountType);

      totals[type.group] =
          (totals[type.group] ?? 0) + account.currentValue.abs();
    }

    return totals;
  }

  double get displayedTotal {
    return selectedView.value == BalanceSheetType.asset
        ? totalAssets
        : totalLiabilities;
  }

  double groupPercentage(AccountGroup group) {
    if (displayedTotal == 0) return 0;

    return (displayedGroupTotals[group] ?? 0) / displayedTotal;
  }
}
