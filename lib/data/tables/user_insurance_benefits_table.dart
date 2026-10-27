import 'package:drift/drift.dart';
import 'insurance_benefits_table.dart';
import 'user_insurance_policy_table.dart';

@DataClassName('UserInsuranceBenefit')
class UserInsuranceBenefitsTable extends Table {
  // Local Drift primary key.
  IntColumn get id => integer().autoIncrement()();

  // Remote Supabase user_insurance_benefits.id.
  IntColumn get supabaseId => integer().nullable().unique()();

  // Local InsuranceBenefitsTable.id.
  IntColumn get benefitId =>
      integer().references(InsuranceBenefitsTable, #id)();

  // Local UserInsurancePolicyTable.id.
  IntColumn get userPolicyId => integer().references(
    UserInsurancePolicyTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  // Coverage amount for this policy benefit.
  RealColumn get amount => real()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  // Local sync status.
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  String get tableName => 'user_insurance_benefits';
}
