import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/user_insurance_policy_table.dart';

@DataClassName('PremiumDetail')
class PremiumDetailsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userPolicyId =>
      integer().nullable().references(UserInsurancePolicyTable, #id)();

  IntColumn get offerPolicyId => integer().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  RealColumn get monthly => real().nullable()();

  RealColumn get quarterly => real().nullable()();

  RealColumn get semiAnnual => real().nullable()();

  RealColumn get annual => real().nullable()();

  @override
  String get tableName => 'premium_details';
}
