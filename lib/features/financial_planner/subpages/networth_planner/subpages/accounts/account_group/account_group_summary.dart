import 'package:getx_drift_app/organize_THIS/net_worth_item.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';

class AccountGroupSummary {
  final AccountGroup group;
  final List<NetWorthItem> items;

  const AccountGroupSummary({required this.group, required this.items});

  double get total {
    return items.fold(0, (sum, item) => sum + item.value);
  }
}
