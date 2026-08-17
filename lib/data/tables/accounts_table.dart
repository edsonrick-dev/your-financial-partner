import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';

class AccountsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get icon => text()();

  TextColumn get accountType => text()();

  RealColumn get currentValue => real().withDefault(const Constant(0))();

  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();
}

extension AccountExtensions on AccountsTableData {
  AccountType get type => AccountType.fromName(accountType);

  AccountGroup get group => type.group;

  bool get isAsset => type.isAsset;

  bool get isLiability => type.isLiability;

  BalanceSheetType get balanceSheetType => type.balanceSheetType;
}
