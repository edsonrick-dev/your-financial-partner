import 'package:drift/drift.dart';

import 'bills_table.dart';
import 'user_insurance_policy_table.dart';

class InsurancePremiumBillsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userPolicyId => integer().unique().references(
    UserInsurancePolicyTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  IntColumn get billId => integer().unique().references(
    BillsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'insurance_premium_bills';
}
