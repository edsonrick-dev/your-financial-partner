import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_group_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/models/net_worth_item.dart';

class AccountGroupSummary {
  final AccountGroup group;
  final List<NetWorthItem> items;

  const AccountGroupSummary({required this.group, required this.items});

  double get total {
    return items.fold(0, (sum, item) => sum + item.value);
  }
}
