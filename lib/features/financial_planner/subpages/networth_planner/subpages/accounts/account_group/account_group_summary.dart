import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';

class AccountGroupSummary {
  final AccountGroup group;
  final List<AccountsTableData> accounts;

  const AccountGroupSummary({required this.group, required this.accounts});

  double get total {
    return accounts.fold(0, (sum, account) => sum + account.currentValue);
  }
}
