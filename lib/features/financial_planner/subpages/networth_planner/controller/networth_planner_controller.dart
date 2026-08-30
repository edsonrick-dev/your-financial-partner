import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/models/person_balance_summary_model.dart';
import 'package:getx_drift_app/domain/enums/net_worth_comparison_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_group_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/balance_sheet_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/models/net_worth_item.dart';

class NetWorthController extends GetxController {
  bool get isEmpty => assetAccounts.isEmpty && liabilityAccounts.isEmpty;
  bool get hasAssets => assetAccounts.isNotEmpty;

  bool get hasLiabilities => liabilityAccounts.isNotEmpty;

  bool get hasAccounts => hasAssets || hasLiabilities;
  Future<void> deleteAccount(AccountsTableData account) async {
    await database.accountsDao.deleteAccount(account.id);
  }

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
  final peopleBalances = <PersonBalanceSummary>[].obs;

  @override
  void onInit() {
    super.onInit();
    calculateBaselineNetWorth();
    accounts.bindStream(database.accountsDao.watchAccounts());
    peopleBalances.bindStream(
      database.peopleBalanceDao.watchPeopleBalances(includeSettled: false),
    );
  }

  List<NetWorthItem> get accountNetWorthItems {
    return accounts.map((account) {
      final accountType = AccountType.fromName(account.accountType);

      return NetWorthItem(
        id: 'account_${account.id}',
        name: account.name,
        value: account.currentValue,
        source: NetWorthItemSource.account,
        group: accountType.group,
        account: account,
      );
    }).toList();
  }

  List<NetWorthItem> get personalBalanceNetWorthItems {
    return peopleBalances.map((person) {
      final isReceivable = person.netBalance > 0;

      return NetWorthItem(
        id: 'personal_balance_${person.entity.id}',
        name: person.entity.name,
        value: person.netBalance.abs(),
        source: NetWorthItemSource.personalBalance,
        group: isReceivable ? AccountGroup.receivable : AccountGroup.payable,
        personBalance: person,
      );
    }).toList();
  }

  List<NetWorthItem> get netWorthItems {
    return [...accountNetWorthItems, ...personalBalanceNetWorthItems];
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

  List<NetWorthItem> get displayedItems {
    return selectedView.value == BalanceSheetType.asset
        ? netWorthItems.where((item) => item.isAsset).toList()
        : netWorthItems.where((item) => item.isLiability).toList();
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
    return netWorthItems
        .where((item) => item.isAsset)
        .fold<double>(0, (sum, item) => sum + item.value);
  }

  double get totalLiabilities {
    return netWorthItems
        .where((item) => item.isLiability)
        .fold<double>(0, (sum, item) => sum + item.value);
  }

  double get netWorth {
    return totalAssets - totalLiabilities;
  }

  // ------------------------------------------------------------
  // GROUPED ASSETS
  // ------------------------------------------------------------

  Map<AccountGroup, List<NetWorthItem>> get groupedAssetItems {
    final grouped = <AccountGroup, List<NetWorthItem>>{};

    for (final item in netWorthItems.where((item) => item.isAsset)) {
      grouped.putIfAbsent(item.group, () => []);
      grouped[item.group]!.add(item);
    }

    return grouped;
  }

  // ------------------------------------------------------------
  // GROUPED LIABILITIES
  // ------------------------------------------------------------
  Map<AccountGroup, List<NetWorthItem>> get groupedLiabilityItems {
    final grouped = <AccountGroup, List<NetWorthItem>>{};

    for (final item in netWorthItems.where((item) => item.isLiability)) {
      grouped.putIfAbsent(item.group, () => []);
      grouped[item.group]!.add(item);
    }

    return grouped;
  }

  // ------------------------------------------------------------
  // GROUP LABELS
  // ------------------------------------------------------------
  Map<AccountGroup, double> get displayedGroupTotals {
    final totals = <AccountGroup, double>{};

    final items = selectedView.value == BalanceSheetType.asset
        ? groupedAssetItems
        : groupedLiabilityItems;

    for (final entry in items.entries) {
      totals[entry.key] = entry.value.fold<double>(
        0,
        (sum, item) => sum + item.value,
      );
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
