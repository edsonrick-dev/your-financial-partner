import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';

@DataClassName('UserInsurancePolicy')
@TableIndex(
  name: 'unique_product_policy_number',
  columns: {#productId, #policyNumber},
  unique: true,
)
class UserInsurancePolicyTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer()();

  TextColumn get policyNumber => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  IntColumn get advisorId => integer().nullable()();

  DateTimeColumn get dateIssued => dateTime().nullable()();

  IntColumn get userId => integer().nullable()();

  IntColumn get productVariantId => integer().nullable()();

  IntColumn get paymentSchedule => intEnum<BillsFrequency>()();

  @override
  String get tableName => 'user_insurance_policy';
}
