import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/models/person_balance_summary_model.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';

class NetWorthItem {
  final String id;
  final String name;
  final double value;
  final NetWorthItemSource source;
  final AccountGroup group;

  final AccountsTableData? account;
  final PersonBalanceSummary? personBalance;

  const NetWorthItem({
    required this.id,
    required this.name,
    required this.value,
    required this.source,
    required this.group,
    this.account,
    this.personBalance,
  });

  bool get isAsset => group.isAsset;

  bool get isLiability => group.isLiability;
}

enum NetWorthItemSource { account, personalBalance }
