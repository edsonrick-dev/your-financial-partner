import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';

@DataClassName('UserInsurancePolicy')
class UserInsurancePolicyTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer()();

  TextColumn get policyNumber => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  IntColumn get advisorId => integer().nullable()();

  DateTimeColumn get dateIssued => dateTime().nullable()();

  IntColumn get userId => integer()();

  IntColumn get productVariantId => integer().nullable()();

  IntColumn get paymentSchedule => intEnum<BillsFrequency>()();

  @override
  String get tableName => 'user_insurance_policy';
}
