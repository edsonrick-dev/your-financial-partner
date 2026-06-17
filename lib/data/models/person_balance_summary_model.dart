import 'package:getx_drift_app/data/app_database.dart';

class PersonBalanceSummary {
  final EntitiesTableData entity;

  final double receivable;
  final double payable;

  double get netBalance => receivable - payable;
  double get balanceAmount => netBalance.abs();

  bool get owesMe => netBalance > 0;
  bool get iOwe => netBalance < 0;
  bool get isSettled => netBalance.abs() < 0.01;

  const PersonBalanceSummary({
    required this.entity,
    required this.receivable,
    required this.payable,
  });
}
