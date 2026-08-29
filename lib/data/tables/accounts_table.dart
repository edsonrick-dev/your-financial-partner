import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_group_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/balance_sheet_type_enum.dart';

class AccountsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get icon => text()();

  TextColumn get accountType => text()();

  RealColumn get currentValue => real().withDefault(const Constant(0))();

  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();

  RealColumn get creditLimit => real().nullable()();
}

extension AccountExtensions on AccountsTableData {
  AccountType get type => AccountType.fromName(accountType);

  AccountGroup get group => type.group;

  bool get isAsset => type.isAsset;

  bool get isLiability => type.isLiability;

  BalanceSheetType get balanceSheetType => type.balanceSheetType;
  double? get availableCredit {
    if (type != AccountType.creditCard) return null;
    if (creditLimit == null) return null;

    return creditLimit! + currentValue;
  }

  double? get creditUtilization {
    if (type != AccountType.creditCard) return null;
    if (creditLimit == null || creditLimit == 0) return null;

    return (-currentValue) / creditLimit!;
  }

  double get availableForPayment {
    if (type == AccountType.creditCard) {
      return availableCredit ?? 0;
    }

    return currentValue;
  }
}
